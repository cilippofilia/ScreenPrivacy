//
//  ScreenPrivacyShieldModifier.swift
//  ScreenPrivacy
//
//  Created by Filippo Cilia on 03/20/2026.
//

import SwiftUI
import UIKit

/// Applies a privacy shield and observes lifecycle/capture changes.
struct ScreenPrivacyShieldModifier<Shield: View>: ViewModifier {
    @Environment(\.scenePhase) private var scenePhase

    private let isEnabled: Bool
    private let includeCaptureDetection: Bool
    private let shield: () -> Shield

    @State private var monitor = ScreenPrivacyMonitor()

    /// Creates a modifier that can overlay a shield when needed.
    init(
        isEnabled: Bool,
        includeCaptureDetection: Bool,
        shield: @escaping () -> Shield
    ) {
        self.isEnabled = isEnabled
        self.includeCaptureDetection = includeCaptureDetection
        self.shield = shield
    }

    func body(content: Content) -> some View {
        let base = ZStack {
            content
                .privacySensitive()

            if monitor.isShieldVisible {
                shield()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: monitor.isShieldVisible)
        .onChange(of: scenePhase) { _, newValue in
            monitor.update(scenePhase: newValue)
        }
        .onChange(of: isEnabled) { _, newValue in
            monitor.updateConfiguration(
                isEnabled: newValue,
                includeCaptureDetection: includeCaptureDetection
            )
        }
        .onChange(of: includeCaptureDetection) { _, newValue in
            monitor.updateConfiguration(
                isEnabled: isEnabled,
                includeCaptureDetection: newValue
            )
            if newValue {
                monitor.refreshCaptureState()
            } else {
                monitor.update(isCaptured: false)
            }
        }
        .task {
            monitor.updateConfiguration(
                isEnabled: isEnabled,
                includeCaptureDetection: includeCaptureDetection
            )
            monitor.update(scenePhase: scenePhase)
            if includeCaptureDetection {
                monitor.refreshCaptureState()
            } else {
                monitor.update(isCaptured: false)
            }
        }

        if includeCaptureDetection {
            base.onReceive(
                NotificationCenter.default.publisher(
                    for: UIScreen.capturedDidChangeNotification
                )
            ) { _ in
                monitor.refreshCaptureState()
            }
        } else {
            base
        }
    }
}
