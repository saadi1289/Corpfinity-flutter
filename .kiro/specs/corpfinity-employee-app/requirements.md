# Requirements Document

## Introduction

The Corpfinity Employee App is a mobile wellness application designed to help employees engage in quick wellness activities (1-5 minutes) during their workday. The app provides personalized activity recommendations based on energy levels and wellness goals, tracks progress through streaks and badges, and offers a comprehensive library of wellness activities across six pillars: Stress Reduction, Increased Energy, Better Sleep, Physical Fitness, Healthy Eating, and Social Connection.

## Glossary

- **System**: The Corpfinity Employee Mobile Application
- **User**: An employee who has registered and uses the app
- **Activity**: A guided wellness exercise or task that takes 1-5 minutes to complete
- **Wellness Pillar**: One of six categories of wellness activities (Stress Reduction, Increased Energy, Better Sleep, Physical Fitness, Healthy Eating, Social Connection)
- **Energy Level**: User's current state categorized as Low, Medium, or High
- **Streak**: Consecutive days of completing at least one activity
- **Badge**: Achievement award earned by completing specific milestones
- **SSO**: Single Sign-On authentication method
- **Profile**: User account information including name, company, and wellness preferences

## Requirements

### Requirement 1: User Onboarding

**User Story:** As a new user, I want to understand the app's value proposition and create an account, so that I can start using wellness activities.

#### Acceptance Criteria

1. WHEN the System launches for the first time, THE System SHALL display a splash screen with the Corpfinity logo and tagline for 2 seconds
2. WHEN the splash screen completes, THE System SHALL transition to a welcome carousel with three educational slides
3. THE System SHALL allow users to swipe horizontally between carousel slides with visual navigation dots
4. WHEN a user completes the carousel, THE System SHALL provide a "Get Started" button that navigates to account creation
5. THE System SHALL display an account creation form with email and password fields

### Requirement 2: User Authentication

**User Story:** As a user, I want to create an account using email/password or SSO, so that I can securely access the app.

#### Acceptance Criteria

1. THE System SHALL validate email addresses using standard email format regex patterns
2. THE System SHALL require passwords to be at least 8 characters in length
3. THE System SHALL provide SSO authentication options for Google and Microsoft accounts
4. WHEN a user successfully registers, THE System SHALL navigate to the profile setup screen
5. THE System SHALL provide a "Sign In Instead" option for users with existing accounts

### Requirement 3: Profile Configuration

**User Story:** As a new user, I want to set up my profile with personal information and wellness goals, so that the app can provide personalized recommendations.

#### Acceptance Criteria

1. THE System SHALL collect user name and company information during profile setup
2. THE System SHALL provide multi-select chips for users to choose wellness goals
3. THE System SHALL allow users to configure notification preferences via toggle switches
4. WHEN a user completes profile setup, THE System SHALL save preferences and navigate to the home screen
5. WHERE SSO authentication is used, THE System SHALL auto-fill company information when available

### Requirement 4: Energy Level Selection

**User Story:** As a user, I want to indicate my current energy level, so that I receive appropriate activity recommendations.

#### Acceptance Criteria

1. THE System SHALL display three energy level options: Low, Medium, and High with distinct visual indicators
2. WHEN a user selects an energy level, THE System SHALL navigate to the wellness pillar selection screen
3. THE System SHALL display the user's name in a personalized greeting on the home screen
4. THE System SHALL show quick stats including streak count, weekly goal progress, and total activities completed
5. THE System SHALL animate the progress bar to the current value when the home screen loads

### Requirement 5: Wellness Pillar Navigation

**User Story:** As a user, I want to choose a wellness focus area, so that I can find relevant activities for my needs.

#### Acceptance Criteria

1. THE System SHALL display six wellness pillars in a 2-column grid layout
2. THE System SHALL show an icon, name, and description for each wellness pillar
3. THE System SHALL display a badge indicating the number of available activities for each pillar
4. WHEN a user taps a wellness pillar card, THE System SHALL navigate to the activity selection screen for that pillar
5. THE System SHALL filter activities based on the previously selected energy level

### Requirement 6: Activity Recommendation and Selection

**User Story:** As a user, I want to see recommended activities based on my energy level and chosen wellness pillar, so that I can select an appropriate activity.

#### Acceptance Criteria

