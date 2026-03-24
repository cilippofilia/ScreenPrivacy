<img src="Images/screenPrivacy_pill.svg" alt="Логотип ScreenPrivacy" width="40%" />

# ScreenPrivacy

[English](../README.md) 🇬🇧 | [Italiano](README.it.md) 🇮🇹 | [Español](README.es.md) 🇪🇸 | [Français](README.fr.md) 🇫🇷 | [Deutsch](README.de.md) 🇩🇪 | [Русский](README.ru.md) 🇷🇺

`ScreenPrivacy` представляет собой SwiftUI-пакет для скрытия чувствительных экранов, когда ваше приложение становится неактивным и, при необходимости, когда обнаружен захват экрана. Он применяет `privacySensitive()` к защищённому контенту и может оборачивать этот контент в безопасный контейнер на базе UIKit, когда включена блокировка захвата.

## О Пакете

Используйте `ScreenPrivacy`, когда представление не должно оставаться видимым ни в снимках app switcher, ни во время активного захвата. Пакет делает интеграцию простой:

- применяйте один view modifier для самого распространённого сценария
- переходите к контейнеру, если композиция лучше читается в иерархии представлений
- оставляйте стандартный экран или передавайте собственное shield-представление
- отключайте обнаружение захвата, если вам нужна только защита для неактивной сцены

## Установка

Добавьте `ScreenPrivacy` как зависимость Swift Package в Xcode или подключите его из `Package.swift` во время локальной разработки:

```swift
dependencies: [
    .package(path: "../Packages/ScreenPrivacy")
]
```

Затем импортируйте его в любом SwiftUI-файле, которому нужна защита:

```swift
import ScreenPrivacy
import SwiftUI
```

## Быстрый Старт

Минимально полезная интеграция выглядит так:

```swift
struct AccountView: View {
    var body: some View {
        AccountDetailsView()
            .screenPrivacyShield()
    }
}
```

Он использует стандартный экран, включает обнаружение захвата и по умолчанию включает безопасный рендеринг.

## Использование

Используйте собственный экран, если запасной интерфейс должен соответствовать языку вашего продукта:

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

                    Text("Приватно")
                        .font(.title2)
                        .bold()

                    Text("Скрыто, пока этот экран небезопасно показывать.")
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.background)
                .foregroundStyle(.primary)
            }
    }
}
```

Если вы предпочитаете композицию модификатору, используйте `ScreenPrivacyContainer`:

```swift
struct AccountView: View {
    var body: some View {
        ScreenPrivacyContainer {
            AccountDetailsView()
        }
    }
}
```

## Конфигурация

`ScreenPrivacy` предоставляет три runtime-настройки:

| Опция | По умолчанию | Эффект |
| --- | --- | --- |
| `isEnabled` | `true` | Включает или отключает экран приватности. |
| `includeCaptureDetection` | `true` | Показывает экран, когда экран устройства захватывается. |
| `blocksScreenCapture` | `true` | Оборачивает контент в безопасный контейнер пакета на платформах UIKit. |

Пример:

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

## Поведение

Правила видимости в пакете намеренно сведены к минимуму:

- если защита отключена, экран остаётся скрытым
- если сцена становится неактивной, экран становится видимым
- если обнаружение захвата включено и экран захватывается, экран становится видимым
- защищённый контент помечается с помощью `privacySensitive()`
- показ экрана использует переход по непрозрачности

На платформах UIKit безопасный рендеринг реализован через контейнер на основе защищённого текстового поля. В средах, где UIKit недоступен, пакет использует обычную SwiftUI-обёртку.

## Когда Использовать

`ScreenPrivacy` хорошо подходит для экранов с:

- балансами счетов или платёжными данными
- данными о здоровье или благополучии
- личными заметками, дневниками или сообщениями
- внутренними дашбордами или операционными инструментами

## Требования

- iOS 17.0 или новее
- macOS 14.0 или новее
- Swift 6.0 или новее

Эти значения соответствуют зафиксированному в репозитории `Package.swift`.

## Структура Пакета

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

## Тесты

Пакет включает покрытие Swift Testing для:

- защиты при неактивной сцене
- защиты, вызванной захватом экрана
- пересчёта при включении и отключении
- включения и отключения обнаружения захвата
- внедряемых провайдеров состояния захвата

## Лицензия

[MIT](../LICENSE)
