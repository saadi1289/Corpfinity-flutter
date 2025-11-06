# Requirements Document

## Introduction

This specification addresses styling and layout issues in the challenge flow screens, specifically for energy level selection, location selection, and wellness goals selection. The system currently experiences bottom overflow errors and inconsistent card styling. The solution will implement horizontal card layouts with color-coded icons that use outline styling when unselected and filled styling when selected, along with matching borders and shadows.

## Glossary

- **Challenge Flow Screen**: The multi-step screen where users select their energy level, location, and wellness goals
- **Selection Card**: A reusable card widget used for displaying selectable options with icons and labels
- **Energy Level**: User's current energy state (Low, Medium, High)
- **Location Context**: Where the user is located (Home, Office, Gym, Outdoor)
- **Wellness Goal**: User's desired wellness outcome (Stress Reduction, Increased Energy, Better Sleep, Physical Fitness, Healthy Eating, Social Connection)
- **Wellness Pillar Card**: Card widget used in the wellness pillar grid display
- **Outline Icon**: Icon rendered with colored stroke/border but transparent fill
- **Filled Icon**: Icon rendered with solid color fill

## Requirements

### Requirement 1: Fix Bottom Overflow Errors

**User Story:** As a user, I want the challenge flow screens to display properly without overflow errors, so that I can view and interact with all options comfortably.

#### Acceptance Criteria

1. WHEN THE Challenge Flow Screen displays the wellness pillar grid, THE System SHALL render all cards without bottom overflow errors
2. WHEN THE Challenge Flow Screen displays energy level options, THE System SHALL render all cards without bottom overflow errors
3. WHEN THE Challenge Flow Screen displays location options, THE System SHALL render all cards without bottom overflow errors
4. WHEN THE Challenge Flow Screen displays wellness goal options, THE System SHALL render all cards without bottom overflow errors

### Requirement 2: Horizontal Energy Level Layout

**User Story:** As a user, I want energy level cards arranged horizontally in a single row, so that I can easily compare and select my current energy state.

#### Acceptance Criteria

1. WHEN THE Challenge Flow Screen displays the energy selection step, THE System SHALL arrange energy level cards in a horizontal row
2. WHEN THE screen width is insufficient to display all cards, THE System SHALL enable horizontal scrolling
3. WHEN THE energy cards are displayed, THE System SHALL center them vertically on the screen
4. WHEN THE energy cards are displayed, THE System SHALL apply consistent spacing between cards
5. WHEN THE energy cards are displayed, THE System SHALL calculate responsive card widths based on available screen space

### Requirement 3: Fixed Location Layout with Proper Constraints

**User Story:** As a user, I want location cards displayed in a 2-column grid without overflow errors, so that I can easily view and select my location.

#### Acceptance Criteria

1. WHEN THE Challenge Flow Screen displays the location selection step, THE System SHALL arrange location cards in a 2-column grid
2. WHEN THE screen is very small, THE System SHALL arrange location cards in a single column
3. WHEN THE location cards are displayed, THE System SHALL apply proper constraints to prevent overflow
4. WHEN THE location cards are displayed, THE System SHALL apply consistent spacing between cards
5. WHEN THE location cards are displayed, THE System SHALL maintain the existing responsive grid behavior

### Requirement 4: Color-Coded Energy Level Icons with Outline/Fill Behavior

**User Story:** As a user, I want energy level cards to display with color-coded icons that change from outline to filled when selected, so that I can clearly see my selection and understand the energy levels visually.

#### Acceptance Criteria

1. WHEN THE energy level card for Low is unselected, THE System SHALL display a red outlined icon
2. WHEN THE energy level card for Medium is unselected, THE System SHALL display a yellow outlined icon
3. WHEN THE energy level card for High is unselected, THE System SHALL display a green outlined icon
4. WHEN THE energy level card for Low is selected, THE System SHALL display a red filled icon
5. WHEN THE energy level card for Medium is selected, THE System SHALL display a yellow filled icon
6. WHEN THE energy level card for High is selected, THE System SHALL display a green filled icon
7. WHEN THE energy level card is unselected, THE System SHALL display a neutral gray border with 1px width
8. WHEN THE energy level card is selected, THE System SHALL display a colored border matching the icon color with 3px width
9. WHEN THE energy level card is unselected, THE System SHALL display a subtle shadow
10. WHEN THE energy level card is selected, THE System SHALL display a colored shadow with glow effect matching the icon color

