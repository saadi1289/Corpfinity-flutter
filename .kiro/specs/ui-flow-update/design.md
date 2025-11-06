# Design Document

## Overview

This design document outlines the UI flow updates for the Corpfinity Employee App. The changes streamline the user experience by removing unnecessary onboarding steps, redesigning the home screen with a hero card layout, and introducing a multi-step challenge creation flow. The design maintains the existing theme system, color palette, and component styles while reorganizing the navigation flow and screen layouts.

### Key Changes

1. **Simplified Entry Flow**: Remove welcome carousel and profile setup screens
2. **Hero Card Home Screen**: Redesigned home layout with prominent user profile card
3. **Challenge Creation Flow**: New multi-step wizard for generating personalized challenges
4. **Preserved Theme**: Maintain existing colors, typography, and component shapes

### Technology Stack

The implementation will use the existing Flutter architecture:
- **Framework**: Flutter 3.x
- **State Management**: Provider (existing)
- **Navigation**: GoRouter (existing)
- **Animations**: Flutter built-in animations
- **Theme**: Existing AppTheme system
- **Platform Support**: iOS and Android (cross-platform compatibility ensured)

## Architecture

### Updated Navigation Flow

```
Splash Screen
     ↓
[Not Authenticated] → Login Screen → Home Screen
     ↓
[Authenticated] → Home Screen
     ↓
Create Challenge Button → Challenge Creation Flow
     ↓
Energy Selection → Location Selection → Goal Selection → Challenge Display
```

### Removed Screens

- Welcome Carousel (`/welcome`)
- Profile Setup Screen (`/auth/profile-setup`)

### New Screens

- Challenge Creation Flow Screen (`/challenge/create`)

### Modified Screens

- Home Screen: Complete layout redesign with hero card
- Login Screen: Simplified to frontend-only authentication

## Components and Interfaces

### 1. Updated Home Screen Components

#### Hero Card Widget

```dart
class HeroCard extends StatelessWidget {
  final String userName;
  final String? profileImageUrl;
  final double progressValue; // 0.0 to 1.0
  final int currentLevel;
  
  // Displays user profile with circular avatar, name, and progress bar
  // Uses existing AppColors and AppDimensions
  // Animated progress bar on mount
}
```

#### Supportive Section Card Widget

```dart
class SupportiveSectionCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color accentColor;
  
  // Reusable card for daily progress, tips, streaks
  // Uses existing CustomCard styling
}
```

#### Create Challenge Card Widget

```dart
class CreateChallengeCard extends StatelessWidget {
  final VoidCallback onTap;
  
  // Prominent card with large button
  // Styled to stand out from other sections
  // Uses warmOrange accent color
}
```

### 2. Challenge Creation Flow Components

#### Challenge Flow Container

```dart
class ChallengeFlowScreen extends StatefulWidget {
  // Manages multi-step flow state
  // Handles step transitions with animations
  // Tracks user selections across steps
}

class ChallengeFlowState {
  int currentStep; // 0: energy, 1: location, 2: goal
  EnergyLevel? selectedEnergy;
  LocationContext? selectedLocation;
  WellnessGoal? selectedGoal;
  String? generatedChallenge;
}
```

#### Selection Card Widget

```dart
class SelectionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? accentColor;
  
  // Reusable card for energy, location, and goal selection
  // Animated scale and glow on selection
  // Uses existing card styling with selection state
  // When selected: colored background with white outlined icon
  // When unselected: white/light background with dark outlined icon
}
```

#### Challenge Display Card

```dart
class ChallengeDisplayCard extends StatelessWidget {
  final String challengeText;
  
  // Displays generated challenge in rounded card
  // Uses existing CustomCard with enhanced padding
}
```

### 3. New Data Models

