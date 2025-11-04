# Implementation Plan

- [x] 1. Set up Flutter project structure and core configuration





  - Initialize Flutter project with proper package name and organization
  - Configure pubspec.yaml with required dependencies (provider/riverpod, go_router, dio, hive, lottie, flutter_secure_storage)
  - Create directory structure following the design (core/, features/, data/, routes/)
  - Set up platform-specific configurations (AndroidManifest.xml, Info.plist)
  - _Requirements: 1.1, 12.4_

- [x] 2. Implement core theme system and design constants





  - Create AppColors class with all color constants (Calm Blue, Soft Green, etc.)
  - Create AppTypography class with text styles (12-28px scale, Inter font)
  - Create AppDimensions class with spacing, border radius, and sizing constants
  - Implement AppTheme with ThemeData configuration
  - Configure font family (Inter) in pubspec.yaml and assets
  - _Requirements: 12.1, 12.2, 12.3_

- [x] 3. Build reusable core widgets





  - Create CustomButton widget with primary/secondary variants and 12px border radius
  - Create CustomCard widget with 16px border radius and shadow
  - Create AnimatedProgressBar widget with gradient fill animation
  - Create EnergyLevelCard widget with color coding and tap animation
  - Create WellnessPillarCard widget for grid display
  - Create ActivityCard widget for list/grid display with thumbnail support
  - _Requirements: 4.1, 5.1, 6.2, 12.2_

- [x] 4. Implement navigation system with GoRouter





  - Create app_router.dart with all route definitions
  - Configure routes for all 12 screens (splash, welcome, auth, home, pillars, activities, guide, completion, progress, profile, library)
  - Implement route parameters for activity ID and pillar selection
  - Set initial route to splash screen
  - _Requirements: 1.4, 2.4, 4.2, 5.4, 6.4, 7.5_

- [x] 5. Create data models and enums





  - Implement User model with JSON serialization
  - Implement NotificationPreferences model
  - Implement WellnessPillar model
  - Implement Activity model with ActivityStep list
  - Implement UserProgress model with streak and badge data
  - Implement CompletedActivity and Badge models
  - Create enums for EnergyLevel, Difficulty, and SSOProvider
  - _Requirements: 2.1, 3.1, 4.1, 5.1, 6.1, 9.1_

- [x] 6. Implement onboarding screens





- [x] 6.1 Create SplashScreen with logo animation


  - Build full-screen gradient background (Calm Blue → Soft Green)
  - Add centered logo with fade-in animation (0 → 100% opacity, 800ms)
  - Add tagline "Wellness in 1–5 minutes" with proper typography
  - Implement auto-transition to welcome carousel after 2 seconds
  - _Requirements: 1.1, 13.1_

- [x] 6.2 Create WelcomeCarousel with PageView


  - Implement PageView with 3 swipeable slides
  - Create CarouselSlide widget with illustration, header, and body text
  - Add navigation dots indicator with active/inactive states
  - Add "Get Started" button that navigates to signup
  - Implement slide transition animation (300ms)
  - _Requirements: 1.2, 1.3, 1.4, 13.2_
- [x] 7. Implement authentication screens and logic





- [x] 7.1 Create SignUpScreen with form validation


  - Build form with email and password fields
  - Implement email regex validation
  - Implement password length validation (minimum 8 characters)
  - Add "Sign Up" primary button and "Sign In Instead" secondary button
  - Add SSO buttons for Google and Microsoft with icons
  - Style with white card container, 16px rounded corners, and shadow
  - _Requirements: 1.5, 2.1, 2.2, 2.3, 2.5_

- [x] 7.2 Create ProfileSetupScreen


  - Build form with name and company input fields
  - Implement multi-select chips for wellness goals with bounce animation
  - Add notification preferences toggle switches
  - Add "Continue" button that navigates to home screen
  - Implement chip selection animation (scale 0.9 → 1.0)
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 13.4_

- [x] 7.3 Implement AuthProvider for state management


  - Create AuthProvider with sign up, sign in, and SSO methods
  - Implement user session management
  - Handle authentication errors with proper exception types
  - Store authentication tokens securely using flutter_secure_storage
  - Implement auto-navigation after successful authentication
  - _Requirements: 2.3, 2.4, 3.4_

- [x] 8. Implement home screen and energy selection





