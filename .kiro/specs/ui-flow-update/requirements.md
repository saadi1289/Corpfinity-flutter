# Requirements Document

## Introduction

This specification defines UI flow updates for the Corpfinity Employee App. The changes streamline the onboarding process by removing the profile setup screen, redesign the home screen with a hero card layout, and introduce a new multi-step challenge creation flow with contextual inputs (energy level, location, wellness goal) that generates personalized wellness challenges.

## Glossary

- **System**: The Corpfinity Employee Mobile Application
- **User**: An employee who uses the app
- **Hero Card**: A prominent card component at the top of the home screen displaying user information and progress
- **Challenge**: A personalized wellness activity recommendation generated based on user context
- **Energy Level**: User's current energy state (Low, Medium, High)
- **Location Context**: User's current physical location (Home, Office, Gym, Outdoor)
- **Wellness Goal**: The wellness focus area selected by the user (Stress Reduction, Increased Energy, Better Sleep, Physical Fitness, Healthy Eating, Social Connection)
- **Challenge Creation Flow**: A multi-step guided process for generating personalized challenges

## Requirements

### Requirement 1: Simplified App Entry Flow

**User Story:** As a user, I want to quickly access the app without lengthy onboarding, so that I can start using wellness features immediately.

#### Acceptance Criteria

1. WHEN THE System launches, THE System SHALL display the splash screen with logo and branding
2. WHEN the splash screen completes, THE System SHALL navigate directly to the login screen IF the user is not authenticated
3. WHEN the splash screen completes, THE System SHALL navigate directly to the home screen IF the user is authenticated
4. THE System SHALL NOT display the welcome carousel screen during app launch
5. THE System SHALL NOT display the profile setup screen after authentication

### Requirement 2: Login Screen Interface

**User Story:** As a user, I want a simple login interface, so that I can authenticate quickly without backend complexity.

#### Acceptance Criteria

1. THE System SHALL display an email input field with appropriate keyboard type
2. THE System SHALL display a password input field with secure text entry
3. THE System SHALL display a login button that accepts user credentials
4. THE System SHALL provide visual feedback WHEN the login button is tapped
5. THE System SHALL navigate to the home screen WHEN login is successful

### Requirement 3: Hero Card Home Screen Layout

**User Story:** As a user, I want to see my profile and progress prominently on the home screen, so that I feel motivated and informed about my wellness journey.

#### Acceptance Criteria

1. THE System SHALL display a hero card at the top of the home screen containing user information
2. THE System SHALL display the user profile image as a circular avatar within the hero card
3. THE System SHALL display the user name within the hero card
4. THE System SHALL display a progress indicator or level progress bar within the hero card
5. THE System SHALL animate the progress bar fill WHEN the home screen loads

### Requirement 4: Home Screen Supportive Sections

**User Story:** As a user, I want to see relevant wellness information on my home screen, so that I stay engaged with my wellness goals.

#### Acceptance Criteria

1. THE System SHALL display 2 to 3 supportive sections below the hero card
2. THE System SHALL display a Daily Progress Summary section showing completed activities
3. THE System SHALL display a Suggested Routine or Tip of the Day section with wellness guidance
4. THE System SHALL display a Current Streak or Wellness Reminder section with motivational content
5. THE System SHALL style each supportive section as a card with consistent spacing and borders

### Requirement 5: Challenge Creation Entry Point

**User Story:** As a user, I want an obvious way to create a new challenge from the home screen, so that I can quickly start a wellness activity.

#### Acceptance Criteria

1. THE System SHALL display a Create Challenge card at the bottom of the home screen
2. THE System SHALL display a large Create Challenge button within the card
3. THE System SHALL provide visual feedback WHEN the Create Challenge button is tapped
4. WHEN the Create Challenge button is tapped, THE System SHALL navigate to the Challenge Creation Flow
5. THE System SHALL style the Create Challenge card to stand out from other home screen elements

### Requirement 6: Energy Level Selection Step

**User Story:** As a user, I want to indicate my current energy level, so that the challenge matches my physical state.

