<img src="Docs/Images/screenPrivacy_pill.svg" alt="ScreenPrivacy logo" width="40%" />

# ScreenPrivacy

[English](README.md) 🇬🇧 | [Italiano](Docs/README.it.md) 🇮🇹 | [Español](Docs/README.es.md) 🇪🇸 | [Français](Docs/README.fr.md) 🇫🇷 | [Deutsch](Docs/README.de.md) 🇩🇪 | [Русский](Docs/README.ru.md) 🇷🇺

`ScreenPrivacy` is a SwiftUI package for hiding sensitive screens when your app becomes inactive and, optionally, when screen capture is detected. It applies `privacySensitive()` to the protected content and can wrap that content in a secure UIKit-backed container when capture blocking is enabled.

## About

Use `ScreenPrivacy` when a view should not remain visible in app-switcher snapshots or during active capture. The package keeps onboarding simple:

- apply a single view modifier for the common case
- switch to a container when composition reads better in your view tree
- keep the default shield or provide your own custom shield view
- disable capture detection if you only care about inactive-scene shielding

## Installation

Add `ScreenPrivacy` as a Swift Package dependency in Xcode, or reference it from `Package.swift` during local development:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Then import it in any SwiftUI file that needs protection:

```swift
import ScreenPrivacy
import SwiftUI
```

## Quick Start

The smallest useful integration is the modifier:

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

This uses the default shield, enables capture detection, and enables secure rendering by default.

## Usage

Use a custom shield when the fallback UI should match your product language:

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield {
                VStack(spacing: 12) {
                    Image(systemName: "lock.shield")
                        .symbolRenderingMode(.hierarchical)
                        .imageScale(.large)
                        .font(.largeTitle)

                    Text("Private")
                        .font(.title2)
                        .bold()

                    Text("Hidden while this screen is not safe to show.")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.background)
                .foregroundStyle(.primary)
            }
    }
}
```

If you prefer composition over a modifier, use `ScreenPrivacyContainer`:

```swift
struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Configuration

`ScreenPrivacy` exposes three runtime controls:

| Option | Default | Effect |
| --- | --- | --- |
| `isEnabled` | `true` | Turns privacy shielding on or off. |
| `includeCaptureDetection` | `true` | Shows the shield when the screen is being captured. |
| `blocksScreenCapture` | `true` | Wraps content in the secure container used by the package on UIKit platforms. |

Example:

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield(
                isEnabled: true,
                includeCaptureDetection: false,
                blocksScreenCapture: true
            )
    }
}
```

## Behavior

The package visibility rules are intentionally small:

- if protection is disabled, the shield stays hidden
- if the scene becomes inactive, the shield becomes visible
- if capture detection is enabled and the screen is captured, the shield becomes visible
- protected content is marked with `privacySensitive()`
- shield presentation uses an opacity transition

On UIKit platforms, secure rendering is implemented with a secure text-field-backed container. In environments where UIKit is unavailable, the package falls back to a regular SwiftUI wrapper.

## When To Use It

`ScreenPrivacy` fits screens such as:

- account balances or payment details
- health or wellness data
- private notes, journals, or messages
- internal dashboards or operational tools

## Requirements

- iOS 17.0 or later
- macOS 14.0 or later
- Swift 6.0 or later

These values match the checked-in `Package.swift`.

## Package Structure

```text
ScreenPrivacy/
├── Sources/ScreenPrivacy/
│   ├── ScreenPrivacy.swift
│   ├── ScreenPrivacyContainer.swift
│   ├── ScreenPrivacyShieldModifier.swift
│   ├── ScreenPrivacyMonitor.swift
│   ├── SecureContentView.swift
│   └── DefaultScreenPrivacyShieldView.swift
├── Tests/ScreenPrivacyTests/
├── Docs/
└── Package.swift
```

## Testing

The package includes Swift Testing coverage for:

- inactive-scene shielding
- capture-driven shielding
- enable and disable recomputation
- capture-detection toggling
- injected capture-state providers

## License

[MIT](LICENSE)
