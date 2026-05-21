# MRT Clone Flutter App

Mobile frontend for the MRT Jakarta clone project. This app connects to the MRT backend API to provide ticket booking, schedule lookup, payment, and profile management features.

## Overview

This Flutter application is built using:
- Flutter
- Dart
- `flutter_bloc` for state management
- `go_router` for navigation
- `dio` for HTTP communication
- `flutter_secure_storage` for local token storage

The app uses a clean architecture style with separate layers for:
- network and API client configuration
- repositories
- BLoC state management
- feature-specific presentation and pages

## Key Features

- User authentication and PIN-based login
- MRT schedule browsing by station and day type
- Ticket purchase flow with voucher support
- Payment integration using Xendit invoices
- Activity history and transaction details
- Profile and settings pages
- Help, FAQ, privacy policy, and terms screens

## Getting Started

### Prerequisites

- Flutter SDK installed
- An Android/iOS emulator or physical device
- A running backend instance (see `mrt_backend`)

### Install dependencies

```bash
cd mrt_clone
flutter pub get
```

### Run the app

```bash
flutter run
```

### Backend URL

The app currently uses the default backend base URL from `lib/core/network/api_config.dart`:

```dart
static const String baseUrl = 'http://10.0.2.2:5000/api/v1';
```

For Android emulator usage, `10.0.2.2` maps to `localhost` on the host machine. If you run the app on a real device or another emulator, update this URL accordingly.

## Project Structure

- `lib/main.dart`: app entrypoint and global BLoC providers
- `lib/config/routes/app_router.dart`: navigation routes
- `lib/core/network`: API client and token storage
- `lib/features`: feature modules for auth, ticketing, profile, and more
- `lib/shared`: shared models, widgets, and helpers

## Notes

- The app automatically attaches an authorization header when a JWT token is stored.
- The payment flow uses a backend payment endpoint to generate Xendit invoice URLs.
- If you modify the backend URL or API contract, ensure the app repositories and BLoCs remain aligned.

## Developer Tips

- Use `flutter clean` if build issues occur after dependency or asset changes.
- Keep the backend running before testing ticket purchase and payment flows.
- Use the existing backend seed script to load sample stations, schedules, and vouchers.
