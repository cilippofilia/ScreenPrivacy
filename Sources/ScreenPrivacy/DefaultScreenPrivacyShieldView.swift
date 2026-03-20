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
    public init() { }

    public var body: some View {
        VStack {
            Image(systemName: "eye.slash")
                .symbolRenderingMode(.hierarchical)
                .imageScale(.large)
                .font(.largeTitle)
                .foregroundStyle(.secondary)

            Text("Content Hidden")
                .font(.title2)
                .bold()
                .foregroundStyle(.primary)

            Text("This screen is protected for privacy.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Content hidden for privacy")
    }
}

#Preview {
    DefaultScreenPrivacyShieldView()
}
