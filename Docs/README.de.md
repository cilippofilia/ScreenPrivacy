# ScreenPrivacy

[English](../README.md) | [Italiano](README.it.md) | [Español](README.es.md) | [Français](README.fr.md) | [Deutsch](README.de.md) | [Русский](README.ru.md)

ScreenPrivacy bietet einen leichtgewichtigen SwiftUI-Privatsphärenschutz, der sensible Ansichten automatisch abdeckt, wenn die App inaktiv wird oder eine Bildschirmaufnahme erkannt wird. Es aktiviert außerdem standardmäßig sicheres Rendering, das Screenshots und Bildschirmaufzeichnungen des geschützten Inhalts verhindert. Es ist als Ein-Zeilen-Add-on gedacht, das die UI sauber, testbar und datenschutzfreundlich hält.

Nützliche Anwendungsfälle:
- Sie zeigen Kontostände, Gesundheitsdaten oder persönliche Informationen an.
- Sie unterstützen Multitasking und möchten sichere App-Snapshots.
- Sie wollen einen schnellen Standardschutz, aber mit voller Anpassbarkeit.
- Sie möchten Screenshots und Aufnahmen ohne zusätzliche Einrichtung blockieren.

## Anforderungen

- iOS 26.0 oder neuer
- Swift 6.2 oder neuer

## Installation

Fügen Sie ScreenPrivacy als Swift-Package-Abhängigkeit in Xcode oder über `Package.swift` hinzu.

## Verwendung

Wenden Sie den Modifier auf jede Ansicht an, die Sie schützen möchten:

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

Stellen Sie einen benutzerdefinierten Schutz bereit, wenn Sie ein markiertes Erscheinungsbild möchten:

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
                    Text("Privat")
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

Verwenden Sie den Container, wenn Sie Komposition bevorzugen:

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

## Verhalten

- Zeigt den Schutz, wenn die Szene inaktiv wird.
- Zeigt optional den Schutz, wenn eine Bildschirmaufnahme erkannt wird.
- Wendet `privacySensitive()` auf geschützte Inhalte an.
- Verwendet standardmäßig sicheres Rendering, um Screenshots und Aufnahmen zu blockieren.
- Sicheres Rendering wird umgesetzt, indem SwiftUI in der Canvas eines sicheren Textfelds gehostet wird.

## Anpassung

- Setzen Sie `isEnabled` auf `false`, um den Schutz zu deaktivieren.
- Setzen Sie `includeCaptureDetection` auf `false`, wenn Sie den Schutz nur bei Inaktivität wollen.
- Setzen Sie `blocksScreenCapture` auf `false`, wenn Sie den Schutz ohne sicheres Rendering möchten.

## Tipps

- Verwenden Sie einen minimalen benutzerdefinierten Schutz für flüssige Übergänge.
- Bevorzugen Sie `.background(.background)` für ein adaptives Hell/Dunkel-Erscheinungsbild.
- Wenn Sie eine eigene Hintergrundfarbe verwenden, stellen Sie sicher, dass der Text in beiden Themen lesbar bleibt.

## FAQ

**Blockiert das Screenshots?**  
Ja. ScreenPrivacy verwendet einen sicheren Textfeld-Container, um Screenshots und Bildschirmaufzeichnungen standardmäßig zu blockieren.

**Funktioniert das in Widgets oder Erweiterungen?**  
Dieses Package richtet sich an SwiftUI-Ansichten in Ihrer App. Es ist nicht dafür gedacht, Widget-Timelines zu schützen.

**Kann ich Analytics oder Logging hinzufügen?**  
Ja. Sie können `ScreenPrivacyContainer` umschließen und den App-Lifecycle beobachten, um Ereignisse zu protokollieren, ohne den Schutz zu ändern.

## Lizenz

MIT
