# ScreenPrivacy

[English](README.md) 🇬🇧 | [Italiano](Docs/README.it.md) 🇮🇹 | [Español](Docs/README.es.md) 🇪🇸 | [Français](Docs/README.fr.md) 🇫🇷 | [Deutsch](Docs/README.de.md) 🇩🇪 | [Русский](Docs/README.ru.md) 🇷🇺

Protect sensitive SwiftUI screens with a privacy shield that appears when your app goes inactive and, optionally, when screen capture is detected. `ScreenPrivacy` also enables secure rendering by default so protected content is harder to screenshot or record.

## Why ScreenPrivacy

- One-line protection for sensitive SwiftUI views.
- Safe app-switcher snapshots through inactive-scene shielding.
- Optional capture detection layered on top of the inactive-state behavior.
- Custom shield UI when you need branded or domain-specific messaging.
- Secure rendering enabled by default.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Customization](#customization)
- [Behavior](#behavior)
- [When To Use It](#when-to-use-it)
- [FAQ](#faq)
- [License](#license)

## Requirements

- iOS 17.0 or later
- Swift 6.0 or later

## Installation

Add `ScreenPrivacy` as a Swift Package dependency in Xcode or in `Package.swift`:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Then import it where you protect a view:

```swift
import ScreenPrivacy
import SwiftUI
```

## Quick Start

The default modifier is meant to be the fast path:

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
| `blocksScreenCapture` | `true` | Uses secure rendering to make screenshots and recordings harder. |

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
- Uses a secure text-field container when `blocksScreenCapture` is enabled.
- Animates shield presentation with an opacity transition.

## When To Use It

`ScreenPrivacy` is a good fit when your app shows:

- account balances or payment details
- health or wellness data
- private notes, journals, or messages
- internal dashboards or operational tools
- anything that should not appear in app-switcher snapshots

## FAQ

**Does this block screenshots?**  
Yes, by default. When `blocksScreenCapture` is `true`, the protected content is hosted inside a secure container.

**Does it work in widgets or extensions?**  
It is designed for SwiftUI views inside your app. Widget timelines are out of scope.

**Can I add analytics or logging?**  
Yes. Wrap `ScreenPrivacyContainer` or the protected screen in your own lifecycle tracking without changing the package API.

**Should I always keep capture detection enabled?**  
Usually yes, but if your product only cares about app-switcher privacy, set `includeCaptureDetection` to `false`.

## License

MIT
