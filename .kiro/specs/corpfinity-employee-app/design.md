# Design Document

## Overview

The Corpfinity Employee App is a Flutter-based mobile application that provides employees with quick wellness activities. The app follows a clean architecture pattern with clear separation between presentation, business logic, and data layers. The design emphasizes smooth animations, consistent visual language, and offline-first capabilities with backend synchronization.

### Technology Stack

- **Framework**: Flutter 3.x
- **State Management**: Provider / Riverpod
- **Navigation**: GoRouter
- **Local Storage**: Hive / SharedPreferences
- **HTTP Client**: Dio
- **Animations**: Lottie, Flutter built-in animations
- **Backend**: FastAPI (future integration)

## Architecture

The application follows a layered architecture pattern:

```
┌─────────────────────────────────────┐
│      Presentation Layer             │
│  (Screens, Widgets, Animations)     │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│      Business Logic Layer           │
│  (Providers, State Management)      │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│         Data Layer                  │
│  (Repositories, API Services)       │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│    Data Sources                     │
│  (Local DB, Remote API)             │
└─────────────────────────────────────┘
```

### Directory Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── colors.dart
│   │   ├── typography.dart
│   │   └── dimensions.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   └── animations.dart
│   └── widgets/
│       ├── custom_button.dart
│       ├── custom_card.dart
│       └── progress_bar.dart
├── features/
│   ├── onboarding/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   ├── auth/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── providers/
│   │   └── models/
│   ├── home/
│   │   ├── screens/
│   │   ├── widgets/
│   │   └── providers/
│   ├── activities/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── providers/
│   │   └── models/
│   ├── progress/
│   │   ├── screens/
│   │   ├── widgets/
│   │   ├── providers/
│   │   └── models/
│   └── profile/
│       ├── screens/
│       ├── widgets/
│       └── providers/
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
└── routes/
    └── app_router.dart
```

## Components and Interfaces

### 1. Core Components

#### Theme System

```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.calmBlue,
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: 'Inter',
    // ... theme configuration
  );
}

class AppColors {
  static const Color calmBlue = Color(0xFF4A90E2);
  static const Color softGreen = Color(0xFF7ED321);
  static const Color warmOrange = Color(0xFFF5A623);
  static const Color gentleRed = Color(0xFFE85D75);
  static const Color neutralGray = Color(0xFFECF0F1);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkText = Color(0xFF2C3E50);
  static const Color mediumGray = Color(0xFF7F8C8D);
}
```

#### Reusable Widgets

**CustomButton**: Standardized button with primary/secondary variants
**CustomCard**: Card widget with consistent shadow and border radius
**ProgressBar**: Animated progress bar with gradient support
**EnergyLevelCard**: Selectable card for energy level selection
**WellnessPillarCard**: Grid card for wellness pillar display
**ActivityCard**: List/grid card for activity display

### 2. Navigation System

```dart
// Using GoRouter for declarative routing
final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
    GoRoute(path: '/welcome', builder: (context, state) => WelcomeCarousel()),
    GoRoute(path: '/auth/signup', builder: (context, state) => SignUpScreen()),
    GoRoute(path: '/auth/profile-setup', builder: (context, state) => ProfileSetupScreen()),
    GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/pillars', builder: (context, state) => WellnessPillarScreen()),
    GoRoute(path: '/activities', builder: (context, state) => ActivitySelectionScreen()),
    GoRoute(path: '/activity/:id', builder: (context, state) => ActivityGuideScreen()),
    GoRoute(path: '/completion', builder: (context, state) => CompletionScreen()),
    GoRoute(path: '/progress', builder: (context, state) => ProgressScreen()),
    GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    GoRoute(path: '/library', builder: (context, state) => ActivityLibraryScreen()),
  ],
);
```

### 3. State Management

Using Provider/Riverpod pattern for state management:

**AuthProvider**: Manages authentication state, user session
**UserProvider**: Manages user profile and preferences
**ActivityProvider**: Manages activity data, recommendations
**ProgressProvider**: Manages streaks, badges, history
**NavigationProvider**: Manages navigation state and parameters

### 4. Feature Modules

#### Onboarding Module

**Screens**:
- SplashScreen: Animated logo with auto-transition
- WelcomeCarousel: PageView with 3 slides and navigation dots

**Key Widgets**:
- CarouselSlide: Individual slide with illustration and text
- NavigationDots: Indicator for current slide position

#### Authentication Module

**Screens**:
- SignUpScreen: Email/password registration with SSO options
- SignInScreen: Login form
- ProfileSetupScreen: Initial profile configuration

**Models**:
```dart
class User {
  final String id;
  final String email;
  final String name;
  final String? company;
  final List<String> wellnessGoals;
  final NotificationPreferences notifications;
}