1. THE System SHALL display 3 to 5 recommended activity cards per wellness pillar
2. THE System SHALL show a thumbnail, activity name, duration, difficulty level, and location icon for each activity
3. THE System SHALL color-code difficulty indicators based on the activity's complexity
4. WHEN a user taps an activity card, THE System SHALL navigate to the activity guide screen
5. THE System SHALL retrieve activity recommendations from the backend based on energy level and pillar

### Requirement 7: Activity Guidance

**User Story:** As a user, I want step-by-step instructions for completing an activity, so that I can perform it correctly.

#### Acceptance Criteria

1. THE System SHALL display the activity name and a step progress bar at the top of the guide screen
2. THE System SHALL show an illustration or GIF for each activity step
3. THE System SHALL provide clear instruction text below each visual element
4. WHERE an activity includes timed tasks, THE System SHALL display a circular timer component
5. WHEN a user completes all steps, THE System SHALL navigate to the completion screen

### Requirement 8: Activity Completion and Feedback

**User Story:** As a user, I want to see confirmation when I complete an activity, so that I feel accomplished and motivated.

#### Acceptance Criteria

1. WHEN a user completes an activity, THE System SHALL display a confetti animation
2. THE System SHALL show a success message with the completed activity name
3. THE System SHALL display updated stats including streak count, weekly goal progress, and total points
4. THE System SHALL provide options to "Do Another Activity" or "Return Home"
5. THE System SHALL record the activity completion in the user's progress history

### Requirement 9: Progress Tracking

**User Story:** As a user, I want to track my activity history and streaks, so that I can monitor my wellness journey.

#### Acceptance Criteria

1. THE System SHALL provide three tabs for viewing progress: Streaks, History, and Badges
2. THE System SHALL display a calendar visualization highlighting days with completed activities
3. THE System SHALL show a chronological list of all completed activities in the History tab
4. THE System SHALL display earned badges in color and locked badges in grayscale
5. WHEN a user earns a new badge, THE System SHALL animate the badge unlock with a pulse effect

### Requirement 10: Profile and Settings Management

**User Story:** As a user, I want to manage my profile and app preferences, so that I can customize my experience.

#### Acceptance Criteria

1. THE System SHALL display user profile information including photo, name, and total points
2. THE System SHALL allow users to modify notification preferences via toggle switches
3. THE System SHALL provide options for voice guidance, privacy settings, and language selection
4. THE System SHALL allow users to log out of their account
5. THE System SHALL save all settings changes to the backend when modified

### Requirement 11: Activity Library Exploration

**User Story:** As a user, I want to browse and search all available activities, so that I can discover new wellness exercises.

#### Acceptance Criteria

1. THE System SHALL provide a search bar with placeholder text "Search activities…"
2. THE System SHALL allow users to filter activities by wellness pillar using a dropdown
3. THE System SHALL display all activities in a 2-column grid layout with preview images
4. WHEN a user taps an activity in the library, THE System SHALL navigate to the activity guide screen
5. THE System SHALL show activity name and duration for each item in the library

### Requirement 12: Visual Consistency and Responsiveness

**User Story:** As a user, I want a consistent and responsive interface across different devices, so that I have a seamless experience.

#### Acceptance Criteria

1. THE System SHALL use the defined color palette (Calm Blue, Soft Green, Warm Orange, Gentle Red, Neutral Gray) consistently across all screens
2. THE System SHALL apply rounded corners of 12-16px to all buttons and cards
3. THE System SHALL use Inter font family (or platform equivalents) with sizes ranging from 12px to 28px
4. THE System SHALL support minimum screen width of 320px (iPhone SE)
5. THE System SHALL scale fonts and padding proportionally for different screen sizes

### Requirement 13: Animation and Transitions

**User Story:** As a user, I want smooth animations and transitions, so that the app feels polished and responsive.

#### Acceptance Criteria

1. THE System SHALL use slide transitions of 300ms duration for screen navigation
2. THE System SHALL use fade transitions of 250ms duration for element visibility changes
3. THE System SHALL animate progress bars with gradient fills when displaying progress
4. WHEN a user selects a wellness goal chip, THE System SHALL animate the chip with a bounce effect (scale 0.9 to 1.0)
5. THE System SHALL play a confetti animation for 1000ms when an activity is completed
