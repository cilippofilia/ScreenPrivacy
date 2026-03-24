<img src="Images/screenPrivacy_pill.svg" alt="Logo ScreenPrivacy" width="40%" />

# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

`ScreenPrivacy` est un package SwiftUI conçu pour masquer les écrans sensibles lorsque votre app devient inactive et, en option, lorsqu’une capture d’écran est détectée. Il applique `privacySensitive()` au contenu protégé et peut envelopper ce contenu dans un conteneur sécurisé reposant sur UIKit lorsque le blocage de capture est activé.

## À Propos

Utilisez `ScreenPrivacy` lorsqu’une vue ne doit pas rester visible dans les snapshots de l’app switcher ni pendant une capture active. Le package garde l’intégration simple :

- appliquez un seul modificateur de vue pour le cas le plus courant
- passez à un conteneur lorsque la composition s’intègre mieux à votre hiérarchie de vues
- conservez l’écran par défaut ou fournissez votre propre vue d’écran
- désactivez la détection de capture si vous ne voulez protéger que les scènes inactives

## Installation

Ajoutez `ScreenPrivacy` comme dépendance Swift Package dans Xcode, ou référez-le depuis `Package.swift` pendant le développement local :

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Importez-le ensuite dans tout fichier SwiftUI qui doit être protégé :

```swift
import ScreenPrivacy
import SwiftUI
```

## Démarrage Rapide

L’intégration minimale utile est le modificateur :

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

Cela utilise l’écran par défaut, active la détection de capture et active aussi le rendu sécurisé par défaut.

## Utilisation

Utilisez un écran personnalisé lorsque l’interface de repli doit correspondre au langage de votre produit :

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

                    Text("Privé")
                        .font(.title2)
                        .bold()

                    Text("Masqué tant que cet écran ne peut pas être affiché en toute sécurité.")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.background)
                .foregroundStyle(.primary)
            }
    }
}
```

Si vous préférez la composition à un modificateur, utilisez `ScreenPrivacyContainer` :

```swift
struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Configuration

`ScreenPrivacy` expose trois contrôles d’exécution :

| Option | Valeur par défaut | Effet |
| --- | --- | --- |
| `isEnabled` | `true` | Active ou désactive l’écran de confidentialité. |
| `includeCaptureDetection` | `true` | Affiche l’écran lorsque l’écran est en cours de capture. |
| `blocksScreenCapture` | `true` | Enveloppe le contenu dans le conteneur sécurisé utilisé par le package sur les plateformes UIKit. |

Exemple :

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

## Comportement

Les règles de visibilité du package sont volontairement limitées :

- si la protection est désactivée, l’écran reste masqué
- si la scène devient inactive, l’écran devient visible
- si la détection de capture est activée et que l’écran est capturé, l’écran devient visible
- le contenu protégé est marqué avec `privacySensitive()`
- la présentation de l’écran utilise une transition d’opacité

Sur les plateformes UIKit, le rendu sécurisé est implémenté avec un conteneur basé sur un champ de texte sécurisé. Dans les environnements où UIKit n’est pas disponible, le package revient à un wrapper SwiftUI classique.

## Quand L’Utiliser

`ScreenPrivacy` convient à des écrans comme :

- des soldes de compte ou des informations de paiement
- des données de santé ou de bien-être
- des notes privées, journaux ou messages
- des tableaux de bord internes ou des outils opérationnels

## Exigences

- iOS 17.0 ou version ultérieure
- macOS 14.0 ou version ultérieure
- Swift 6.0 ou version ultérieure

Ces valeurs correspondent au `Package.swift` versionné dans le dépôt.

## Structure Du Package

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

Le package inclut une couverture Swift Testing pour :

- la protection lorsque la scène est inactive
- la protection déclenchée par capture
- le recalcul lors de l’activation et de la désactivation
- l’activation et la désactivation de la détection de capture
- les fournisseurs injectés d’état de capture

## Licence

[MIT](../LICENSE)