### Requirement 5: Color-Coded Wellness Goal Icons with Outline/Fill Behavior

**User Story:** As a user, I want wellness goal cards to display with color-coded icons that change from outline to filled when selected, so that I can clearly see my selections and distinguish between different goals.

#### Acceptance Criteria

1. WHEN THE wellness goal cards are displayed, THE System SHALL assign unique colors to each goal type
2. WHEN THE wellness goal card is unselected, THE System SHALL display an outlined icon in the goal's assigned color
3. WHEN THE wellness goal card is selected, THE System SHALL display a filled icon in the goal's assigned color
4. WHEN THE wellness goal card is selected, THE System SHALL display a colored border matching the goal's color with 3px width
5. WHEN THE wellness goal card is unselected, THE System SHALL display a neutral gray border with 1px width
6. WHEN THE wellness goal card is selected, THE System SHALL display a colored shadow with glow effect matching the goal's color
7. WHEN THE wellness goal card is unselected, THE System SHALL display a subtle shadow
8. WHEN THE wellness goal card maintains white background, THE System SHALL ensure text remains readable with dark color

### Requirement 6: Color-Coded Location Icons with Outline/Fill Behavior

**User Story:** As a user, I want location cards to display with color-coded icons that change from outline to filled when selected, so that I can clearly identify my location selection.

#### Acceptance Criteria

1. WHEN THE location card for Home is displayed, THE System SHALL use warm orange color
2. WHEN THE location card for Office is displayed, THE System SHALL use professional blue color
3. WHEN THE location card for Gym is displayed, THE System SHALL use energetic red color
4. WHEN THE location card for Outdoor is displayed, THE System SHALL use nature green color
5. WHEN THE location card is unselected, THE System SHALL display an outlined icon in the location's assigned color
6. WHEN THE location card is selected, THE System SHALL display a filled icon in the location's assigned color
7. WHEN THE location card is selected, THE System SHALL display a colored border and shadow matching the location's color

### Requirement 7: Consistent Card Styling Across All Selection Types

**User Story:** As a user, I want all selection cards to have consistent styling behavior, so that the interface feels cohesive and predictable.

#### Acceptance Criteria

1. WHEN ANY selection card is displayed, THE System SHALL maintain white background in both selected and unselected states
2. WHEN ANY selection card transitions between states, THE System SHALL animate the changes smoothly
3. WHEN ANY selection card is selected, THE System SHALL apply a 3px colored border
4. WHEN ANY selection card is unselected, THE System SHALL apply a 1px neutral gray border
5. WHEN ANY selection card is selected, THE System SHALL apply a colored shadow with glow effect
6. WHEN ANY selection card is unselected, THE System SHALL apply a subtle neutral shadow

### Requirement 8: Step Navigation

**User Story:** As a user, I want to navigate back to previous steps to change my selections, so that I can adjust my choices without restarting the entire flow.

#### Acceptance Criteria

1. WHEN THE Challenge Flow Screen displays step 2 or step 3, THE System SHALL display a back button in the app bar
2. WHEN THE user taps the back button, THE System SHALL navigate to the previous step
3. WHEN THE user navigates to a previous step, THE System SHALL preserve all previously made selections
4. WHEN THE user changes a selection on a previous step, THE System SHALL maintain that change when navigating forward again
5. WHEN THE Challenge Flow Screen displays any step, THE System SHALL display an interactive step indicator showing current progress
6. WHEN THE user taps on a completed step in the step indicator, THE System SHALL navigate to that step
7. WHEN THE user is on step 1, THE System SHALL display the default back button that exits the flow
