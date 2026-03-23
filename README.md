# ScreenPrivacy

![ScreenPrivacy logo](Docs/Images/screenprivacy-logo.svg)

[English](README.md) 🇬🇧 | [Italiano](Docs/README.it.md) 🇮🇹 | [Español](Docs/README.es.md) 🇪🇸 | [Français](Docs/README.fr.md) 🇫🇷 | [Deutsch](Docs/README.de.md) 🇩🇪 | [Русский](Docs/README.ru.md) 🇷🇺

Protect sensitive SwiftUI screens with a privacy shield that appears when your app goes inactive and, optionally, when screen capture is detected. `ScreenPrivacy` also applies `privacySensitive()` and can host the protected content inside a secure container to make screenshots and recordings harder.

## Why ScreenPrivacy

- One-line protection for sensitive SwiftUI views.
- Safe app-switcher snapshots through inactive-scene shielding.
- Optional capture detection layered on top of inactive-scene behavior.
- Custom shield UI when you need branded or domain-specific messaging.
- Small public API with both modifier and container entry points.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Customization](#customization)
- [Behavior](#behavior)
- [When To Use It](#when-to-use-it)
- [Package Structure](#package-structure)
- [Tests](#tests)
- [FAQ](#faq)
- [License](#license)

## Requirements

- iOS 17.0 or later
- macOS 14.0 or later
- Swift 6.0 or later

These requirements match the checked-in `Package.swift`.

## Installation

Add `ScreenPrivacy` as a Swift Package dependency in Xcode or in `Package.swift`:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Then depend on the product and import it where you protect a view:

```swift
import ScreenPrivacy
import SwiftUI
```

## Quick Start

The default modifier is the fast path:

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

### Custom Shield

Use a custom shield when you want your own tone, colors, or layout:

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

### Container API

If you prefer composition over modifiers:

```swift
struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Customization

`ScreenPrivacy` keeps the API small:

| Option | Default | Purpose |
| --- | --- | --- |
| `isEnabled` | `true` | Turns the shield behavior on or off. |
| `includeCaptureDetection` | `true` | Adds capture-based shielding on top of inactive-scene shielding. |
| `blocksScreenCapture` | `true` | Uses a secure content container to make captures harder. |

Example with explicit configuration:

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

- Shows the shield when the scene becomes inactive.
- Can also show the shield when screen capture is detected.
- Applies `privacySensitive()` to the protected content.
- Uses a secure text-field-backed container when `blocksScreenCapture` is enabled on UIKit platforms.
- Animates shield presentation with an opacity transition.
- Falls back to a regular SwiftUI wrapper when UIKit is unavailable during host-side testing.

## When To Use It

`ScreenPrivacy` is a good fit when your app shows:

- account balances or payment details
- health or wellness data
- private notes, journals, or messages
- internal dashboards or operational tools
- anything that should not appear in app-switcher snapshots

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

## Tests

The package includes Swift Testing coverage for the core visibility rules and monitor behavior, including:

- inactive-scene shielding
- capture-driven shielding
- enable/disable recomputation
- capture detection toggling
- injected capture-state providers

## FAQ

**Does this block screenshots?**  
By default, it makes screenshots and recordings harder by hosting the protected content inside a secure container when `blocksScreenCapture` is `true`.

**Does it work in widgets or extensions?**  
It is designed for SwiftUI views inside your app. Widget timelines are out of scope.

**Can I add analytics or logging?**  
Yes. Wrap `ScreenPrivacyContainer` or the protected screen in your own lifecycle tracking without changing the package API.

**Should I always keep capture detection enabled?**  
Usually yes, but if your product only cares about app-switcher privacy, set `includeCaptureDetection` to `false`.

## License

[MIT](LICENSE)
