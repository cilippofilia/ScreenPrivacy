<img src="Images/screenPrivacy_pill.svg" alt="Logo di ScreenPrivacy" width="40%" />

# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

`ScreenPrivacy` è un package SwiftUI per nascondere schermate sensibili quando la tua app diventa inattiva e, opzionalmente, quando viene rilevata una cattura schermo. Applica `privacySensitive()` ai contenuti protetti e può avvolgerli in un container sicuro basato su UIKit quando il blocco della cattura è abilitato.

## Panoramica

Usa `ScreenPrivacy` quando una vista non deve restare visibile negli snapshot dell’app switcher o durante una cattura attiva. Il package mantiene l’onboarding semplice:

- applica un singolo view modifier per il caso più comune
- passa a un container quando la composizione si legge meglio nel tuo view tree
- mantieni lo scudo di default oppure fornisci una tua shield view
- disattiva il rilevamento della cattura se ti interessa solo la schermatura per scena inattiva

## Installazione

Aggiungi `ScreenPrivacy` come dipendenza Swift Package in Xcode, oppure referenzialo da `Package.swift` durante lo sviluppo locale:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Poi importalo in qualsiasi file SwiftUI che richieda protezione:

```swift
import ScreenPrivacy
import SwiftUI
```

## Avvio Rapido

L’integrazione minima utile è il modifier:

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

Questo usa lo scudo di default, abilita il rilevamento della cattura e abilita di default il rendering sicuro.

## Utilizzo

Usa uno scudo personalizzato quando l’interfaccia di fallback deve rispecchiare il linguaggio del tuo prodotto:

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

                    Text("Privato")
                        .font(.title2)
                        .bold()

                    Text("Nascosto finché questa schermata non può essere mostrata in sicurezza.")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.background)
                .foregroundStyle(.primary)
            }
    }
}
```

Se preferisci la composizione a un modifier, usa `ScreenPrivacyContainer`:

```swift
struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Configurazione

`ScreenPrivacy` espone tre controlli runtime:

| Opzione | Default | Effetto |
| --- | --- | --- |
| `isEnabled` | `true` | Attiva o disattiva la schermatura della privacy. |
| `includeCaptureDetection` | `true` | Mostra lo scudo quando lo schermo viene catturato. |
| `blocksScreenCapture` | `true` | Avvolge il contenuto nel container sicuro usato dal package sulle piattaforme UIKit. |

Esempio:

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

## Comportamento

Le regole di visibilità del package sono volutamente essenziali:

- se la protezione è disattivata, lo scudo resta nascosto
- se la scena diventa inattiva, lo scudo diventa visibile
- se il rilevamento della cattura è attivo e lo schermo viene catturato, lo scudo diventa visibile
- i contenuti protetti vengono marcati con `privacySensitive()`
- la presentazione dello scudo usa una transizione in opacità

Sulle piattaforme UIKit, il rendering sicuro viene implementato con un container basato su un campo di testo sicuro. Negli ambienti in cui UIKit non è disponibile, il package usa un normale wrapper SwiftUI.

## Quando Usarlo

`ScreenPrivacy` è adatto a schermate come:

- saldi del conto o dettagli di pagamento
- dati sanitari o di benessere
- note private, diari o messaggi
- dashboard interne o strumenti operativi

## Requisiti

- iOS 17.0 o successivo
- macOS 14.0 o successivo
- Swift 6.0 o successivo

Questi valori corrispondono al `Package.swift` incluso nel repository.

## Struttura Del Package

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

## Test

Il package include copertura Swift Testing per:

- schermatura in scena inattiva
- schermatura attivata dalla cattura
- ricalcolo durante abilitazione e disabilitazione
- attivazione e disattivazione del rilevamento della cattura
- provider iniettati dello stato di cattura

## Licenza

[MIT](../LICENSE)
