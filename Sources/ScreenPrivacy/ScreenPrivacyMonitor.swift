//
//  ScreenPrivacyMonitor.swift
//  ScreenPrivacy
//
//  Created by Filippo Cilia on 03/20/2026.
//

import Observation
import SwiftUI
import UIKit

/// Tracks app and capture state to decide when a privacy shield should be visible.
@MainActor
@Observable
final class ScreenPrivacyMonitor {
    private(set) var isShieldVisible = false

    private var isEnabled = true
    private var includeCaptureDetection = true
    private var scenePhase: ScenePhase = .active
    private var isCaptured = false

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

    /// Reads the current screen capture state from `UIScreen`.
    func refreshCaptureState() {
        isCaptured = UIScreen.main.isCaptured
        recomputeVisibility()
    }

    /// Computes whether the shield should be visible based on the current state.
    private func recomputeVisibility() {
        guard isEnabled else {
            isShieldVisible = false
            return
        }

        var shouldShow = scenePhase == .inactive
        if includeCaptureDetection {
            shouldShow = shouldShow || isCaptured
        }

        isShieldVisible = shouldShow
    }
}
