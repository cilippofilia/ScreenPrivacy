# ScreenPrivacy

![ScreenPrivacy logo](Images/screenprivacy-logo.svg)

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

Schützen Sie sensible SwiftUI-Bildschirme mit einem Privatsphärenschutz, der erscheint, wenn Ihre App inaktiv wird, und optional auch dann, wenn eine Bildschirmaufnahme erkannt wird. `ScreenPrivacy` wendet außerdem `privacySensitive()` an und kann geschützte Inhalte in einem sicheren Container hosten, damit Screenshots und Aufnahmen schwerer werden.

## Warum ScreenPrivacy

- Schutz sensibler SwiftUI-Views mit einer einzigen Zeile.
- Sichere App-Switcher-Snapshots durch Schutz bei inaktiver Szene.
- Optionale Aufnahmeerkennung zusätzlich zum Verhalten bei inaktiver Szene.
- Eigene Schutzoberfläche für gebrandete oder domänenspezifische Hinweise.
- Kleine öffentliche API mit Einstieg über Modifier und Container.

## Inhaltsverzeichnis

- [Anforderungen](#anforderungen)
- [Installation](#installation)
- [Schnellstart](#schnellstart)
- [Anpassung](#anpassung)
- [Verhalten](#verhalten)
- [Wann Es Sinnvoll Ist](#wann-es-sinnvoll-ist)
- [Paketstruktur](#paketstruktur)
- [Tests](#tests)
- [FAQ](#faq)
- [Lizenz](#lizenz)

## Anforderungen

- iOS 17.0 oder neuer
- macOS 14.0 oder neuer
- Swift 6.0 oder neuer

Diese Anforderungen entsprechen der eingecheckten `Package.swift`.

## Installation

Fügen Sie `ScreenPrivacy` in Xcode oder in `Package.swift` als Swift-Package-Abhängigkeit hinzu:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Importieren Sie das Modul dann dort, wo Sie eine View schützen möchten:

```swift
import ScreenPrivacy
import SwiftUI
```

## Schnellstart

Der Standard-Modifier ist der schnellste Einstieg:

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

### Eigener Schutz

Verwenden Sie einen eigenen Schutz, wenn Sie Tonalität, Farben oder Layout selbst bestimmen möchten:

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

                    Text("Privat")
                        .font(.title2)
                        .bold()

                    Text("Ausgeblendet, solange dieser Bildschirm nicht sicher angezeigt werden kann.")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.background)
                .foregroundStyle(.primary)
            }
    }
}
```

### Container-API

Wenn Sie Komposition gegenüber einem Modifier bevorzugen:

```swift
struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Anpassung

`ScreenPrivacy` hält die API bewusst klein:

| Option | Standard | Zweck |
| --- | --- | --- |
| `isEnabled` | `true` | Aktiviert oder deaktiviert den Schutz. |
| `includeCaptureDetection` | `true` | Fügt Schutz bei Bildschirmaufnahme zusätzlich zum Inaktivitätsschutz hinzu. |
| `blocksScreenCapture` | `true` | Verwendet einen sicheren Container, damit Screenshots und Aufnahmen schwerer werden. |

Beispiel mit expliziter Konfiguration:

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

## Verhalten

- Zeigt den Schutz, wenn die Szene inaktiv wird.
- Kann den Schutz auch bei erkannter Bildschirmaufnahme anzeigen.
- Wendet `privacySensitive()` auf den geschützten Inhalt an.
- Verwendet einen sicheren, textfeldbasierten Container, wenn `blocksScreenCapture` auf UIKit-Plattformen aktiviert ist.
- Animiert die Einblendung des Schutzes mit einer Opazitäts-Transition.
- Verwendet einen normalen SwiftUI-Wrapper, wenn UIKit bei hostseitigen Tests nicht verfügbar ist.

## Wann Es Sinnvoll Ist

`ScreenPrivacy` eignet sich besonders, wenn Ihre App Folgendes zeigt:

- Kontostände oder Zahlungsdetails
- Gesundheits- oder Wellnessdaten
- private Notizen, Journale oder Nachrichten
- interne Dashboards oder operative Werkzeuge
- alles, was nicht im App-Switcher erscheinen sollte

## Paketstruktur

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

Das Paket enthält Swift-Testing-Abdeckung für die zentralen Sichtbarkeitsregeln und das Verhalten des Monitors, darunter:

- Schutz bei inaktiver Szene
- Schutz durch erkannte Aufnahme
- Neuberechnung beim Aktivieren oder Deaktivieren
- Aktivieren oder Deaktivieren der Aufnahmeerkennung
- injizierte Provider für den Aufnahmestatus

## FAQ

**Blockiert das Screenshots?**  
Standardmäßig werden Screenshots und Aufnahmen erschwert, indem der geschützte Inhalt in einem sicheren Container gehostet wird, wenn `blocksScreenCapture` auf `true` steht.

**Funktioniert es in Widgets oder Erweiterungen?**  
Es ist für SwiftUI-Views innerhalb Ihrer App gedacht. Widget-Timelines sind nicht Teil des Umfangs.

**Kann ich Analytics oder Logging hinzufügen?**  
Ja. Sie können `ScreenPrivacyContainer` oder den geschützten Bildschirm mit eigener Lifecycle-Erfassung umschließen, ohne die Package-API zu ändern.

**Sollte ich die Aufnahmeerkennung immer aktiviert lassen?**  
Meistens ja. Wenn Ihr Produkt jedoch nur App-Switcher-Privatsphäre braucht, setzen Sie `includeCaptureDetection` auf `false`.

## Lizenz

[MIT](../LICENSE)
