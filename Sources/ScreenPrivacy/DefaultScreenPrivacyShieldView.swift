//
//  DefaultScreenPrivacyShieldView.swift
//  ScreenPrivacy
//
//  Created by Filippo Cilia on 03/20/2026.
//

import SwiftUI

/// The default privacy shield shown when sensitive content is hidden.
public struct DefaultScreenPrivacyShieldView: View {
    /// Creates the default privacy shield view.
    public init() {}

    public var body: some View {
        VStack {
            Image(systemName: "eye.slash")
                .symbolRenderingMode(.hierarchical)
                .imageScale(.large)
                .font(.largeTitle)
                .foregroundStyle(.white.opacity(0.8))

            Text("Content Hidden")
                .font(.title2)
                .bold()
                .foregroundStyle(.white)

            Text("This screen is protected for privacy.")
                .font(.subheadline)
                .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.black.ignoresSafeArea()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Content hidden for privacy")
    }
}

#Preview {
    DefaultScreenPrivacyShieldView()
}
