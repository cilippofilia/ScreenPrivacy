import SwiftUI
import Testing
@testable import ScreenPrivacy

@Test func shieldHiddenWhenActiveAndNotCaptured() async {
    let isVisible = await MainActor.run {
        let monitor = ScreenPrivacyMonitor()
        monitor.updateConfiguration(isEnabled: true, includeCaptureDetection: true)
        monitor.update(scenePhase: .active)
        monitor.update(isCaptured: false)
        return monitor.isShieldVisible
    }

    #expect(isVisible == false)
}

@Test func shieldVisibleWhenInactive() async {
    let isVisible = await MainActor.run {
        let monitor = ScreenPrivacyMonitor()
        monitor.updateConfiguration(isEnabled: true, includeCaptureDetection: true)
        monitor.update(scenePhase: .inactive)
        monitor.update(isCaptured: false)
        return monitor.isShieldVisible
    }

    #expect(isVisible == true)
}

@Test func shieldVisibleWhenCapturedAndDetectionEnabled() async {
    let isVisible = await MainActor.run {
        let monitor = ScreenPrivacyMonitor()
        monitor.updateConfiguration(isEnabled: true, includeCaptureDetection: true)
        monitor.update(scenePhase: .active)
        monitor.update(isCaptured: true)
        return monitor.isShieldVisible
    }

    #expect(isVisible == true)
}

@Test func shieldHiddenWhenCapturedButDetectionDisabled() async {
    let isVisible = await MainActor.run {
        let monitor = ScreenPrivacyMonitor()
        monitor.updateConfiguration(isEnabled: true, includeCaptureDetection: false)
        monitor.update(scenePhase: .active)
        monitor.update(isCaptured: true)
        return monitor.isShieldVisible
    }

    #expect(isVisible == false)
}