- [x] 8.1 Create HomeScreen with energy level cards

  - Build personalized greeting header with user name
  - Create three EnergyLevelCard widgets (Low, Medium, High) with distinct colors
  - Implement card tap navigation to wellness pillar screen
  - Add quick stats section (streak, weekly progress, total activities)
  - Implement progress bar animation on screen load
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_

- [x] 8.2 Implement HomeProvider for state management


  - Create HomeState with user name, streak, progress, and selected energy
  - Implement methods to update energy level selection
  - Fetch and manage quick stats data
  - Handle navigation state for passing energy level to next screen
  - _Requirements: 4.2, 4.5_

- [x] 9. Implement wellness pillar selection





- [x] 9.1 Create WellnessPillarScreen with grid layout


  - Build 2-column grid with 6 wellness pillar cards
  - Display icon, name, and description for each pillar
  - Add badge showing available activities count
  - Implement card tap navigation to activity selection screen
  - Pass selected pillar and energy level to next screen
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [x] 9.2 Implement WellnessPillarProvider


  - Create provider to manage pillar data
  - Implement method to get pillar by ID
  - Handle pillar selection state
  - Prepare data for activity filtering
  - _Requirements: 5.4, 5.5_

- [x] 10. Implement activity selection and recommendation





- [x] 10.1 Create ActivitySelectionScreen


  - Build scrollable list of 3-5 activity cards
  - Display thumbnail, name, duration, difficulty, and location icon for each activity
  - Implement color-coded difficulty indicators
  - Add card tap navigation to activity guide screen
  - Filter activities based on energy level and pillar
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_


- [x] 10.2 Implement ActivityProvider

  - Create provider to manage activity data and recommendations
  - Implement getRecommendedActivities method with energy and pillar filters
  - Handle activity selection state
  - Prepare activity data for guide screen
  - _Requirements: 6.5_

- [x] 11. Implement activity guide and completion





- [x] 11.1 Create ActivityGuideScreen with step-by-step instructions


  - Build header with activity name and step progress bar
  - Display illustration/GIF for current step
  - Show instruction text below visual
  - Implement circular timer component for timed activities
  - Add "Next Step" button with step progression logic
  - Navigate to completion screen after final step
  - _Requirements: 7.1, 7.2, 7.3, 7.4, 7.5_

- [x] 11.2 Create CompletionScreen with confetti animation


  - Implement confetti Lottie animation (1000ms duration)
  - Display success message with completed activity name
  - Show updated stats (streak, weekly goal, total points)
  - Add "Do Another Activity" and "Return Home" buttons
  - Implement gradient background (Soft Green → White)
  - _Requirements: 8.1, 8.2, 8.3, 8.4, 13.5_


- [x] 11.3 Implement ActivityGuideProvider

  - Create provider to manage current activity state
  - Implement step progression logic
  - Handle timer state for timed activities
  - Trigger activity completion recording
  - Update user progress after completion
  - _Requirements: 7.5, 8.5_


- [x] 12. Implement progress tracking screens



- [x] 12.1 Create ProgressScreen with tabbed interface


  - Implement TabBar with three tabs (Streaks, History, Badges)
  - Create StreakCalendar widget with calendar grid visualization
  - Highlight completed days on calendar
  - Build HistoryList widget with chronological activity list
  - Create BadgeGrid widget with earned (color) and locked (grayscale) badges
  - _Requirements: 9.1, 9.2, 9.3, 9.4_

- [x] 12.2 Implement badge unlock animation


  - Create pulse animation for badge unlock (scale 0 → 1.2 → 1.0)
  - Trigger animation when new badge is earned
  - Display badge unlock notification
  - _Requirements: 9.5, 13.7_

- [x] 12.3 Implement ProgressProvider


  - Create provider to manage progress data (streaks, history, badges)
  - Implement methods to fetch user progress
  - Handle activity completion recording
  - Update streak calculations
  - Manage badge unlock logic
  - _Requirements: 8.5, 9.1_


- [x] 13. Implement profile and settings screen




- [x] 13.1 Create ProfileScreen with settings options


  - Build profile header with photo, name, and total points
  - Implement notification preferences toggles
  - Add voice guidance toggle
  - Create privacy settings section
  - Implement language selector dropdown
  - Add logout button
  - _Requirements: 10.1, 10.2, 10.3, 10.4_


