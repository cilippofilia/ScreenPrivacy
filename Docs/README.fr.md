# ScreenPrivacy

![ScreenPrivacy logo](Images/screenprivacy-logo.svg)

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

Protégez les écrans SwiftUI sensibles avec un écran de confidentialité qui apparaît lorsque l’app devient inactive et, en option, lorsqu’une capture d’écran est détectée. `ScreenPrivacy` applique aussi `privacySensitive()` et peut héberger le contenu protégé dans un conteneur sécurisé pour rendre captures et enregistrements plus difficiles.

## Pourquoi ScreenPrivacy

- Protection en une ligne pour les vues SwiftUI sensibles.
- Snapshots sûrs dans l’app switcher grâce à la protection en état inactif.
- Détection de capture optionnelle ajoutée au comportement en état inactif.
- Écran personnalisé lorsque vous avez besoin d’un message ou d’un visuel propre.
- API publique compacte avec une entrée par modificateur et par conteneur.

## Table des Matières

- [Exigences](#exigences)
- [Installation](#installation)
- [Démarrage Rapide](#démarrage-rapide)
- [Personnalisation](#personnalisation)
- [Comportement](#comportement)
- [Quand L’Utiliser](#quand-lutiliser)
- [Structure Du Package](#structure-du-package)
- [Tests](#tests)
- [FAQ](#faq)
- [Licence](#licence)

## Exigences

- iOS 17.0 ou version ultérieure
- macOS 14.0 ou version ultérieure
- Swift 6.0 ou version ultérieure

Ces exigences correspondent au `Package.swift` du dépôt.

## Installation

Ajoutez `ScreenPrivacy` comme dépendance Swift Package dans Xcode ou dans `Package.swift` :

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Importez ensuite le module là où vous protégez une vue :

```swift
import ScreenPrivacy
import SwiftUI
```

## Démarrage Rapide

Le modificateur par défaut est le chemin le plus rapide :

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

### Écran Personnalisé

Utilisez un écran personnalisé si vous voulez maîtriser le ton, les couleurs ou la mise en page :

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

### API Conteneur

Si vous préférez la composition aux modificateurs :

```swift
struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Personnalisation

`ScreenPrivacy` garde une API volontairement compacte :

| Option | Valeur par défaut | Rôle |
| --- | --- | --- |
| `isEnabled` | `true` | Active ou désactive le comportement de l’écran. |
| `includeCaptureDetection` | `true` | Ajoute la protection lors d’une capture à la protection par inactivité. |
| `blocksScreenCapture` | `true` | Utilise un conteneur sécurisé pour rendre captures et enregistrements plus difficiles. |

Exemple avec configuration explicite :

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

- Affiche l’écran lorsque la scène devient inactive.
- Peut aussi afficher l’écran lorsqu’une capture d’écran est détectée.
- Applique `privacySensitive()` au contenu protégé.
- Utilise un conteneur sécurisé basé sur un champ de texte lorsque `blocksScreenCapture` est activé sur les plateformes UIKit.
- Anime l’apparition de l’écran avec une transition d’opacité.
- Utilise un wrapper SwiftUI classique lorsque UIKit n’est pas disponible pendant les tests côté hôte.

## Quand L’Utiliser

`ScreenPrivacy` convient bien lorsque votre app affiche :

- des soldes ou informations de paiement
- des données de santé ou de bien-être
- des notes privées, journaux ou messages
- des tableaux de bord internes ou outils opérationnels
- tout ce qui ne doit pas apparaître dans l’app switcher

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

Le package inclut une couverture avec Swift Testing pour les règles de visibilité et le comportement du moniteur, notamment :

- la protection en état inactif
- la protection déclenchée par capture
- le recalcul lors de l’activation ou de la désactivation
- l’activation ou la désactivation de la détection de capture
- les fournisseurs injectés d’état de capture

## FAQ

**Est-ce que cela bloque les captures d’écran ?**  
Par défaut, cela rend captures et enregistrements plus difficiles en hébergeant le contenu protégé dans un conteneur sécurisé lorsque `blocksScreenCapture` vaut `true`.

**Cela fonctionne-t-il dans les widgets ou extensions ?**  
Le package est conçu pour les vues SwiftUI dans votre app. Les timelines de widgets sont hors périmètre.

**Puis-je ajouter de l’analytics ou du logging ?**  
Oui. Vous pouvez envelopper `ScreenPrivacyContainer` ou l’écran protégé avec votre propre suivi du cycle de vie sans modifier l’API du package.

**Dois-je toujours laisser la détection de capture activée ?**  
En général oui. Mais si votre produit vise seulement la confidentialité dans l’app switcher, réglez `includeCaptureDetection` sur `false`.

## Licence

[MIT](../LICENSE)
