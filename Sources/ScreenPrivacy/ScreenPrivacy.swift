//
//  ScreenPrivacy.swift
//  ScreenPrivacy
//
//  Created by Filippo Cilia on 03/20/2026.
//

import SwiftUI

/// Convenience APIs for applying a privacy shield to a view hierarchy.
public extension View {
    /// Adds a privacy shield that covers the view when the app becomes inactive or screen capture is detected.
    ///
    /// Use this modifier when you want to protect sensitive content from appearing in the app switcher
    /// or during screen capture. The shield view appears above the content and fades in and out.
    ///
    /// - Parameters:
    ///   - isEnabled: A Boolean that controls whether the shield can appear.
    ///   - includeCaptureDetection: A Boolean that enables screen capture monitoring.
    ///   - blocksScreenCapture: A Boolean that enables secure rendering to block captures.
    ///   - shield: A view builder that supplies the shield content.
    /// - Returns: A view that conditionally presents the privacy shield.
    func screenPrivacyShield<Shield: View>(
        isEnabled: Bool = true,
        includeCaptureDetection: Bool = true,
        blocksScreenCapture: Bool = true,
        @ViewBuilder shield: @escaping () -> Shield = { DefaultScreenPrivacyShieldView() }
    ) -> some View {
        modifier(
            ScreenPrivacyShieldModifier(
                isEnabled: isEnabled,
                includeCaptureDetection: includeCaptureDetection,
                blocksScreenCapture: blocksScreenCapture,
                shield: shield
            )
        )
    }
}
