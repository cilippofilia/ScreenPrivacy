# ScreenPrivacy

ScreenPrivacy provides a lightweight SwiftUI privacy shield to hide sensitive content when your app becomes inactive or when screen capture is detected.

## Requirements

- iOS 17 or later
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
                .background(Color.black.ignoresSafeArea())
                .foregroundStyle(.white)
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

- The shield is shown when the scene becomes inactive.
- If capture detection is enabled, the shield is also shown when the screen is being captured.
- The modifier applies `privacySensitive()` to the protected content.

## Customization

- Set `isEnabled` to `false` to disable the shield.
- Set `includeCaptureDetection` to `false` if you only want to shield on inactivity.

## License

MIT