class NotificationPreferences {
  final bool enabled;
  final bool dailyReminders;
  final bool achievementAlerts;
}
```

**Providers**:
- AuthProvider: Handles registration, login, SSO
- ProfileProvider: Manages profile setup and updates

#### Home Module

**Screens**:
- HomeScreen: Dashboard with energy level selection and quick stats

**Widgets**:
- EnergyLevelCard: Selectable card with color coding (Low/Medium/High)
- QuickStatsWidget: Displays streak, weekly progress, total activities
- AnimatedProgressBar: Gradient progress bar with animation

**State**:
```dart
class HomeState {
  final String userName;
  final int currentStreak;
  final double weeklyProgress;
  final int totalActivities;
  final EnergyLevel? selectedEnergy;
}

enum EnergyLevel { low, medium, high }
```

#### Activities Module

**Screens**:
- WellnessPillarScreen: Grid of 6 wellness pillars
- ActivitySelectionScreen: List of recommended activities
- ActivityGuideScreen: Step-by-step activity instructions
- CompletionScreen: Success feedback with confetti
- ActivityLibraryScreen: Searchable activity catalog

**Models**:
```dart
class WellnessPillar {
  final String id;
  final String name;
  final String description;
  final String iconPath;
  final int availableActivities;
}

class Activity {
  final String id;
  final String name;
  final String pillarId;
  final int durationMinutes;
  final Difficulty difficulty;
  final String location;
  final String thumbnailUrl;
  final List<ActivityStep> steps;
}

class ActivityStep {
  final int stepNumber;
  final String title;
  final String instruction;
  final String? imageUrl;
  final int? timerSeconds;
}

enum Difficulty { low, medium, high }
```

**Providers**:
- WellnessPillarProvider: Manages pillar data
- ActivityProvider: Handles activity recommendations and filtering
- ActivityGuideProvider: Manages current activity state and step progression

#### Progress Module

**Screens**:
- ProgressScreen: Tabbed view with Streaks, History, Badges

**Models**:
```dart
class ProgressData {
  final int currentStreak;
  final int longestStreak;
  final List<DateTime> completedDays;
  final List<CompletedActivity> history;
  final List<Badge> badges;
}

class CompletedActivity {
  final String activityId;
  final String activityName;
  final DateTime completedAt;
  final int pointsEarned;
}

class Badge {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final bool isUnlocked;
  final DateTime? unlockedAt;
}
```

**Widgets**:
- StreakCalendar: Calendar grid with highlighted completion days
- HistoryList: Scrollable list of completed activities
- BadgeGrid: Grid of earned and locked badges with unlock animation

#### Profile Module

**Screens**:
- ProfileScreen: User settings and preferences

**Widgets**:
- ProfileHeader: User photo, name, total points
- SettingsToggle: Reusable toggle switch for preferences
- LanguageSelector: Dropdown for language selection

## Data Models

### Core Data Models

```dart
// User Model
class User {
  final String id;
  final String email;
  final String name;
  final String? company;
  final String? photoUrl;
  final List<String> wellnessGoals;
  final NotificationPreferences notifications;
  final int totalPoints;
  final DateTime createdAt;
}