```dart
enum LocationContext {
  home,
  office,
  gym,
  outdoor,
}

class LocationContextHelper {
  static String getLabel(LocationContext location);
  static IconData getIcon(LocationContext location);
}

// Note: EnergyLevel and WellnessGoal enums already exist
// Will reuse existing enums from the codebase
```

### 4. State Management

#### Updated HomeProvider

```dart
class HomeProvider extends ChangeNotifier {
  // Existing fields
  String userName;
  int currentStreak;
  double weeklyProgress;
  int totalActivities;
  
  // New fields for hero card
  String? profileImageUrl;
  int currentLevel;
  double levelProgress;
  
  // New methods
  void fetchUserProfile();
  void calculateLevelProgress();
}
```

#### New ChallengeFlowProvider

```dart
class ChallengeFlowProvider extends ChangeNotifier {
  ChallengeFlowState _state;
  
  void selectEnergy(EnergyLevel energy);
  void selectLocation(LocationContext location);
  void selectGoal(WellnessGoal goal);
  void generateChallenge();
  void resetFlow();
  void goToNextStep();
  void goToPreviousStep();
}
```

## Screen Designs

### 1. Updated Splash Screen

**Behavior Changes**:
- After 2-second display, check authentication status
- If authenticated → navigate to `/home`
- If not authenticated → navigate to `/auth/signin`
- No longer navigates to welcome carousel

**Implementation**: Modify existing SplashScreen navigation logic

### 2. Simplified Login Screen

**Layout**:
```
┌─────────────────────────────────┐
│                                 │
│         [App Logo]              │
│                                 │
│    Welcome to Corpfinity        │
│                                 │
│  ┌───────────────────────────┐  │
│  │ Email                     │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │ Password                  │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │      Login Button         │  │
│  └───────────────────────────┘  │
│                                 │
│      Don't have an account?     │
│         Sign Up                 │
│                                 │
└─────────────────────────────────┘
```

**Features**:
- Frontend-only validation
- No backend API calls
- Simple navigation to home on button tap
- Uses existing InputDecorationTheme
- Uses existing CustomButton styling

### 3. Redesigned Home Screen

**Layout**:
```
┌─────────────────────────────────┐
│  ┌───────────────────────────┐  │
│  │      Hero Card            │  │
│  │  ┌─┐                      │  │
│  │  │●│  John Doe            │  │
│  │  └─┘                      │  │
│  │  Level 5                  │  │
│  │  ▓▓▓▓▓▓▓▓░░░░ 65%         │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │  Daily Progress Summary   │  │
│  │  3 activities completed   │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │  Tip of the Day           │  │
│  │  Take a 5-min walk break  │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │  Current Streak: 7 days   │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │   Create Challenge        │  │
│  │  ┌─────────────────────┐  │  │
│  │  │  Create Challenge   │  │  │
│  │  └─────────────────────┘  │  │
│  └───────────────────────────┘  │
│                                 │
│  [Bottom Navigation Bar]        │
└─────────────────────────────────┘
```

**Hero Card Specifications**:
- Height: 180px
- Border radius: 16px (AppDimensions.cardBorderRadius)
- Background: Gradient from calmBlue to softGreen
- Profile image: 64px circular avatar
- Progress bar: Animated gradient fill
- Shadow: elevation 4

**Supportive Sections**:
- Each card: 100px height minimum
- Spacing between cards: 16px
- Icons: 32px size, positioned left
- Text: bodyLarge for title, bodyMedium for content

**Create Challenge Card**:
- Height: 120px
- Background: warmOrange with 10% opacity
- Border: 2px solid warmOrange
- Button: Full width, warmOrange background
- Button text: "Create Challenge" in white

### 4. Challenge Creation Flow Screen

**Step 1: Energy Level Selection**

```
┌─────────────────────────────────┐
│  ← Back                         │
│                                 │
│  How's your energy today?       │
│                                 │
│  ┌───────────────────────────┐  │
│  │  🔴  Low Energy           │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │  🟡  Medium Energy        │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │  🟢  High Energy          │  │
│  └───────────────────────────┘  │
│                                 │
│                                 │
│  Step 1 of 3                    │
└─────────────────────────────────┘
```

