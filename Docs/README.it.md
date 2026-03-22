# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

Proteggi le schermate sensibili di SwiftUI con uno scudo privacy che appare quando l’app diventa inattiva e, opzionalmente, quando viene rilevata una cattura schermo. `ScreenPrivacy` abilita anche il rendering sicuro di default, così i contenuti protetti risultano più difficili da catturare o registrare.

## Perché ScreenPrivacy

- Protezione in una riga per viste SwiftUI sensibili.
- Snapshot sicuri nell’app switcher grazie alla schermatura in stato inattivo.
- Rilevamento cattura opzionale aggiunto al comportamento di inattività.
- Scudo personalizzato quando servono messaggi o visual propri.
- Rendering sicuro abilitato di default.

## Indice

- [Requisiti](#requisiti)
- [Installazione](#installazione)
- [Avvio Rapido](#avvio-rapido)
- [Personalizzazione](#personalizzazione)
- [Comportamento](#comportamento)
- [Quando Usarlo](#quando-usarlo)
- [FAQ](#faq)
- [Licenza](#licenza)

## Requisiti

- iOS 17.0 o successivo
- Swift 6.0 o successivo

## Installazione

Aggiungi `ScreenPrivacy` come dipendenza Swift Package in Xcode o in `Package.swift`:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Poi importalo dove vuoi proteggere una vista:

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
| `blocksScreenCapture` | `true` | Usa il rendering sicuro per rendere più difficili screenshot e registrazioni. |

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
- Usa un container basato su text field sicuro quando `blocksScreenCapture` è attivo.
- Anima la comparsa dello scudo con una transizione in opacità.

## Quando Usarlo

`ScreenPrivacy` è adatto quando la tua app mostra:

- saldi o dettagli di pagamento
- dati sanitari o di benessere
- note private, diari o messaggi
- dashboard interne o strumenti operativi
- qualsiasi contenuto che non dovrebbe apparire nell’app switcher

## FAQ

**Blocca gli screenshot?**  
Sì, di default. Quando `blocksScreenCapture` è `true`, il contenuto protetto viene ospitato in un container sicuro.

**Funziona in widget o estensioni?**  
È pensato per viste SwiftUI all’interno dell’app. Le timeline dei widget sono fuori ambito.

**Posso aggiungere analytics o logging?**  
Sì. Puoi avvolgere `ScreenPrivacyContainer` o la schermata protetta con il tuo monitoraggio del ciclo di vita senza cambiare l’API del package.

**Dovrei lasciare sempre attivo il rilevamento cattura?**  
Di solito sì. Ma se il tuo prodotto vuole solo privacy nell’app switcher, imposta `includeCaptureDetection` su `false`.

## Licenza

[MIT](../LICENSE)
