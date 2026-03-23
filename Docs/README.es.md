![ScreenPrivacy logo](Images/screenprivacy-logo.svg)

# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

Protege pantallas sensibles de SwiftUI con un escudo de privacidad que aparece cuando la app pasa a inactiva y, opcionalmente, cuando se detecta captura de pantalla. `ScreenPrivacy` también aplica `privacySensitive()` y puede alojar el contenido protegido dentro de un contenedor seguro para dificultar capturas y grabaciones.

## Por Qué ScreenPrivacy

- Protección en una línea para vistas sensibles de SwiftUI.
- Snapshots seguros en el app switcher mediante protección al quedar inactiva la escena.
- Detección de captura opcional como capa extra sobre el comportamiento por inactividad.
- Escudo personalizado cuando necesitas mensajes o visuales propios.
- API pública pequeña con acceso tanto por modificador como por contenedor.

## Tabla de Contenidos

- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [Inicio Rápido](#inicio-rápido)
- [Personalización](#personalización)
- [Comportamiento](#comportamiento)
- [Cuándo Usarlo](#cuándo-usarlo)
- [Estructura Del Paquete](#estructura-del-paquete)
- [Tests](#tests)
- [FAQ](#faq)
- [Licencia](#licencia)

## Requisitos

- iOS 17.0 o posterior
- macOS 14.0 o posterior
- Swift 6.0 o posterior

Estos requisitos coinciden con el `Package.swift` incluido en el repositorio.

## Instalación

Añade `ScreenPrivacy` como dependencia de Swift Package en Xcode o en `Package.swift`:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Después importa el módulo donde vayas a proteger una vista:

```swift
import ScreenPrivacy
import SwiftUI
```

## Inicio Rápido

El modificador por defecto es la vía rápida:

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

### Escudo Personalizado

Usa un escudo personalizado cuando quieras controlar el tono, los colores o el layout:

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

                    Text("Privado")
                        .font(.title2)
                        .bold()

                    Text("Oculto mientras esta pantalla no sea segura para mostrarse.")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.background)
                .foregroundStyle(.primary)
            }
    }
}
```

### API Con Contenedor

Si prefieres composición en lugar de modificadores:

```swift
struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Personalización

`ScreenPrivacy` mantiene una API pequeña:

| Opción | Valor por defecto | Propósito |
| --- | --- | --- |
| `isEnabled` | `true` | Activa o desactiva el comportamiento del escudo. |
| `includeCaptureDetection` | `true` | Añade protección por captura sobre el escudo por inactividad. |
| `blocksScreenCapture` | `true` | Usa un contenedor seguro para dificultar capturas y grabaciones. |

Ejemplo con configuración explícita:

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

## Comportamiento

- Muestra el escudo cuando la escena pasa a inactiva.
- También puede mostrar el escudo cuando se detecta captura de pantalla.
- Aplica `privacySensitive()` al contenido protegido.
- Usa un contenedor seguro basado en un campo de texto cuando `blocksScreenCapture` está activado en plataformas UIKit.
- Anima la aparición del escudo con una transición de opacidad.
- Usa un wrapper SwiftUI normal cuando UIKit no está disponible durante pruebas host-side.

## Cuándo Usarlo

`ScreenPrivacy` encaja bien cuando tu app muestra:

- saldos o detalles de pago
- datos de salud o bienestar
- notas privadas, diarios o mensajes
- dashboards internos o herramientas operativas
- cualquier cosa que no deba verse en snapshots del app switcher

## Estructura Del Paquete

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

El paquete incluye cobertura con Swift Testing para las reglas de visibilidad y el comportamiento del monitor, incluyendo:

- protección en estado inactivo
- protección activada por captura
- recálculo al activar o desactivar la protección
- activación o desactivación de la detección de captura
- proveedores inyectados del estado de captura

## FAQ

**¿Bloquea las capturas?**  
Por defecto dificulta capturas y grabaciones alojando el contenido protegido dentro de un contenedor seguro cuando `blocksScreenCapture` es `true`.

**¿Funciona en widgets o extensiones?**  
Está diseñado para vistas SwiftUI dentro de tu app. Las timelines de widgets quedan fuera de alcance.

**¿Puedo añadir analítica o logging?**  
Sí. Puedes envolver `ScreenPrivacyContainer` o la pantalla protegida con tu propia lógica de ciclo de vida sin cambiar la API del paquete.

**¿Debería dejar siempre activada la detección de captura?**  
Normalmente sí. Pero si tu producto solo necesita privacidad en el app switcher, establece `includeCaptureDetection` en `false`.

## Licencia

[MIT](../LICENSE)