**Card Specifications**:
- Height: 80px per card
- Spacing: 16px between cards
- Icon size: 40px (custom outlined style with fill)
- Unselected state:
  - Card background: white
  - Icon outline: dark, Icon fill: white
  - Text: dark
- Selected state:
  - Card background: filled with energy color (energyLow/Medium/High)
  - Icon outline: white, Icon fill: energy color (matches card)
  - Text: white
- Selection animation: scale 1.0 → 1.05 with glow
- Auto-advance on selection after 300ms

**Step 2: Location Selection**

```
┌─────────────────────────────────┐
│  ← Back                         │
│                                 │
│  Where are you right now?       │
│                                 │
│  ┌─────────────┬─────────────┐  │
│  │  🏠 Home    │  🏢 Office  │  │
│  └─────────────┴─────────────┘  │
│                                 │
│  ┌─────────────┬─────────────┐  │
│  │  💪 Gym     │  🌳 Outdoor │  │
│  └─────────────┴─────────────┘  │
│                                 │
│                                 │
│  Step 2 of 3                    │
└─────────────────────────────────┘
```

**Grid Specifications**:
- 2 columns
- Card size: 160px x 120px
- Spacing: 12px gap
- Icon size: 48px centered (custom outlined style with fill)
- Unselected state:
  - Card background: white
  - Icon outline: dark, Icon fill: white
  - Label: bodyLarge, darkText color
- Selected state:
  - Card background: filled with calmBlue
  - Icon outline: white, Icon fill: calmBlue (matches card)
  - Label: bodyLarge, white color
- Label: centered below icon

**Step 3: Wellness Goal Selection**

```
┌─────────────────────────────────┐
│  ← Back                         │
│                                 │
│  What wellness area do you      │
│  want to focus on?              │
│                                 │
│  ┌─────────────┬─────────────┐  │
│  │  Stress     │  Increased  │  │
│  │  Reduction  │  Energy     │  │
│  └─────────────┴─────────────┘  │
│                                 │
│  ┌─────────────┬─────────────┐  │
│  │  Better     │  Physical   │  │
│  │  Sleep      │  Fitness    │  │
│  └─────────────┴─────────────┘  │
│                                 │
│  ┌─────────────┬─────────────┐  │
│  │  Healthy    │  Social     │  │
│  │  Eating     │  Connection │  │
│  └─────────────┴─────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │  Generate Challenge       │  │
│  └───────────────────────────┘  │
│                                 │
│  Step 3 of 3                    │
└─────────────────────────────────┘
```

**Grid Specifications**:
- 2 columns, 3 rows
- Card size: 160px x 100px
- Icon + text layout (custom outlined icons with fill)
- Unselected state:
  - Card background: white
  - Icon outline: dark, Icon fill: white
  - Text: dark
- Selected state:
  - Card background: filled with calmBlue
  - Icon outline: white, Icon fill: calmBlue (matches card)
  - Text: white
- Selection: scale animation + border highlight
- Generate button appears after selection

**Challenge Display (Same Screen)**

```
┌─────────────────────────────────┐
│  ← Back                         │
│                                 │
│  Your Challenge                 │
│                                 │
│  ┌───────────────────────────┐  │
│  │                           │  │
│  │  Challenge Suggestion:    │  │
│  │                           │  │
│  │  15 minutes mindful       │  │
│  │  stretching + hydration   │  │
│  │  reminder                 │  │
│  │                           │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │   Start Challenge         │  │
│  └───────────────────────────┘  │
│                                 │
│  ┌───────────────────────────┐  │
│  │   Generate New            │  │
│  └───────────────────────────┘  │
│                                 │
└─────────────────────────────────┘
```

