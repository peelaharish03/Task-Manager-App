# Task Manager App

A clean and modern Flutter task management application with user authentication and real-time data synchronization using Firebase Authentication and Cloud Firestore.

## Features

- **User Authentication**
  - Sign up with email and password
  - Login with existing account
  - Secure logout and session management
  - Persistent user sessions

- **Task Management**
  - Create, read, update, and delete tasks
  - Mark tasks as complete/incomplete
  - Real-time task synchronization
  - Pull-to-refresh functionality
  - Task search and filtering

- **Clean Architecture**
  - Separation of concerns with layered architecture
  - Repository pattern for data access
  - Use cases for business logic
  - State management with Riverpod

- **Modern UI/UX**
  - Material Design 3 components
  - Dark/light theme support
  - Smooth animations and transitions
  - Responsive design

## Architecture

This app follows Clean Architecture principles with the following structure:

```
lib/
|-- core/
|   |-- constants/          # App constants
|   |-- errors/            # Custom error types
|   |-- utils/             # Result wrapper and utilities
|   |-- theme/             # App themes
|   |-- di/                # Dependency injection
|-- features/
|   |-- auth/              # Authentication feature
|   |   |-- data/          # Data layer (models, repositories)
|   |   |-- domain/        # Domain layer (entities, use cases)
|   |   |-- presentation/  # UI layer (screens, providers)
|   |-- tasks/             # Task management feature
|   |   |-- data/
|   |   |-- domain/
|   |   |-- presentation/
|-- shared/                # Shared widgets and utilities
```

## Backend Choice: Firebase

I chose Firebase as the backend for several reasons:

1. **Tight Flutter integration**: First-party SDKs and tooling for Flutter
2. **Authentication**: Email/password auth with session persistence
3. **Cloud Firestore**: Scalable document database with real-time streams
4. **Real-time updates**: Task list stays in sync automatically
5. **Simple client architecture**: Works cleanly with repository + use case patterns
6. **Great developer experience**: Fast iteration, good emulator/tooling support

## Setup Instructions

### Prerequisites

- Flutter SDK (>= 3.10.0)
- Dart SDK (>= 3.0.0)
- A Firebase project

### 1. Clone and Install Dependencies

```bash
git clone <repository-url>
cd task_manager_app
flutter pub get
```

### 2. Firebase Setup

1. **Create a Firebase project**
   - Go to https://console.firebase.google.com
   - Create a new project

2. **Enable Email/Password auth**
   - Firebase Console → Authentication → Sign-in method → enable Email/Password

3. **Create Firestore database**
   - Firebase Console → Firestore Database → Create database

4. **Configure the Flutter app**
   - Install FlutterFire CLI and configure:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This generates/updates `lib/firebase_options.dart` and platform config files (e.g. `android/app/google-services.json`).

5. **Firestore data model**

Tasks are stored under the `tasks` collection with these fields:

- `id` (string)
- `title` (string)
- `description` (string)
- `is_completed` (bool)
- `created_at` (timestamp)
- `updated_at` (timestamp, optional)
- `user_id` (string)

6. **Firestore security rules (recommended)**

Use rules that restrict tasks to the authenticated user:

```txt
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /tasks/{taskId} {
      allow read, write: if request.auth != null &&
        request.resource.data.user_id == request.auth.uid;
      allow read: if request.auth != null &&
        resource.data.user_id == request.auth.uid;
    }
  }
}
```

### 3. Run the App

```bash
flutter run
```

## Android Storage Issue Solution

If you encounter the "not enough space" error on Android:

1. **Free up device storage**:
   - Clear app cache
   - Remove unused apps
   - Delete old photos/videos

2. **Use a different device/emulator**:
   ```bash
   flutter devices
   flutter run -d <device-id>
   ```

3. **Use web version for testing**:
   ```bash
   flutter run -d web-server
   ```

## Usage

1. **Sign Up**: Create a new account with email and password
2. **Login**: Access your account with credentials
3. **Create Tasks**: Add new tasks with title and description
4. **Manage Tasks**: Mark complete, edit details, or delete tasks
5. **Real-time Sync**: Changes sync automatically across devices

## Development

### Key Technologies

- **Flutter**: Cross-platform UI framework
- **Riverpod**: State management solution
- **Firebase Auth**: Authentication backend
- **Cloud Firestore**: Database + realtime updates
- **Go Router**: Navigation and routing
- **Material 3**: Modern design system

### Code Quality

- Clean Architecture with separation of concerns
- Repository pattern for data access
- Result wrapper for error handling
- Type-safe programming with Dart
- Comprehensive error handling
- Loading states and user feedback

### Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Build & Deploy

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions:
- Create an issue on GitHub
- Check the troubleshooting section
- Review the Firebase documentation

## Future Enhancements

- Task categories and labels
- Due dates and reminders
- Task sharing and collaboration
- Offline support with local caching
- Push notifications
- Advanced search and filtering
- Data export functionality
- Analytics and reporting
# Task-Manager-App
