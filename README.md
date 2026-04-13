# Task Manager App

A clean and modern Flutter task management application with user authentication and real-time data synchronization using Supabase.

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

## Backend Choice: Supabase

I chose Supabase as the backend for several reasons:

1. **All-in-one Solution**: Provides authentication, database, and real-time features in a single platform
2. **PostgreSQL**: Uses a robust, scalable database
3. **Built-in Authentication**: Secure email/password authentication with session management
4. **Real-time Support**: Automatic real-time updates for task synchronization
5. **Row Level Security**: Built-in security policies for user data isolation
6. **Free Tier**: Generous free plan for development and small projects
7. **Easy Setup**: Quick configuration without complex infrastructure management

## Setup Instructions

### Prerequisites

- Flutter SDK (>= 3.10.0)
- Dart SDK (>= 3.0.0)
- A Supabase account

### 1. Clone and Install Dependencies

```bash
git clone <repository-url>
cd task_manager_app
flutter pub get
```

### 2. Supabase Setup

1. **Create a Supabase Project**
   - Go to [supabase.com](https://supabase.com)
   - Create a new project
   - Wait for the project to be ready

2. **Get Supabase Credentials**
   - Go to Project Settings > API
   - Copy the Project URL and anon public key

3. **Configure the Database**
   - Go to the SQL Editor in Supabase
   - Run the following SQL to create the tasks table:

```sql
-- Create tasks table
CREATE TABLE tasks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  is_completed BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can view their own tasks" ON tasks
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own tasks" ON tasks
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own tasks" ON tasks
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own tasks" ON tasks
  FOR DELETE USING (auth.uid() = user_id);

-- Create index for better performance
CREATE INDEX idx_tasks_user_id ON tasks(user_id);
CREATE INDEX idx_tasks_created_at ON tasks(created_at);
```

4. **Update App Configuration**
   - Open `lib/core/constants/app_constants.dart`
   - Replace the placeholder Supabase URL and anon key with your actual credentials:

```dart
static const String supabaseUrl = 'https://your-project-id.supabase.co';
static const String supabaseAnonKey = 'your-anon-key-here';
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
- **Supabase**: Backend-as-a-Service platform
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
- Review the Supabase documentation

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