**Challenge Card Specifications**:
- Min height: 150px
- Background: lightGray
- Border: 1px calmBlue
- Padding: 24px
- Text: bodyLarge, centered
- Fade-in animation on display

## Animation Specifications

### Transition Animations

```dart
class ChallengeFlowAnimations {
  // Step transitions
  static const Duration stepTransition = Duration(milliseconds: 300);
  static const Curve stepCurve = Curves.easeInOut;
  
  // Card selection
  static const Duration selectionAnimation = Duration(milliseconds: 200);
  static const Curve selectionCurve = Curves.easeOut;
  
  // Challenge display
  static const Duration challengeFadeIn = Duration(milliseconds: 400);
  static const Curve challengeCurve = Curves.easeIn;
  
  // Progress bar animation
  static const Duration progressAnimation = Duration(milliseconds: 800);
  static const Curve progressCurve = Curves.easeInOut;
}
```

### Specific Animations

1. **Hero Card Progress Bar**: Animated from 0 to current value on mount (800ms)
2. **Step Transitions**: Slide left/right with fade (300ms)
3. **Card Selection**: Scale 1.0 → 1.05 + glow effect (200ms)
4. **Challenge Display**: Fade in from 0 to 1 opacity (400ms)
5. **Auto-advance**: Delay 300ms after selection before transition

### Selection Visual Feedback

```dart
// Unselected card styling
BoxDecoration unselectedDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(16),
  color: AppColors.white,
  border: Border.all(color: AppColors.neutralGray, width: 1),
);

// Selected card styling - card fills with color
BoxDecoration selectedDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: AppColors.calmBlue, width: 3),
  color: AppColors.calmBlue, // Card background fills with selection color
  boxShadow: [
    BoxShadow(
      color: AppColors.calmBlue.withOpacity(0.3),
      blurRadius: 12,
      spreadRadius: 2,
    ),
  ],
);

// Icon implementation for selection states
// Icons should be custom SVG or composed widgets with:
// - Colored outline stroke
// - White fill inside
// 
// For unselected state:
// - Icon outline: AppColors.darkText
// - Icon fill: AppColors.white
// - Card background: AppColors.white
//
// For selected state:
// - Icon outline: AppColors.white (or accent color)
// - Icon fill: AppColors.calmBlue (matches card background)
// - Card background: AppColors.calmBlue (filled)
// - Text color: AppColors.white
//
// This creates a cohesive look where the entire card and icon
// fill with the selection color, with white outlines for contrast
```

## Data Flow

### Challenge Generation Logic

```dart
class ChallengeGenerator {
  static String generateChallenge({
    required EnergyLevel energy,
    required LocationContext location,
    required WellnessGoal goal,
  }) {
    // Static placeholder for now
    // Future: AI-powered generation
    return _getPlaceholderChallenge(energy, location, goal);
  }
  
  static String _getPlaceholderChallenge(
    EnergyLevel energy,
    LocationContext location,
    WellnessGoal goal,
  ) {
    // Return contextual placeholder based on inputs
    // Example: "15 minutes mindful stretching + hydration reminder"
  }
}
```

### Home Screen Data Structure

```dart
class HomeScreenData {
  final UserProfile profile;
  final DailyProgress dailyProgress;
  final String tipOfTheDay;
  final int currentStreak;
  
  // Mock data for development
  static HomeScreenData getMockData() {
    return HomeScreenData(
      profile: UserProfile(
        name: 'John Doe',
        imageUrl: null,
        level: 5,
        levelProgress: 0.65,
      ),
      dailyProgress: DailyProgress(
        completedActivities: 3,
        goalActivities: 5,
      ),
      tipOfTheDay: 'Take a 5-minute walk break every hour',
      currentStreak: 7,
    );
  }
}
```

## Routing Updates

### Updated Router Configuration

