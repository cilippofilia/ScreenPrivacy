import SwiftUI
import Testing
@testable import ScreenPrivacy

@Test func visibilityPrefersInactiveShieldingAsPrimaryRule() {
    let visibility = ScreenPrivacyVisibility(
        isEnabled: true,
        includeCaptureDetection: false,
        scenePhase: .inactive,
        isCaptured: false
    )

    #expect(visibility.isShieldVisible == true)
}

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

@Test func shieldRecomputesWhenEnabledStateChanges() async {
    let values = await MainActor.run {
        let monitor = ScreenPrivacyMonitor()
        monitor.updateConfiguration(isEnabled: false, includeCaptureDetection: true)
        monitor.update(scenePhase: .inactive)
        let hidden = monitor.isShieldVisible

        monitor.updateConfiguration(isEnabled: true, includeCaptureDetection: true)
        let visible = monitor.isShieldVisible

        return (hidden, visible)
    }

    #expect(values.0 == false)
    #expect(values.1 == true)
}

@Test func shieldRecomputesWhenCaptureDetectionChanges() async {
    let values = await MainActor.run {
        let monitor = ScreenPrivacyMonitor()
        monitor.updateConfiguration(isEnabled: true, includeCaptureDetection: false)
        monitor.update(scenePhase: .active)
        monitor.update(isCaptured: true)
        let hidden = monitor.isShieldVisible

        monitor.updateConfiguration(isEnabled: true, includeCaptureDetection: true)
        let visible = monitor.isShieldVisible

        return (hidden, visible)
    }

    #expect(values.0 == false)
    #expect(values.1 == true)
}

@Test func refreshCaptureStateUsesInjectedProvider() async {
    let isVisible = await MainActor.run {
        let monitor = ScreenPrivacyMonitor(captureStateProvider: { true })
        monitor.updateConfiguration(isEnabled: true, includeCaptureDetection: true)
        monitor.update(scenePhase: .active)
        monitor.refreshCaptureState()
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

@Test func shieldHiddenWhenDisabledEvenIfCapturedOrInactive() async {
    let isVisible = await MainActor.run {
        let monitor = ScreenPrivacyMonitor()
        monitor.updateConfiguration(isEnabled: false, includeCaptureDetection: true)
        monitor.update(scenePhase: .inactive)
        monitor.update(isCaptured: true)
        return monitor.isShieldVisible
    }

    #expect(isVisible == false)
}

@Test func shieldVisibleWhenInactiveEvenIfCaptureDetectionDisabled() async {
    let isVisible = await MainActor.run {
        let monitor = ScreenPrivacyMonitor()
        monitor.updateConfiguration(isEnabled: true, includeCaptureDetection: false)
        monitor.update(scenePhase: .inactive)
        monitor.update(isCaptured: false)
        return monitor.isShieldVisible
    }

    #expect(isVisible == true)
}