// Activity Model
class Activity {
  final String id;
  final String name;
  final String description;
  final String pillarId;
  final int durationMinutes;
  final Difficulty difficulty;
  final String location;
  final String thumbnailUrl;
  final List<ActivityStep> steps;
  final List<String> tags;
}

// Progress Model
class UserProgress {
  final String userId;
  final int currentStreak;
  final int longestStreak;
  final int totalActivitiesCompleted;
  final double weeklyGoalProgress;
  final List<DateTime> completedDays;
  final List<Badge> earnedBadges;
}
```

### Repository Interfaces

```dart
abstract class AuthRepository {
  Future<User> signUp(String email, String password);
  Future<User> signIn(String email, String password);
  Future<User> signInWithSSO(SSOProvider provider);
  Future<void> signOut();
  Future<User?> getCurrentUser();
}

abstract class UserRepository {
  Future<User> getUser(String userId);
  Future<User> updateUser(User user);
  Future<void> updatePreferences(NotificationPreferences prefs);
}

abstract class ActivityRepository {
  Future<List<Activity>> getRecommendedActivities(EnergyLevel energy, String pillarId);
  Future<List<Activity>> getAllActivities();
  Future<List<Activity>> searchActivities(String query);
  Future<Activity> getActivityById(String id);
  Future<void> completeActivity(String activityId);
}

abstract class ProgressRepository {
  Future<UserProgress> getUserProgress(String userId);
  Future<List<CompletedActivity>> getActivityHistory(String userId);
  Future<void> recordActivityCompletion(String activityId);
}
```

## Error Handling

### Error Types

```dart
abstract class AppException implements Exception {
  final String message;
  final String? code;
  AppException(this.message, [this.code]);
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message, 'NETWORK_ERROR');
}

class AuthException extends AppException {
  AuthException(String message) : super(message, 'AUTH_ERROR');
}

