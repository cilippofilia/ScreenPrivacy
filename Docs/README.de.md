<img src="Images/screenPrivacy_pill.svg" alt="ScreenPrivacy-Logo" width="40%" />

# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

`ScreenPrivacy` ist ein SwiftUI-Paket zum Ausblenden sensibler Bildschirme, wenn Ihre App inaktiv wird, und optional auch dann, wenn eine Bildschirmaufnahme erkannt wird. Es wendet `privacySensitive()` auf den geschützten Inhalt an und kann diesen Inhalt bei aktivierter Capture-Blockierung in einen sicheren, UIKit-basierten Container einbetten.

## Über Das Paket

Verwenden Sie `ScreenPrivacy`, wenn eine View weder in App-Switcher-Snapshots noch während einer aktiven Aufnahme sichtbar bleiben soll. Das Paket hält den Einstieg bewusst einfach:

- Verwenden Sie für den häufigsten Fall einen einzelnen View-Modifier.
- Wechseln Sie zu einem Container, wenn Komposition in Ihrem View-Tree besser passt.
- Behalten Sie den Standardschutz bei oder liefern Sie eine eigene Shield-View.
- Deaktivieren Sie die Aufnahmeerkennung, wenn Sie nur den Schutz bei inaktiver Szene benötigen.

## Installation

Fügen Sie `ScreenPrivacy` in Xcode als Swift-Package-Abhängigkeit hinzu oder referenzieren Sie es während der lokalen Entwicklung in `Package.swift`:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Importieren Sie es anschließend in jeder SwiftUI-Datei, die geschützt werden soll:

```swift
import ScreenPrivacy
import SwiftUI
```

## Schnellstart

Die kleinste sinnvolle Integration ist der Modifier:

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

Damit werden der Standardschutz, die Aufnahmeerkennung und sicheres Rendering standardmäßig aktiviert.

## Verwendung

Verwenden Sie einen eigenen Schutz, wenn die Ersatzoberfläche zur Sprache Ihres Produkts passen soll:

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

Wenn Sie Komposition einem Modifier vorziehen, verwenden Sie `ScreenPrivacyContainer`:

```swift
struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Konfiguration

`ScreenPrivacy` bietet drei Laufzeitoptionen:

| Option | Standard | Wirkung |
| --- | --- | --- |
| `isEnabled` | `true` | Schaltet den Privatsphärenschutz ein oder aus. |
| `includeCaptureDetection` | `true` | Zeigt den Schutz an, wenn der Bildschirm aufgenommen wird. |
| `blocksScreenCapture` | `true` | Bettet den Inhalt auf UIKit-Plattformen in den sicheren Container des Pakets ein. |

Beispiel:

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

Die Sichtbarkeitsregeln des Pakets sind bewusst klein gehalten:

- Wenn der Schutz deaktiviert ist, bleibt das Shield verborgen.
- Wenn die Szene inaktiv wird, wird das Shield sichtbar.
- Wenn die Aufnahmeerkennung aktiv ist und der Bildschirm aufgenommen wird, wird das Shield sichtbar.
- Geschützter Inhalt wird mit `privacySensitive()` markiert.
- Die Darstellung des Shields verwendet eine Opazitäts-Transition.

Auf UIKit-Plattformen wird sicheres Rendering mit einem Container umgesetzt, der auf einem sicheren Textfeld basiert. In Umgebungen ohne UIKit fällt das Paket auf einen normalen SwiftUI-Wrapper zurück.

## Wann Man Es Verwenden Sollte

`ScreenPrivacy` eignet sich für Bildschirme wie:

- Kontostände oder Zahlungsdetails
- Gesundheits- oder Wellnessdaten
- private Notizen, Journale oder Nachrichten
- interne Dashboards oder operative Werkzeuge

## Anforderungen

- iOS 17.0 oder neuer
- macOS 14.0 oder neuer
- Swift 6.0 oder neuer

Diese Werte entsprechen der eingecheckten `Package.swift`.

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

Das Paket enthält Swift-Testing-Abdeckung für:

- Schutz bei inaktiver Szene
- Schutz bei erkannter Aufnahme
- Neuberechnung beim Aktivieren und Deaktivieren
- Umschalten der Aufnahmeerkennung
- injizierte Provider für den Aufnahmestatus

## Lizenz

[MIT](../LICENSE)