#### Acceptance Criteria

1. THE System SHALL display the prompt text "How's your energy today?" at the top of the energy selection screen
2. THE System SHALL display three selectable options: Low, Medium, and High
3. THE System SHALL display an icon representing each energy level option
4. WHEN a user taps an energy level option, THE System SHALL highlight the selected option with animation
5. WHEN a user selects an energy level, THE System SHALL transition smoothly to the location selection step within 300 milliseconds

### Requirement 7: Location Selection Step

**User Story:** As a user, I want to specify my current location, so that the challenge is appropriate for my environment.

#### Acceptance Criteria

1. THE System SHALL display the prompt text "Where are you right now?" at the top of the location selection screen
2. THE System SHALL display four selectable options: Home, Office, Gym, and Outdoor
3. THE System SHALL display an icon representing each location option
4. WHEN a user taps a location option, THE System SHALL highlight the selected option with subtle animation
5. WHEN a user selects a location, THE System SHALL transition smoothly to the wellness goal selection step within 300 milliseconds

### Requirement 8: Wellness Goal Selection Step

**User Story:** As a user, I want to choose a wellness focus area, so that the challenge aligns with my current needs.

#### Acceptance Criteria

1. THE System SHALL display the prompt text "What wellness area do you want to focus on?" at the top of the goal selection screen
2. THE System SHALL display six selectable wellness goal cards: Stress Reduction, Increased Energy, Better Sleep, Physical Fitness, Healthy Eating, and Social Connection
3. THE System SHALL display each wellness goal as a card with title and visual representation
4. WHEN a user taps a wellness goal card, THE System SHALL scale the card slightly and apply a highlight effect
5. WHEN a user selects a wellness goal, THE System SHALL display a Generate Challenge button below the cards

### Requirement 9: Challenge Generation and Display

**User Story:** As a user, I want to receive a personalized challenge recommendation, so that I can engage in a relevant wellness activity.

#### Acceptance Criteria

1. WHEN the user taps the Generate Challenge button, THE System SHALL display a static placeholder challenge text
2. THE System SHALL display the generated challenge within a rounded card component
3. THE System SHALL display the challenge text with clear typography and adequate spacing
4. THE System SHALL display a Start Challenge button below the generated challenge card
5. WHEN the Start Challenge button is tapped, THE System SHALL provide visual feedback to the user

### Requirement 10: Challenge Creation Flow Animations

**User Story:** As a user, I want smooth transitions between challenge creation steps, so that the experience feels polished and engaging.

#### Acceptance Criteria

1. THE System SHALL use slide or fade transitions between challenge creation steps
2. THE System SHALL complete step transitions within 300 milliseconds
3. WHEN a user selects an option card, THE System SHALL apply a scale animation with glow effect
4. THE System SHALL use smooth easing curves for all animations
5. THE System SHALL maintain 60 frames per second during transitions

### Requirement 11: Visual Consistency and Theme Preservation

**User Story:** As a user, I want the updated UI to maintain the existing visual style, so that the app feels cohesive.

#### Acceptance Criteria

1. THE System SHALL use the existing color palette for all new UI components
2. THE System SHALL apply rounded corners to all cards and buttons consistent with the current theme
3. THE System SHALL use the existing typography scale and font family
4. THE System SHALL maintain consistent spacing and padding across all screens
5. THE System SHALL preserve the existing component shapes and shadow styles

### Requirement 12: Responsive Layout Adaptation

**User Story:** As a user on different devices, I want the UI to adapt appropriately, so that I have a good experience regardless of screen size.

#### Acceptance Criteria

1. THE System SHALL scale the hero card proportionally on different screen sizes
2. THE System SHALL adjust supportive section layouts for small screens (minimum 320px width)
3. THE System SHALL display challenge creation option cards in a scrollable layout on small screens
4. THE System SHALL maintain minimum touch target sizes of 44x44 logical pixels for all interactive elements
5. THE System SHALL adapt font sizes proportionally based on screen dimensions