- [x] 13.2 Implement ProfileProvider

  - Create provider to manage profile data and settings
  - Implement methods to update notification preferences
  - Handle settings changes and save to backend
  - Implement logout functionality
  - _Requirements: 10.5_

- [x] 14. Implement activity library and search




- [x] 14.1 Create ActivityLibraryScreen


  - Build search bar with "Search activities…" placeholder
  - Implement filter dropdown for wellness pillars
  - Create 2-column grid layout for all activities
  - Display preview image, name, and duration for each activity
  - Implement card tap navigation to activity guide
  - _Requirements: 11.1, 11.2, 11.3, 11.4_


- [x] 14.2 Implement search and filter functionality

  - Create search logic to filter activities by name
  - Implement pillar filter functionality
  - Handle real-time search updates
  - Optimize search performance for large activity lists
  - _Requirements: 11.1, 11.2, 11.5_
-

- [x] 15. Implement local data storage with Hive




  - Set up Hive database initialization
  - Create type adapters for User, Activity, and Progress models
  - Implement local caching for activities (24-hour refresh)
  - Create offline queue for activity completions
  - Implement data sync logic for when app comes online
  - _Requirements: 8.5, 9.1_

- [x] 16. Implement repository layer for data access




  - Create AuthRepository implementation with mock data
  - Create UserRepository implementation with local storage
  - Create ActivityRepository implementation with mock activities
  - Create ProgressRepository implementation with local tracking
  - Implement error handling for all repository methods
  - _Requirements: 2.4, 3.4, 6.5, 8.5_

- [x] 17. Implement animation utilities and helpers





  - Create animation constants (durations, curves)
  - Implement slide transition builder (300ms)
  - Implement fade transition builder (250ms)
  - Create bounce animation helper for chips
  - Implement progress bar animation controller
  - _Requirements: 13.1, 13.2, 13.3, 13.4, 13.6_


- [x] 18. Implement responsive design and accessibility




  - Add MediaQuery-based responsive sizing
  - Implement LayoutBuilder for tablet grid adjustments
  - Add semantic labels to all interactive widgets
  - Ensure minimum touch target size (44x44 logical pixels)
  - Test with different font scale settings
  - Verify color contrast ratios (minimum 4.5:1)
  - _Requirements: 12.4, 12.5_
- [x] 19. Add error handling and validation




- [ ] 19. Add error handling and validation

  - Create AppException hierarchy (NetworkException, AuthException, ValidationException)
  - Implement form validators (email, password)
  - Create error UI components (SnackBar, ErrorDialog, InlineError)
  - Add error handling to all API calls and user actions
  - Implement retry logic for network errors
  - _Requirements: 2.1, 2.2_

- [x] 20. Prepare mock data for development





  - Create mock wellness pillar data (6 pillars with icons and descriptions)
  - Create mock activity data (15-20 activities across all pillars)
  - Create mock activity steps with instructions and images
  - Create mock badge data with unlock criteria
  - Implement mock user data for testing
  - _Requirements: 5.1, 6.1, 9.4_
-

- [x] 21. Integrate Lottie animations




  - Add lottie package to pubspec.yaml
  - Download or create confetti animation JSON
  - Integrate confetti animation in CompletionScreen
  - Test animation performance on different devices
  - _Requirements: 8.1, 13.5_
-

- [x] 22. Implement app initialization and routing




  - Create main.dart with app initialization
  - Set up MaterialApp with theme and router
  - Implement splash screen as initial route
  - Configure app-wide error handling
  - Set up provider initialization
  - _Requirements: 1.1, 4.2_

- [ ]* 23. Create integration tests for key user flows
  - Write integration test for onboarding flow (splash → carousel → signup → profile → home)
  - Write integration test for activity completion flow (home → pillar → activity → guide → completion)
  - Write integration test for progress tracking (complete activities → view progress)
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 4.2, 5.4, 6.4, 7.5, 8.4_


- [x] 24. Polish and optimize performance




  - Optimize image loading with cached_network_image
  - Implement const constructors where possible
  - Profile app performance and fix any jank
  - Optimize build methods to minimize rebuilds
  - Test app launch time (target < 2 seconds)
  - Verify 60 FPS animations on target devices
  - _Requirements: 13.1, 13.2_