```dart
// Remove these routes:
// - /welcome
// - /auth/profile-setup

// Add new route:
GoRoute(
  path: '/challenge/create',
  name: 'challenge-create',
  builder: (context, state) => const ChallengeFlowScreen(),
),

// Update splash screen navigation logic
// Update home screen to include create challenge card
```

### Navigation Flow Changes

**Before**:
```
Splash → Welcome → SignUp → ProfileSetup → Home
```

**After**:
```
Splash → SignIn → Home
         ↓
    ChallengeFlow
```

## Responsive Design Considerations

### Breakpoints

- **Small (320-375px)**: Single column layout, stacked cards
- **Medium (376-414px)**: Standard layout as designed
- **Large (415px+)**: Increased padding, larger cards

### Adaptive Layouts

**Hero Card**:
- Small: Height 160px, smaller avatar (56px)
- Medium: Height 180px, standard avatar (64px)
- Large: Height 200px, larger avatar (72px)

**Challenge Flow Cards**:
- Small: Full width cards, vertical scroll
- Medium: 2-column grid as designed
- Large: 2-column grid with increased spacing

**Touch Targets**:
- Minimum: 44x44 logical pixels
- Recommended: 48x48 logical pixels
- Spacing between targets: minimum 8px

## Error Handling

### Login Screen Errors

```dart
class LoginError {
  static const String emptyEmail = 'Please enter your email';
  static const String invalidEmail = 'Please enter a valid email';
  static const String emptyPassword = 'Please enter your password';
  static const String shortPassword = 'Password must be at least 8 characters';
}
```

### Challenge Flow Errors

```dart
class ChallengeFlowError {
  static const String noSelection = 'Please make a selection to continue';
  static const String generationFailed = 'Unable to generate challenge. Please try again.';
}
```

### Error Display

- Use SnackBar for temporary errors
- Use inline error text for form validation
- Maintain error state in providers

## Testing Strategy

### Widget Tests

**Hero Card Widget**:
- Test profile image display (with and without image)
- Test progress bar animation
- Test level display
- Test responsive sizing

**Selection Card Widget**:
- Test selection state visual changes
- Test tap interaction
- Test animation triggers
- Test accessibility labels

**Challenge Flow Screen**:
- Test step progression
- Test back navigation
- Test selection persistence
- Test challenge generation
- Test button states

### Integration Tests

**Simplified Login Flow**:
- Test splash → login navigation
- Test login form validation
- Test successful login → home navigation

**Home Screen Flow**:
- Test hero card data display
- Test supportive sections rendering
- Test create challenge button navigation

**Challenge Creation Flow**:
- Test complete flow: energy → location → goal → challenge
- Test back navigation between steps
- Test selection persistence
- Test challenge display
- Test start challenge action

### Performance Tests

- Hero card animation: 60 FPS target
- Step transitions: < 300ms
- Challenge generation: < 100ms (static)
- Home screen load: < 500ms

## Accessibility

### Semantic Labels

```dart
// Hero card
Semantics(
  label: 'User profile card. ${userName}, Level ${level}, ${progressPercent}% progress',
  child: HeroCard(...),
)

// Selection cards
Semantics(
  label: '${label} option. ${isSelected ? "Selected" : "Not selected"}',
  button: true,
  child: SelectionCard(...),
)

// Challenge display
Semantics(
  label: 'Generated challenge: ${challengeText}',
  child: ChallengeDisplayCard(...),
)
```

### Color Contrast

- All text: minimum 4.5:1 contrast ratio
- Selected cards: 3:1 contrast for borders
- Icons: paired with text labels

### Touch Targets

- All interactive elements: minimum 44x44px
- Spacing between targets: minimum 8px
- Increased padding for small screens

## Performance Optimization

### Image Loading

```dart
// Profile images with caching
CachedNetworkImage(
  imageUrl: profileImageUrl,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.person),
  fadeInDuration: Duration(milliseconds: 200),
)
```

### Animation Performance