class ValidationException extends AppException {
  ValidationException(String message) : super(message, 'VALIDATION_ERROR');
}
```

### Error Handling Strategy

1. **Network Errors**: Display user-friendly messages with retry options
2. **Validation Errors**: Show inline form validation with clear error messages
3. **Authentication Errors**: Redirect to login with appropriate error message
4. **Unexpected Errors**: Log to error tracking service, show generic error message

### Error UI Components

- **SnackBar**: For temporary error messages
- **ErrorDialog**: For critical errors requiring user acknowledgment
- **InlineError**: For form validation errors
- **RetryWidget**: For network errors with retry button

## Testing Strategy

### Unit Tests

- **Models**: Test data serialization/deserialization
- **Validators**: Test email, password validation logic
- **Providers**: Test state management logic
- **Repositories**: Test data fetching and caching logic

### Widget Tests

- **Custom Widgets**: Test rendering and interactions
- **Screens**: Test UI composition and user interactions
- **Forms**: Test validation and submission flows

### Integration Tests

- **User Flows**: Test complete user journeys
  - Onboarding flow (splash → carousel → signup → profile setup → home)
  - Activity completion flow (home → pillar → activity → guide → completion)
  - Progress tracking flow (complete activities → view progress → earn badges)

### Test Coverage Goals

- Unit Tests: 80% coverage
- Widget Tests: 70% coverage
- Integration Tests: Key user flows

## Animation Specifications

### Transition Animations

```dart
class AppAnimations {
  static const Duration slideTransition = Duration(milliseconds: 300);
  static const Duration fadeTransition = Duration(milliseconds: 250);
  static const Duration bounceAnimation = Duration(milliseconds: 200);
  static const Duration confettiDuration = Duration(milliseconds: 1000);
  
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;
}
```

### Specific Animations

1. **Splash Screen**: Logo fade-in (0 → 100% opacity, 800ms)
2. **Carousel**: Slide transition between pages (300ms)
3. **Energy Cards**: Tap scale animation (0.95 → 1.0)
4. **Wellness Goal Chips**: Bounce on selection (0.9 → 1.0 → 1.0)
5. **Progress Bar**: Animated fill with gradient
6. **Confetti**: Lottie animation on activity completion
7. **Badge Unlock**: Pulse effect (scale 0 → 1.2 → 1.0)

## Responsive Design

### Breakpoints

- **Small**: 320px - 375px (iPhone SE, small phones)
- **Medium**: 376px - 414px (iPhone 12, standard phones)
- **Large**: 415px+ (iPhone Pro Max, tablets)

### Responsive Strategies

1. **Flexible Layouts**: Use Flexible, Expanded widgets
2. **MediaQuery**: Adapt spacing and sizes based on screen dimensions
3. **LayoutBuilder**: Adjust grid columns for tablets
4. **Responsive Typography**: Scale font sizes proportionally
5. **Safe Areas**: Respect device notches and system UI

### Accessibility

- **Semantic Labels**: All interactive elements have semantic labels
- **Color Contrast**: Minimum 4.5:1 contrast ratio for text
- **Touch Targets**: Minimum 44x44 logical pixels
- **Screen Reader Support**: Proper widget semantics
- **Font Scaling**: Support system font size preferences

## Performance Considerations

### Optimization Strategies

1. **Image Optimization**: Use cached network images, compress assets
2. **Lazy Loading**: Load activity lists incrementally
3. **State Management**: Minimize unnecessary rebuilds
4. **Animation Performance**: Use const constructors, avoid expensive operations in build
5. **Local Caching**: Cache API responses for offline access

### Performance Targets

- **App Launch**: < 2 seconds to splash screen
- **Screen Transitions**: 60 FPS animations
- **API Response**: < 500ms for cached data
- **Memory Usage**: < 150MB average

## Security Considerations

### Authentication Security

- Store tokens securely using flutter_secure_storage
- Implement token refresh mechanism
- Clear sensitive data on logout
- Use HTTPS for all API calls

### Data Privacy

- Encrypt local database
- Implement data retention policies
- Provide data export functionality
- Clear cache on user request

## Future Backend Integration

### API Endpoints (FastAPI)

```
POST   /api/auth/register
POST   /api/auth/login
POST   /api/auth/sso/{provider}
GET    /api/users/me
PATCH  /api/users/me
GET    /api/users/me/progress
GET    /api/activities
GET    /api/activities/recommended
GET    /api/activities/{id}
POST   /api/activities/{id}/complete
GET    /api/progress/streaks
GET    /api/progress/badges
GET    /api/progress/history
```

### API Service Implementation

```dart
class ApiService {
  final Dio _dio;
  
  Future<List<Activity>> getRecommendedActivities({
    required EnergyLevel energy,
    required String pillarId,
  }) async {
    final response = await _dio.get(
      '/api/activities/recommended',
      queryParameters: {
        'energy': energy.name,
        'pillar': pillarId,
      },
    );
    return (response.data as List)
        .map((json) => Activity.fromJson(json))
        .toList();
  }
  
  // Additional API methods...
}
```

### Offline-First Strategy

1. **Local Database**: Store activities, user data locally using Hive
2. **Sync Queue**: Queue API calls when offline, sync when online
3. **Conflict Resolution**: Last-write-wins for user preferences
4. **Cache Strategy**: Cache activities for 24 hours, refresh in background

## Deployment Considerations

### Build Configurations

- **Development**: Debug mode, local API endpoints
- **Staging**: Profile mode, staging API endpoints
- **Production**: Release mode, production API endpoints

### Platform-Specific Considerations

**iOS**:
- Configure Info.plist for permissions
- Set up App Store Connect
- Handle safe area insets

**Android**:
- Configure AndroidManifest.xml
- Set up Google Play Console
- Handle different screen densities

### CI/CD Pipeline

1. Run tests on pull requests
2. Build and sign apps for release
3. Deploy to TestFlight/Internal Testing
4. Automated release to stores
