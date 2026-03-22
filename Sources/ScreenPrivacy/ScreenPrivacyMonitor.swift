//
//  ScreenPrivacyMonitor.swift
//  ScreenPrivacy
//
//  Created by Filippo Cilia on 03/20/2026.
//

import Observation
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Pure visibility rules used by the package and its tests.
struct ScreenPrivacyVisibility {
    let isEnabled: Bool
    let includeCaptureDetection: Bool
    let scenePhase: ScenePhase
    let isCaptured: Bool

    var isShieldVisible: Bool {
        guard isEnabled else {
            return false
        }

        if scenePhase == .inactive {
            return true
        }

        return includeCaptureDetection && isCaptured
    }
}

/// Tracks app and capture state to decide when a privacy shield should be visible.
@MainActor
@Observable
final class ScreenPrivacyMonitor {
    private let captureStateProvider: @MainActor () -> Bool

    private(set) var isShieldVisible = false

    private var isEnabled = true
    private var includeCaptureDetection = true
    private var scenePhase: ScenePhase = .active
    private var isCaptured = false

    init(captureStateProvider: @escaping @MainActor () -> Bool = ScreenPrivacyMonitor.defaultCaptureStateProvider) {
        self.captureStateProvider = captureStateProvider
    }

    /// Updates the monitoring configuration.
    ///
    /// - Parameters:
    ///   - isEnabled: A Boolean that controls whether the shield can appear.
    ///   - includeCaptureDetection: A Boolean that enables screen capture monitoring.
    func updateConfiguration(isEnabled: Bool, includeCaptureDetection: Bool) {
        self.isEnabled = isEnabled
        self.includeCaptureDetection = includeCaptureDetection
        recomputeVisibility()
    }

    /// Updates the scene phase that influences visibility.
    func update(scenePhase: ScenePhase) {
        self.scenePhase = scenePhase
        recomputeVisibility()
    }

    /// Updates the capture state used for visibility decisions.
    func update(isCaptured: Bool) {
        self.isCaptured = isCaptured
        recomputeVisibility()
    }

    /// Reads the current screen capture state from the current platform.
    func refreshCaptureState() {
        isCaptured = captureStateProvider()
        recomputeVisibility()
    }

    /// Computes whether the shield should be visible based on the current state.
    private func recomputeVisibility() {
        isShieldVisible = ScreenPrivacyVisibility(
            isEnabled: isEnabled,
            includeCaptureDetection: includeCaptureDetection,
            scenePhase: scenePhase,
            isCaptured: isCaptured
        ).isShieldVisible
    }

    private static func defaultCaptureStateProvider() -> Bool {
        #if canImport(UIKit)
        UIScreen.main.isCaptured
        #else
        false
        #endif
    }
}
