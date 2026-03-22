# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

Schützen Sie sensible SwiftUI-Bildschirme mit einem Privatsphärenschutz, der erscheint, wenn Ihre App inaktiv wird, und optional auch dann, wenn eine Bildschirmaufnahme erkannt wird. `ScreenPrivacy` aktiviert außerdem standardmäßig sicheres Rendering, damit geschützte Inhalte schwerer per Screenshot oder Aufnahme erfasst werden können.

## Warum ScreenPrivacy

- Schutz sensibler SwiftUI-Views mit einer einzigen Zeile.
- Sichere App-Switcher-Snapshots durch Schutz bei inaktiver Szene.
- Optionale Aufnahmeerkennung zusätzlich zum Inaktivitätsverhalten.
- Eigene Schutzoberfläche für gebrandete oder domänenspezifische Hinweise.
- Sicheres Rendering standardmäßig aktiviert.

## Inhaltsverzeichnis

- [Anforderungen](#anforderungen)
- [Installation](#installation)
- [Schnellstart](#schnellstart)
- [Anpassung](#anpassung)
- [Verhalten](#verhalten)
- [Wann Es Sinnvoll Ist](#wann-es-sinnvoll-ist)
- [FAQ](#faq)
- [Lizenz](#lizenz)

## Anforderungen

- iOS 17.0 oder neuer
- Swift 6.0 oder neuer

## Installation

Fügen Sie `ScreenPrivacy` in Xcode oder in `Package.swift` als Swift-Package-Abhängigkeit hinzu:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Importieren Sie es dann dort, wo Sie eine View schützen möchten:

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
| `blocksScreenCapture` | `true` | Verwendet sicheres Rendering, damit Screenshots und Aufnahmen schwerer werden. |

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
- Verwendet einen sicheren Textfeld-Container, wenn `blocksScreenCapture` aktiviert ist.
- Animiert die Einblendung des Schutzes mit einer Opazitäts-Transition.

## Wann Es Sinnvoll Ist

`ScreenPrivacy` eignet sich besonders, wenn Ihre App Folgendes zeigt:

- Kontostände oder Zahlungsdetails
- Gesundheits- oder Wellnessdaten
- private Notizen, Journale oder Nachrichten
- interne Dashboards oder operative Werkzeuge
- alles, was nicht im App-Switcher erscheinen sollte

## FAQ

**Blockiert das Screenshots?**  
Ja, standardmäßig. Wenn `blocksScreenCapture` auf `true` steht, wird der geschützte Inhalt in einem sicheren Container gehostet.

**Funktioniert es in Widgets oder Erweiterungen?**  
Es ist für SwiftUI-Views innerhalb Ihrer App gedacht. Widget-Timelines sind nicht Teil des Umfangs.

**Kann ich Analytics oder Logging hinzufügen?**  
Ja. Sie können `ScreenPrivacyContainer` oder den geschützten Bildschirm mit eigener Lifecycle-Erfassung umschließen, ohne die Package-API zu ändern.

**Sollte ich die Aufnahmeerkennung immer aktiviert lassen?**  
Meistens ja. Wenn Ihr Produkt jedoch nur App-Switcher-Privatsphäre braucht, setzen Sie `includeCaptureDetection` auf `false`.

## Lizenz

[MIT](../LICENSE)
