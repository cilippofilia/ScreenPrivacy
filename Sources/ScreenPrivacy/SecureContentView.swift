//
//  SecureContentView.swift
//  ScreenPrivacy
//
//  Created by Filippo Cilia on 03/20/2026.
//

import SwiftUI
import UIKit

/// Wraps SwiftUI content in a secure UIKit container to prevent capture.
struct SecureContentView<Content: View>: UIViewRepresentable {
    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIView(context: Context) -> SecureContainerView {
        SecureContainerView()
    }

    func updateUIView(_ uiView: SecureContainerView, context: Context) {
        uiView.host(content: content)
    }
}

@MainActor
final class SecureContainerView: UIView {
    private let textField = SecureTextField()
    private var hostingController: UIHostingController<AnyView>?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func host<Content: View>(content: Content) {
        let hostedView = AnyView(content)
        if let hostingController {
            hostingController.rootView = hostedView
        } else {
            let controller = UIHostingController(rootView: hostedView)
            controller.view.backgroundColor = .clear
            hostingController = controller

            let hostedUIView = controller.view!
            hostedUIView.translatesAutoresizingMaskIntoConstraints = false
            textField.addSubview(hostedUIView)
            NSLayoutConstraint.activate([
                hostedUIView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
                hostedUIView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
                hostedUIView.topAnchor.constraint(equalTo: textField.topAnchor),
                hostedUIView.bottomAnchor.constraint(equalTo: textField.bottomAnchor)
            ])
        }
    }

    private func setup() {
        backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.backgroundColor = .clear
        textField.textColor = .clear
        textField.tintColor = .clear
        textField.text = " "

        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

final class SecureTextField: UITextField {
    override var canBecomeFirstResponder: Bool {
        false
    }
}