- Use const constructors where possible
- Avoid rebuilding entire widget tree
- Use AnimatedBuilder for complex animations
- Dispose animation controllers properly

### State Management

- Minimize provider rebuilds
- Use Consumer widgets selectively
- Cache computed values
- Dispose providers when not needed

## Implementation Notes

### Preserving Existing Theme

All new components must use:
- `AppColors` for color values
- `AppTypography` for text styles
- `AppDimensions` for spacing and sizing
- Existing `CustomButton` and `CustomCard` where applicable

### Code Reuse

**Reusable from existing codebase**:
- `EnergyLevel` enum (already exists)
- `WellnessGoal` enum (from wellness pillar models)
- `CustomButton` widget
- `CustomCard` widget
- `AppTheme` configuration
- Navigation utilities

**New components to create**:
- `HeroCard` widget
- `SupportiveSectionCard` widget
- `CreateChallengeCard` widget
- `SelectionCard` widget
- `ChallengeDisplayCard` widget
- `ChallengeFlowScreen` and provider
- `LocationContext` enum

### Migration Strategy

1. **Phase 1**: Update routing (remove old routes, add new)
2. **Phase 2**: Implement new widgets (hero card, selection cards)
3. **Phase 3**: Redesign home screen layout
4. **Phase 4**: Implement challenge flow screen
5. **Phase 5**: Update splash screen navigation logic
6. **Phase 6**: Simplify login screen (remove backend calls)
7. **Phase 7**: Testing and polish

### Backward Compatibility

- Keep existing bottom navigation structure
- Maintain existing progress tracking
- Preserve activity library and profile screens
- Keep existing data models intact

### Future Enhancements

**AI Challenge Generation** (not in this spec):
- Replace static placeholder with API call
- Add loading state during generation
- Handle generation errors gracefully

**Profile Image Upload** (not in this spec):
- Add camera/gallery picker
- Implement image upload to backend
- Add image cropping functionality

**Onboarding Tutorial** (not in this spec):
- Add optional first-time user tutorial
- Highlight key features on home screen
- Show challenge flow walkthrough

## Platform Compatibility

### iOS and Android Support

All components and features are designed to work seamlessly on both iOS and Android:

**Platform-Agnostic Design**:
- Use Flutter's Material Design widgets (compatible with both platforms)
- Avoid platform-specific UI patterns
- Test on both iOS and Android devices/simulators

**Icon Implementation**:
- Use Flutter's Icon widget with custom IconData
- Alternatively, use flutter_svg for custom SVG icons (works on both platforms)
- Ensure icon assets are included in pubspec.yaml for both platforms

**Animations**:
- Use Flutter's built-in animation framework (platform-independent)
- Test animation performance on both iOS and Android
- Ensure 60 FPS on both platforms

**Navigation**:
- GoRouter handles navigation consistently across platforms
- Back button behavior: Android hardware back button + iOS swipe gesture

**Safe Areas**:
- Use SafeArea widget to handle notches and system UI on both platforms
- Test on devices with different screen configurations (iPhone notch, Android punch-hole)

**Touch Interactions**:
- Minimum touch target: 44x44px (iOS guideline, also good for Android)
- Ripple effects work on both platforms via Material widgets

**Testing Requirements**:
- Test on iOS simulator (iPhone SE, iPhone 14)
- Test on Android emulator (Pixel 5, Samsung Galaxy)
- Verify visual consistency across platforms
- Test gesture interactions on both platforms

## Summary

This design maintains the existing visual language and architecture while streamlining the user experience. The key changes focus on:

1. Removing friction from the entry flow
2. Making user progress more prominent
3. Introducing a guided challenge creation experience
4. Preserving all existing functionality and theme consistency
5. Ensuring cross-platform compatibility for iOS and Android

The implementation will reuse existing components and patterns wherever possible, minimizing code duplication and maintaining consistency with the established codebase. All features will work seamlessly on both iOS and Android platforms.
