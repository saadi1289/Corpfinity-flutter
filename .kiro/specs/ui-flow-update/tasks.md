# Implementation Plan

- [x] 1. Update routing configuration and remove deprecated screens





  - Remove `/welcome` route from app_router.dart
  - Remove `/auth/profile-setup` route from app_router.dart
  - Add `/challenge/create` route for challenge flow screen
  - Update splash screen navigation logic to check auth and go directly to login or home
  - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.5_

- [x] 2. Create new data models and enums for challenge flow





  - Create LocationContext enum with values: home, office, gym, outdoor
  - Create LocationContextHelper class with getLabel() and getIcon() methods
  - Verify EnergyLevel enum exists and is accessible
  - Verify WellnessGoal enum exists or create it if needed
  - _Requirements: 6.1, 7.1, 8.1_

- [x] 3. Implement core selection card widget with icon styling





  - Create SelectionCard widget with label, icon, isSelected, onTap, accentColor parameters
  - Implement unselected state: white background, dark icon outline with white fill, dark text
  - Implement selected state: colored background, white icon outline with colored fill, white text
  - Add scale animation (1.0 → 1.05) on selection with glow effect
  - Use custom icon implementation or flutter_svg for outlined icons with fill
  - Ensure 44x44px minimum touch target
  - _Requirements: 6.3, 6.4, 7.3, 7.4, 8.3, 8.4, 10.3, 11.1_

- [x] 4. Implement hero card widget for home screen





  - Create HeroCard widget with userName, profileImageUrl, progressValue, currentLevel parameters
  - Implement circular avatar (64px) with placeholder for missing images
  - Add gradient background (calmBlue to softGreen)
  - Implement animated progress bar with gradient fill (800ms animation on mount)
  - Add level display text
  - Set card height to 180px with 16px border radius
  - Add elevation 4 shadow
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5_

- [x] 5. Implement supportive section card widget





  - Create SupportiveSectionCard widget with title, content, icon, accentColor parameters
  - Set minimum height to 100px
  - Position icon (32px) on the left
  - Use bodyLarge for title, bodyMedium for content
  - Apply existing CustomCard styling
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_

- [x] 6. Implement create challenge card widget





  - Create CreateChallengeCard widget with onTap callback
  - Set height to 120px
  - Apply warmOrange background with 10% opacity
  - Add 2px solid warmOrange border
  - Create full-width button with warmOrange background and white text
  - Button text: "Create Challenge"
  - _Requirements: 5.1, 5.2, 5.3, 5.4, 5.5_

- [x] 7. Implement challenge display card widget





  - Create ChallengeDisplayCard widget with challengeText parameter
  - Set minimum height to 150px
  - Apply lightGray background with 1px calmBlue border
  - Add 24px padding
  - Use bodyLarge text style, centered
  - Implement fade-in animation (400ms) on display
  - _Requirements: 9.1, 9.2, 9.3_


- [x] 8. Create ChallengeFlowProvider for state management




  - Create ChallengeFlowState class with currentStep, selectedEnergy, selectedLocation, selectedGoal, generatedChallenge fields
  - Implement selectEnergy() method
  - Implement selectLocation() method
  - Implement selectGoal() method
  - Implement generateChallenge() method with static placeholder logic
  - Implement resetFlow() method
  - Implement goToNextStep() and goToPreviousStep() methods
  - Add provider to app.dart MultiProvider
  - _Requirements: 6.5, 7.5, 8.5, 9.4_


- [x] 9. Implement challenge flow screen - energy selection step




  - Create ChallengeFlowScreen as StatefulWidget
  - Implement step 1: Energy level selection
  - Display prompt text "How's your energy today?"
  - Create three SelectionCard widgets for Low, Medium, High energy
  - Use energyLow, energyMedium, energyHigh colors for selected states
  - Implement auto-advance to next step after 300ms delay on selection
  - Add back button in app bar
  - Display "Step 1 of 3" at bottom
  - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [x] 10. Implement challenge flow screen - location selection step




  - Implement step 2: Location selection
  - Display prompt text "Where are you right now?"
  - Create 2x2 grid of SelectionCard widgets for Home, Office, Gym, Outdoor
  - Set card size to 160px x 120px with 12px gap
  - Use 48px icons centered with label below
  - Use calmBlue for selected state
  - Implement auto-advance to next step after 300ms delay on selection
  - Display "Step 2 of 3" at bottom
  - _Requirements: 7.1, 7.2, 7.3, 7.4, 7.5_

- [x] 11. Implement challenge flow screen - goal selection step




  - Implement step 3: Wellness goal selection
  - Display prompt text "What wellness area do you want to focus on?"
  - Create 2x3 grid of SelectionCard widgets for 6 wellness goals
  - Set card size to 160px x 100px
  - Use calmBlue for selected state
  - Show "Generate Challenge" button after selection
  - Display "Step 3 of 3" at bottom
  - _Requirements: 8.1, 8.2, 8.3, 8.4, 8.5_

