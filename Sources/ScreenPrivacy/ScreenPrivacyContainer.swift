//
//  ScreenPrivacyContainer.swift
//  ScreenPrivacy
//
//  Created by Filippo Cilia on 03/20/2026.
//

import SwiftUI

/// A container view that applies a privacy shield to its content.
///
/// Use this type when you prefer composition over a view modifier.
public struct ScreenPrivacyContainer<Content: View, Shield: View>: View {
    private let content: Content
    private let isEnabled: Bool
    private let includeCaptureDetection: Bool
    private let blocksScreenCapture: Bool
    private let shield: () -> Shield

    /// Creates a privacy container.
    ///
    /// - Parameters:
    ///   - isEnabled: A Boolean that controls whether the shield can appear.
    ///   - includeCaptureDetection: A Boolean that enables screen capture monitoring.
    ///   - blocksScreenCapture: A Boolean that enables secure rendering to block captures.
    ///   - content: The protected content.
    ///   - shield: A view builder that supplies the shield content.
    public init(
        isEnabled: Bool = true,
        includeCaptureDetection: Bool = true,
        blocksScreenCapture: Bool = true,
        @ViewBuilder content: () -> Content,
        @ViewBuilder shield: @escaping () -> Shield = { DefaultScreenPrivacyShieldView() }
    ) {
        self.isEnabled = isEnabled
        self.includeCaptureDetection = includeCaptureDetection
        self.blocksScreenCapture = blocksScreenCapture
        self.content = content()
        self.shield = shield
    }

    public var body: some View {
        content
            .screenPrivacyShield(
                isEnabled: isEnabled,
                includeCaptureDetection: includeCaptureDetection,
                blocksScreenCapture: blocksScreenCapture,
                shield: shield
            )
    }
}
