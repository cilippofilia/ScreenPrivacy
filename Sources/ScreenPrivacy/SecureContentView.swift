//
//  SecureContentView.swift
//  ScreenPrivacy
//
//  Created by Filippo Cilia on 03/20/2026.
//

import SwiftUI
#if canImport(UIKit)
import UIKit

/// Wraps SwiftUI content in a secure UIKit container to prevent capture.
struct SecureContentView<Content: View>: UIViewRepresentable {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .clear

        let secureTextField = SecureContainerTextField()
        secureTextField.isSecureTextEntry = true
        secureTextField.backgroundColor = .clear
        secureTextField.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(secureTextField)
        NSLayoutConstraint.activate([
            secureTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            secureTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            secureTextField.topAnchor.constraint(equalTo: containerView.topAnchor),
            secureTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        let hostingController = UIHostingController(rootView: content)
        hostingController.view.backgroundColor = .clear

        context.coordinator.secureTextField = secureTextField
        context.coordinator.hostingController = hostingController
        context.coordinator.attachHostedViewIfPossible()

        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        context.coordinator.hostingController?.rootView = content
        context.coordinator.attachHostedViewIfPossible()
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

extension SecureContentView {
    final class Coordinator {
        fileprivate weak var secureTextField: SecureContainerTextField?
        var hostingController: UIHostingController<Content>?

        func attachHostedViewIfPossible() {
            guard
                let secureTextField,
                let secureView = secureTextField.secureContentView,
                let hostedView = hostingController?.view
            else {
                return
            }

            if hostedView.superview !== secureView {
                hostedView.frame = secureView.bounds
                hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                secureView.addSubview(hostedView)
            }
        }
    }
}

fileprivate final class SecureContainerTextField: UITextField {
    var secureContentView: UIView? {
        subviews.first { subview in
            String(describing: subview).contains("UITextLayoutCanvasView")
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subview in subviews.reversed() {
            let convertedPoint = subview.convert(point, from: self)
            if let hitView = subview.hitTest(convertedPoint, with: event) {
                return hitView
            }
        }

        return nil
    }
}
#else
/// Fallback wrapper used when UIKit is unavailable during host-side testing.
struct SecureContentView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
    }
}
#endif
