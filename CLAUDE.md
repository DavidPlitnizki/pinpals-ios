# Pinpals iOS App

## Overview
Pinpals — iOS-приложение для отметки мест на карте, планирования походов и встреч, сохранения заметок и фото как воспоминаний, и шаринга локации с друзьями.

## Tech Stack
- **SwiftUI** (iOS 26.2+)
- **SwiftData** — локальное хранение данных
- **MapKit** — карты и аннотации
- **CoreLocation** — геолокация
- **Architecture**: MVVM + `@Observable`
- **Dependencies**: Нулевые (всё нативное)

## Project Structure
```
Pinpals/
├── PinpalsApp.swift              # Entry point, ModelContainer setup
├── DesignSystem/                 # Design tokens и reusable компоненты
│   ├── Colors.swift              # Color.Pin.brandPrimary и т.д.
│   ├── Spacing.swift             # PinSpacing.space4 и т.д.
│   ├── Radius.swift              # PinRadius.md и т.д.
│   ├── Typography.swift          # Font.Pin.title и т.д.
│   └── Components/              # PinButton, PinCard, PinChip, PinTextField, PinRatingView
├── Models/                       # SwiftData @Model классы
│   ├── Place.swift               # Место с координатами, категорией, рейтингом
│   ├── PlaceNote.swift           # Заметка с фото к месту
│   ├── PlaceCategory.swift       # Enum: food, nature, art, sports, coffee
│   ├── Meeting.swift             # Встреча с датой и локацией
│   └── UserProfile.swift         # Профиль пользователя
├── Features/                     # Экраны по фичам
│   ├── Map/                      # Карта с пинами
│   ├── Explore/                  # Поиск мест
│   ├── MyPlaces/                 # Сохранённые места
│   ├── PlaceDetail/              # Детали места и заметки
│   ├── CreateMeeting/            # Создание встречи
│   ├── Profile/                  # Профиль
│   ├── Auth/                     # Login/SignIn (Phase 2)
│   └── Onboarding/               # Онбординг (Phase 2)
├── Navigation/                   # TabView + Router
│   ├── AppTabView.swift          # 4 таба: Map, Explore, My Places, Chat
│   └── Router.swift              # NavigationPath routing
├── Services/                     # Бизнес-логика (за протоколами)
└── Utilities/                    # Хелперы
```

## Design Tokens
Из Pencil.dev (`/Users/davidplitnizki/projects/designs/spotly.pen`):
- **Brand**: green palette (#4A7C59, #2C5C3F, #D6EDE1)
- **Accent**: orange (#E8834A, #FDEBD0)
- **Neutral**: #F0F5F2 → #1C2B22
- **Spacing**: 4, 8, 12, 16, 20, 24, 32, 48
- **Radii**: 8, 12, 16, 9999
- **Typography**: System Rounded

## Architecture Conventions
- **ViewModels** не импортируют SwiftUI
- **Views** не содержат бизнес-логику
- **Services** за протоколами для замены local→remote
- Каждый feature = папка с Screen + ViewModel
- Design tokens используются через `Color.Pin.*`, `Font.Pin.*`, `PinSpacing.*`, `PinRadius.*`

## Development Phases
- **Phase 1** (current): Соло-фичи — карта, explore, my places, place detail, meetings, profile
- **Phase 2**: Социальные фичи — чат, шаринг локации, друзья, Auth/Onboarding

## Build
```bash
xcodebuild -project Pinpals.xcodeproj -scheme Pinpals -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build
```
