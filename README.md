# ScreenPrivacy

[English](README.md) 🇬🇧 | [Italiano](Docs/README.it.md) 🇮🇹 | [Español](Docs/README.es.md) 🇪🇸 | [Français](Docs/README.fr.md) 🇫🇷 | [Deutsch](Docs/README.de.md) 🇩🇪 | [Русский](Docs/README.ru.md) 🇷🇺

ScreenPrivacy provides a lightweight SwiftUI privacy shield that automatically covers sensitive views when your app goes inactive or when screen capture is detected. It also enables secure rendering by default, which prevents screenshots and screen recordings of the protected content. It is designed to be a one-line add-on that keeps your UI clean, testable, and respectful of user privacy.

Useful usecases:
- You show account balances, health data, or personal info.
- You support multitasking and want safe app snapshots.
- You need a quick default shield but still want full customization.
- You want to block screenshots and screen recordings without extra setup.

## Requirements

- iOS 17.0 or later
- Swift 6.0 or later

## Installation

Add ScreenPrivacy as a Swift Package dependency in Xcode or via `Package.swift`.

## Usage

Apply the modifier to any view you want to protect:

```swift
import ScreenPrivacy
import SwiftUI

struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

Provide a custom shield when you want branded visuals:

```swift
import ScreenPrivacy
import SwiftUI

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
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.background)
                .foregroundStyle(.primary)
            }
    }
}
```

Use the container if you prefer composition:

```swift
import ScreenPrivacy
import SwiftUI

struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Behavior

- Shows the shield when the scene becomes inactive.
- Optionally shows the shield when screen capture is detected.
- Applies `privacySensitive()` to the protected content.
- Uses secure rendering by default to block screenshots and recordings.
- Secure rendering is implemented by hosting SwiftUI inside a secure text field canvas view.

## Customization

- Set `isEnabled` to `false` to disable the shield.
- Set `includeCaptureDetection` to `false` if you only want to shield on inactivity.
- Set `blocksScreenCapture` to `false` if you only want the shield without secure rendering.

## Tips

- Use a minimal custom shield to keep transitions smooth.
- Prefer `.background(.background)` for adaptive light/dark appearance.
- If you use your own background color, make sure text remains readable in both color schemes.

## FAQ

**Does this block screenshots?**  
Yes. ScreenPrivacy uses a secure text field container to block screenshots and screen recordings by default.

**Does it work in widgets or extensions?**  
This package targets SwiftUI views in your app. It is not designed to shield widget timelines, yet.

**Can I add analytics or logging?**  
Yes. You can wrap `ScreenPrivacyContainer` and observe your own app lifecycle to log events, without changing the shield itself.

## License

MIT