- [x] 12. Implement challenge display in flow screen




  - Add challenge display section to step 3 after generation
  - Display "Your Challenge" header
  - Show ChallengeDisplayCard with generated text
  - Add "Start Challenge" button below card
  - Add "Generate New" button for regeneration
  - Implement button actions (placeholder navigation for Start Challenge)
  - _Requirements: 9.1, 9.2, 9.3, 9.4, 9.5_
-

- [x] 13. Implement step transitions and animations




  - Add PageView or AnimatedSwitcher for step transitions
  - Implement slide/fade transitions (300ms duration)
  - Use Curves.easeInOut for step transitions
  - Implement selection animation (scale 1.0 → 1.05, 200ms)
  - Add glow effect on card selection using BoxShadow
  - Ensure 60 FPS performance on both iOS and Android
  - _Requirements: 10.1, 10.2, 10.3, 10.4, 10.5_
-

- [x] 14. Update HomeProvider with new fields and methods




  - Add profileImageUrl field (nullable String)
  - Add currentLevel field (int)
  - Add levelProgress field (double, 0.0 to 1.0)
  - Implement fetchUserProfile() method with mock data
  - Implement calculateLevelProgress() method
  - Update existing fetchQuickStats() to include new fields
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5_


- [x] 15. Redesign home screen layout




  - Remove existing energy level cards section
  - Add HeroCard at top of screen
  - Add Daily Progress Summary section using SupportiveSectionCard
  - Add Tip of the Day section using SupportiveSectionCard
  - Add Current Streak section using SupportiveSectionCard
  - Add CreateChallengeCard at bottom before navigation bar
  - Implement navigation to /challenge/create on button tap
  - Maintain existing bottom navigation bar
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 4.1, 4.2, 4.3, 4.4, 4.5, 5.1, 5.2, 5.3, 5.4, 5.5_


- [x] 16. Simplify login screen to frontend-only




  - Update SignInScreen to remove backend API calls
  - Keep email and password input fields with validation
  - Implement simple form validation (email format, password length)
  - On login button tap, navigate directly to /home
  - Add "Don't have an account? Sign Up" link
  - Use existing InputDecorationTheme and CustomButton
  - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5_


- [x] 17. Update splash screen navigation logic



  - Modify SplashScreen to check authentication status after 2 seconds
  - If authenticated, navigate to /home
  - If not authenticated, navigate to /auth/signin
  - Remove navigation to /welcome
  - _Requirements: 1.1, 1.2, 1.3_

- [x] 18. Implement responsive design for all new components





  - Add MediaQuery-based sizing for HeroCard (160px/180px/200px for small/medium/large)
  - Adjust avatar size based on screen size (56px/64px/72px)
  - Make challenge flow cards scrollable on small screens (< 375px)
  - Ensure 2-column grid adapts to single column on very small screens
  - Test on iPhone SE (320px) and larger devices
  - Verify minimum touch targets (44x44px) on all interactive elements
  - _Requirements: 12.1, 12.2, 12.3, 12.4, 12.5_

- [x] 19. Add accessibility support




  - Add semantic labels to HeroCard with user info and progress
  - Add semantic labels to SelectionCard with selection state
  - Add semantic labels to ChallengeDisplayCard
  - Mark all interactive elements as buttons in semantics
  - Ensure color contrast ratios meet 4.5:1 minimum
  - Test with screen reader on both iOS and Android
  - _Requirements: 11.1, 11.2, 11.3, 11.4, 11.5_

- [x] 20. Create mock data for home screen sections





  - Create HomeScreenData class with profile, dailyProgress, tipOfTheDay, currentStreak fields
  - Implement getMockData() static method
  - Create UserProfile model with name, imageUrl, level, levelProgress
  - Create DailyProgress model with completedActivities, goalActivities
  - Generate sample tips of the day (5-10 variations)
  - _Requirements: 3.1, 4.1, 4.2, 4.3, 4.4_

- [x] 21. Implement challenge generation logic





  - Create ChallengeGenerator class with generateChallenge() method
  - Implement static placeholder logic based on energy, location, and goal
  - Create 10-15 placeholder challenge variations
  - Return contextual challenges based on input combination
  - Add comments for future AI integration
  - _Requirements: 9.1, 9.4_


- [x] 22. Test cross-platform compatibility




  - Test all screens on iOS simulator (iPhone SE, iPhone 14)
  - Test all screens on Android emulator (Pixel 5)
  - Verify icon rendering on both platforms
  - Test animations and transitions on both platforms
  - Verify safe area handling (notches, punch-holes)
  - Test back navigation (Android back button, iOS swipe gesture)
  - Verify touch interactions and ripple effects
  - _Requirements: 10.1, 10.2, 10.3, 10.4, 10.5, 11.1, 11.2, 11.3, 11.4, 11.5, 12.1, 12.2, 12.3, 12.4, 12.5_


- [x] 23. Polish and optimize performance




  - Profile app performance on both iOS and Android
  - Optimize animation frame rates (target 60 FPS)
  - Use const constructors where possible
  - Implement cached_network_image for profile images
  - Test hero card progress bar animation smoothness
  - Test challenge flow step transitions smoothness
  - Verify home screen load time (< 500ms target)
  - _Requirements: 10.1, 10.2, 10.3, 10.4, 10.5_
