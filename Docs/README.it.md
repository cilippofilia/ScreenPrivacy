# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

ScreenPrivacy offre una schermatura privacy leggera per SwiftUI che copre automaticamente le viste sensibili quando l’app diventa inattiva, con il rilevamento della cattura schermo opzionale come livello aggiuntivo. Abilita anche il rendering sicuro di default, che impedisce screenshot e registrazioni dello schermo dei contenuti protetti. È pensato per essere un’aggiunta in una riga, mantenendo la UI pulita, testabile e rispettosa della privacy.

Casi d’uso utili:
- Mostri saldi, dati sanitari o informazioni personali.
- Supporti il multitasking e vuoi snapshot dell’app sicuri.
- Vuoi uno scudo predefinito rapido ma completamente personalizzabile.
- Vuoi bloccare screenshot e registrazioni senza configurazioni extra.

## Requisiti

- iOS 17.0 o successivo
- Swift 6.0 o successivo

## Installazione

Aggiungi ScreenPrivacy come dipendenza Swift Package in Xcode o via `Package.swift`.

## Uso

Applica il modifier a qualsiasi vista che vuoi proteggere:

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

Fornisci uno scudo personalizzato quando vuoi un aspetto brandizzato:

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
                    Text("Privato")
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

Usa il container se preferisci la composizione:

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

## Comportamento

- Mostra lo scudo quando la scena diventa inattiva.
- Può estendere opzionalmente la schermatura quando viene rilevata la cattura schermo.
- Applica `privacySensitive()` ai contenuti protetti.
- Usa il rendering sicuro di default per bloccare screenshot e registrazioni.
- Il rendering sicuro è implementato ospitando SwiftUI dentro la canvas di un text field sicuro.

## Personalizzazione

- Imposta `isEnabled` su `false` per disabilitare lo scudo.
- Imposta `includeCaptureDetection` su `false` se vuoi lo scudo solo in inattività.
- Imposta `blocksScreenCapture` su `false` se vuoi solo lo scudo senza rendering sicuro.

## Consigli

- Usa uno scudo personalizzato minimale per transizioni fluide.
- Preferisci `.background(.background)` per un aspetto adattivo chiaro/scuro.
- Se usi un tuo colore di sfondo, assicurati che il testo resti leggibile in entrambi i temi.

## FAQ

**Blocca gli screenshot?**  
Sì, di default. ScreenPrivacy usa un container basato su text field sicuro quando `blocksScreenCapture` è `true`, che è il valore predefinito.

**Funziona in widget o estensioni?**  
Questo package è pensato per viste SwiftUI nell’app. Non è progettato per schermare le timeline dei widget.

**Posso aggiungere analytics o logging?**  
Sì. Puoi avvolgere `ScreenPrivacyContainer` e osservare il ciclo di vita dell’app per registrare eventi, senza modificare lo scudo.

## Licenza

MIT
