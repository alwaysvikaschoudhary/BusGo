# BusGo 🚌

> A Premium Bus Reservation Application built with Flutter

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=flat&logo=dart&logoColor=white)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Overview

BusGo is a modern, responsive, and cross-platform frontend for a comprehensive bus reservation system. Designed with a focus on user experience and seamless booking flows, it allows users to search for buses, select seats, manage bookings, and handle payments smoothly. 

Whether you're building a commercial booking platform or a large-scale public transport app, BusGo provides a robust UI foundation.

## Features

- **Intuitive Bus Search**: Search for buses between cities with date filters.
- **Dynamic Seat Selection**: Visual and interactive seat layouts.
- **Booking Management**: View past, active, and cancelled bookings.
- **Passenger Details**: Secure form handling for passenger information.
- **Premium UI/UX**: Built with modern design principles, utilizing Shimmer loading effects and smooth page transitions.
- **State Management**: Scalable and predictable state handled via Provider.

## Screenshots

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="./screenshots/MixCollage-23-May-2026-11-57-PM-4034.jpg" width="30%" alt="Screenshot 1"/>
  <img src="./screenshots/MixCollage-23-May-2026-11-58-PM-6420.jpg" width="30%" alt="Screenshot 2"/>
  <img src="./screenshots/MixCollage-23-May-2026-11-59-PM-3101.jpg" width="30%" alt="Screenshot 3"/>
  <img src="./screenshots/MixCollage-24-May-2026-12-00-AM-366.jpg" width="30%" alt="Screenshot 4"/>
  <img src="./screenshots/MixCollage-24-May-2026-12-00-AM-7737.jpg" width="30%" alt="Screenshot 5"/>
</div>

## Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Provider
- **Fonts:** Google Fonts
- **UI Packages:** 
  - `smooth_page_indicator` (Onboarding/Sliders)
  - `shimmer` (Loading Skeletons)
- **Utilities:** `intl` (Date/Time formatting)

## Installation

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.10.4 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code with Flutter plugins installed

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/alwaysvikaschoudhary/BusGo.git
   cd BusGo
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the App**
   ```bash
   flutter run
   ```

## Configuration

> **TODO:** Add environment variables documentation once the backend integration and `.env` files are fully configured.

- **API Base URL**: Currently hardcoded/mocked. Will be configurable via environment variables in future releases.

## Project Structure

```text
lib/
├── main.dart             # Application entry point
├── screens/              # UI Screens (Home, Search, Booking, etc.)
├── widgets/              # Reusable UI components
├── providers/            # State management classes
├── models/               # Data models
└── utils/                # Helper functions and constants
```

## API Documentation

> **TODO:** Integrate comprehensive API documentation once the backend endpoints are finalized.

## Scripts

Use the following commands for development and testing:

| Command | Description |
|---|---|
| `flutter run` | Starts the app in debug mode |
| `flutter test` | Runs all unit and widget tests |
| `flutter analyze` | Runs Dart static analysis |
| `flutter build apk` | Builds a release APK for Android |
| `flutter build ios` | Builds a release IPA for iOS |

## Deployment

### Android
```bash
flutter build apk --release
# OR for App Bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```
*Note: iOS deployment requires Xcode and a valid Apple Developer account.*

## Testing

To run the test suite:

```bash
flutter test
```
*Currently utilizes the default `flutter_test` framework.*

## Performance & Security

- **Optimization**: Implements Shimmer for non-blocking UI rendering during data fetches.
- **State**: Uses `Provider` efficiently to rebuild only necessary widget subtrees, ensuring 60fps scrolling and transitions.
- **Security**: *TODO: Detail token management and secure storage implementations.*

## Troubleshooting

- **Issue:** `flutter pub get` fails or gets stuck.
  - **Fix:** Run `flutter clean` then try `flutter pub get` again.
- **Issue:** iOS build fails with Cocoapods error.
  - **Fix:** Navigate to the `ios` directory, run `pod repo update` and then `pod install`.

## Roadmap

- [ ] Integrate live backend APIs
- [ ] Add Payment Gateway (Stripe/Razorpay) integration
- [ ] Implement Push Notifications for booking updates
- [ ] Add multi-language support (i18n)
- [ ] Dark Mode support

## Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Maintainer: Vikas Choudhary - [@alwaysvikaschoudhary](https://github.com/alwaysvikaschoudhary)
