# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

ScreenPrivacy fournit un écran de confidentialité léger pour SwiftUI qui couvre automatiquement les vues sensibles lorsque l’app devient inactive ou lorsqu’une capture d’écran est détectée. Il active aussi le rendu sécurisé par défaut, qui empêche les captures d’écran et les enregistrements du contenu protégé. Il est conçu pour être un ajout en une ligne, en gardant l’UI propre, testable et respectueuse de la vie privée.

Cas d’usage utiles :
- Vous affichez des soldes, des données de santé ou des informations personnelles.
- Vous prenez en charge le multitâche et voulez des snapshots d’app sûrs.
- Vous voulez un écran par défaut rapide mais entièrement personnalisable.
- Vous voulez bloquer captures et enregistrements sans configuration supplémentaire.

## Exigences

- iOS 26.0 ou version ultérieure
- Swift 6.2 ou version ultérieure

## Installation

Ajoutez ScreenPrivacy comme dépendance Swift Package dans Xcode ou via `Package.swift`.

## Utilisation

Appliquez le modificateur à toute vue que vous souhaitez protéger :

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

Fournissez un écran personnalisé si vous voulez un visuel de marque :

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
                    Text("Privé")
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

Utilisez le conteneur si vous préférez la composition :

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

## Comportement

- Affiche l’écran lorsque la scène devient inactive.
- Affiche l’écran de manière optionnelle lorsqu’une capture d’écran est détectée.
- Applique `privacySensitive()` au contenu protégé.
- Utilise le rendu sécurisé par défaut pour bloquer les captures et enregistrements.
- Le rendu sécurisé est implémenté en hébergeant SwiftUI dans le canevas d’un champ de texte sécurisé.

## Personnalisation

- Réglez `isEnabled` sur `false` pour désactiver l’écran.
- Réglez `includeCaptureDetection` sur `false` si vous voulez l’écran uniquement en inactivité.
- Réglez `blocksScreenCapture` sur `false` si vous voulez l’écran sans rendu sécurisé.

## Conseils

- Utilisez un écran personnalisé minimal pour des transitions fluides.
- Préférez `.background(.background)` pour une apparence adaptative clair/sombre.
- Si vous utilisez votre propre couleur de fond, assurez-vous que le texte reste lisible dans les deux thèmes.

## FAQ

**Est-ce que cela bloque les captures d’écran ?**  
Oui. ScreenPrivacy utilise un conteneur de champ de texte sécurisé pour bloquer les captures et enregistrements par défaut.

**Cela fonctionne-t-il dans les widgets ou extensions ?**  
Ce package cible les vues SwiftUI dans votre app. Il n’est pas conçu pour protéger les timelines de widgets.

**Puis-je ajouter de l’analytics ou du logging ?**  
Oui. Vous pouvez envelopper `ScreenPrivacyContainer` et observer le cycle de vie de l’app pour journaliser des événements, sans modifier l’écran.

## Licence

MIT
