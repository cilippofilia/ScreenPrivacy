# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

Proteggi le schermate SwiftUI sensibili con uno scudo privacy che appare quando l’app diventa inattiva e, opzionalmente, quando viene rilevata una cattura schermo. `ScreenPrivacy` applica anche `privacySensitive()` e può ospitare i contenuti protetti in un container sicuro per rendere più difficili screenshot e registrazioni.

## Perché ScreenPrivacy

- Protezione in una riga per viste SwiftUI sensibili.
- Snapshot sicuri nell’app switcher grazie alla schermatura in stato inattivo.
- Rilevamento cattura opzionale aggiunto al comportamento in stato inattivo.
- Scudo personalizzato quando servono messaggi o visual propri.
- API pubblica piccola con accesso sia tramite modifier sia tramite container.

## Indice

- [Requisiti](#requisiti)
- [Installazione](#installazione)
- [Avvio Rapido](#avvio-rapido)
- [Personalizzazione](#personalizzazione)
- [Comportamento](#comportamento)
- [Quando Usarlo](#quando-usarlo)
- [Struttura Del Package](#struttura-del-package)
- [Test](#test)
- [FAQ](#faq)
- [Licenza](#licenza)

## Requisiti

- iOS 17.0 o successivo
- macOS 14.0 o successivo
- Swift 6.0 o successivo

Questi requisiti corrispondono al `Package.swift` incluso nel repository.

## Installazione

Aggiungi `ScreenPrivacy` come dipendenza Swift Package in Xcode o in `Package.swift`:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Poi importa il modulo dove vuoi proteggere una vista:

```swift
import ScreenPrivacy
import SwiftUI
```

## Avvio Rapido

Il modifier predefinito è il percorso più rapido:

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

### Scudo Personalizzato

Usa uno scudo personalizzato quando vuoi controllare tono, colori o layout:

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

### API Container

Se preferisci la composizione ai modifier:

```swift
struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Personalizzazione

`ScreenPrivacy` mantiene l’API volutamente piccola:

| Opzione | Predefinito | Scopo |
| --- | --- | --- |
| `isEnabled` | `true` | Attiva o disattiva il comportamento dello scudo. |
| `includeCaptureDetection` | `true` | Aggiunge la schermatura da cattura a quella per inattività. |
| `blocksScreenCapture` | `true` | Usa un container sicuro per rendere più difficili screenshot e registrazioni. |

Esempio con configurazione esplicita:

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

- Mostra lo scudo quando la scena diventa inattiva.
- Può mostrare lo scudo anche quando viene rilevata una cattura schermo.
- Applica `privacySensitive()` ai contenuti protetti.
- Usa un container basato su text field sicuro quando `blocksScreenCapture` è attivo sulle piattaforme UIKit.
- Anima la comparsa dello scudo con una transizione in opacità.
- Usa un wrapper SwiftUI regolare quando UIKit non è disponibile durante i test host-side.

## Quando Usarlo

`ScreenPrivacy` è adatto quando la tua app mostra:

- saldi o dettagli di pagamento
- dati sanitari o di benessere
- note private, diari o messaggi
- dashboard interne o strumenti operativi
- qualsiasi contenuto che non dovrebbe apparire nell’app switcher

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

Il package include test con Swift Testing per le regole di visibilità e per il comportamento del monitor, inclusi:

- schermatura in stato inattivo
- schermatura guidata dalla cattura
- ricalcolo quando si abilita o disabilita la protezione
- attivazione o disattivazione del rilevamento cattura
- provider iniettati per lo stato di cattura

## FAQ

**Blocca gli screenshot?**  
Di default rende più difficili screenshot e registrazioni ospitando i contenuti protetti in un container sicuro quando `blocksScreenCapture` è `true`.

**Funziona in widget o estensioni?**  
È pensato per viste SwiftUI all’interno dell’app. Le timeline dei widget sono fuori ambito.

**Posso aggiungere analytics o logging?**  
Sì. Puoi avvolgere `ScreenPrivacyContainer` o la schermata protetta con il tuo monitoraggio del ciclo di vita senza cambiare l’API del package.

**Dovrei lasciare sempre attivo il rilevamento cattura?**  
Di solito sì. Ma se il tuo prodotto vuole solo privacy nell’app switcher, imposta `includeCaptureDetection` su `false`.

## Licenza

[MIT](../LICENSE)
