# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

ScreenPrivacy ofrece un escudo de privacidad ligero para SwiftUI que cubre automáticamente las vistas sensibles cuando la app pasa a inactiva o cuando se detecta captura de pantalla. También habilita el renderizado seguro por defecto, que impide capturas y grabaciones de pantalla del contenido protegido. Está pensado para ser un añadido de una sola línea, manteniendo la UI limpia, testeable y respetuosa con la privacidad.

Casos de uso útiles:
- Muestras saldos, datos de salud o información personal.
- Soportas multitarea y quieres snapshots seguros de la app.
- Necesitas un escudo por defecto rápido pero totalmente personalizable.
- Quieres bloquear capturas y grabaciones sin configuración extra.

## Requisitos

- iOS 26.0 o posterior
- Swift 6.2 o posterior

## Instalación

Añade ScreenPrivacy como dependencia de Swift Package en Xcode o mediante `Package.swift`.

## Uso

Aplica el modificador a cualquier vista que quieras proteger:

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

Proporciona un escudo personalizado cuando quieras un aspecto con marca:

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
                    Text("Privado")
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

Usa el contenedor si prefieres composición:

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

## Comportamiento

- Muestra el escudo cuando la escena se vuelve inactiva.
- Opcionalmente muestra el escudo cuando se detecta captura de pantalla.
- Aplica `privacySensitive()` al contenido protegido.
- Usa renderizado seguro por defecto para bloquear capturas y grabaciones.
- El renderizado seguro se implementa alojando SwiftUI dentro del canvas de un campo de texto seguro.

## Personalización

- Establece `isEnabled` en `false` para desactivar el escudo.
- Establece `includeCaptureDetection` en `false` si solo quieres escudo en inactividad.
- Establece `blocksScreenCapture` en `false` si quieres solo el escudo sin renderizado seguro.

## Consejos

- Usa un escudo personalizado mínimo para transiciones suaves.
- Prefiere `.background(.background)` para un aspecto adaptativo claro/oscuro.
- Si usas tu propio color de fondo, asegúrate de que el texto sea legible en ambos temas.

## FAQ

**¿Bloquea las capturas?**  
Sí. ScreenPrivacy usa un contenedor de campo de texto seguro para bloquear capturas y grabaciones de pantalla por defecto.

**¿Funciona en widgets o extensiones?**  
Este paquete está pensado para vistas SwiftUI en tu app. No está diseñado para proteger timelines de widgets.

**¿Puedo añadir analítica o logging?**  
Sí. Puedes envolver `ScreenPrivacyContainer` y observar el ciclo de vida de la app para registrar eventos, sin cambiar el escudo.

## Licencia

MIT
