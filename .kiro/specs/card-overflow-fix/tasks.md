# Implementation Plan

- [x] 1. Add new color constants to AppColors





  - Add location context colors (professionalBlue, energeticRed, natureGreen)
  - Add wellness goal colors (softPurple, freshGreen, coralPink)
  - Verify existing energy level colors (energyLow, energyMedium, energyHigh)
  - _Requirements: 4.1, 4.2, 4.3, 5.2, 6.1_
-

- [x] 2. Enhance SelectionCard widget with outline/fill icon behavior




  - [x] 2.1 Add useOutlineIcon parameter to SelectionCard


    - Add boolean parameter with default value true
    - Update constructor and widget properties
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 4.6_

  - [x] 2.2 Implement outline icon rendering for unselected state


    - Create icon with colored outline (stroke)
    - Use accentColor with reduced opacity for unselected state
    - Remove circular container background
    - _Requirements: 4.1, 4.2, 4.3_

  - [x] 2.3 Implement filled icon rendering for selected state

    - Fill icon with full accentColor when selected
    - Apply colored border to card (3px)
    - Apply colored shadow with glow effect
    - Keep card background white (not filled)
    - _Requirements: 4.4, 4.5, 4.6_

  - [x] 2.4 Update card container styling

    - Keep background white for both states
    - Update border: neutral gray (1px) when unselected, colored (3px) when selected
    - Update shadow: subtle when unselected, colored glow when selected
    - Maintain text as dark color (readable on white)
    - _Requirements: 4.7, 4.8_

- [x] 3. Refactor energy level selection to horizontal layout






  - [x] 3.1 Update _buildEnergySelectionStep layout structure

    - Wrap cards in SingleChildScrollView with horizontal scroll
    - Use Row instead of Column for card arrangement
    - Center the row vertically using Expanded and Center widgets
    - Add horizontal padding
    - _Requirements: 2.1, 2.2, 2.3, 2.4_

  - [x] 3.2 Calculate responsive card widths

    - Use LayoutBuilder to get screen width
    - Calculate card width: (screenWidth - padding) / 3
    - Wrap each card in SizedBox with calculated width
    - Add spacing between cards (16px)
    - _Requirements: 2.5_


  - [ ] 3.3 Update energy card rendering with color-coded styling
    - Pass useOutlineIcon: true to SelectionCard
    - Use energyLow (red) for Low energy card
    - Use energyMedium (yellow/orange) for Medium energy card
    - Use energyHigh (green) for High energy card
    - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5, 4.6_

- [x] 4. Update location selection with color-coded styling




  - [x] 4.1 Create location color mapping helper


    - Create _getLocationColor method in ChallengeFlowScreen
    - Map Home to warmOrange
    - Map Office to professionalBlue
    - Map Gym to energeticRed
    - Map Outdoor to natureGreen
    - _Requirements: 6.1, 6.2, 6.3_

  - [x] 4.2 Update location card rendering with color-coded styling


    - Update _buildLocationCard to use location-specific color from helper
    - Pass useOutlineIcon: true to SelectionCard
    - Apply color from _getLocationColor helper
    - Maintain existing 2-column grid layout
    - Maintain existing auto-advance behavior
    - _Requirements: 6.1, 6.2, 6.3, 6.4_

  - [x] 4.3 Fix location grid overflow issues


    - Ensure proper constraints on grid container
    - Add SafeArea padding if needed
    - Test on various screen sizes to verify no overflow
    - _Requirements: 1.2, 1.3_

- [x] 5. Implement wellness goals color coding






  - [x] 5.1 Create wellness goal color mapping helper

    - Create _getGoalColor method in ChallengeFlowScreen
    - Map Stress Reduction to calmBlue
    - Map Increased Energy to warmOrange
    - Map Better Sleep to softPurple
    - Map Physical Fitness to softGreen
    - Map Healthy Eating to freshGreen
    - Map Social Connection to coralPink
    - _Requirements: 5.1, 5.2_


  - [x] 5.2 Update wellness goal card rendering

    - Update _buildGoalCard to use goal-specific color from helper
    - Pass useOutlineIcon: true to SelectionCard
    - Apply colored styling for each goal
    - _Requirements: 5.2, 5.3, 5.4_
-

- [x] 6. Update WellnessPillarCard with color-coded styling




  - [x] 6.1 Add optional isSelected parameter to WellnessPillarCard


    - Add boolean parameter with default false
    - Update constructor
    - _Requirements: 5.2, 5.3_

  - [x] 6.2 Implement outline/fill icon behavior in WellnessPillarCard


    - Update _buildIcon method to support outline when unselected
    - Fill icon with color when selected
    - Apply colored border and shadow when selected
    - _Requirements: 5.2, 5.3, 5.4_

  - [x] 6.3 Update card container styling for selection state


    - Add AnimatedContainer for smooth transitions
    - Update border based on selection state
    - Update shadow based on selection state
    - Maintain existing tap animation
    - _Requirements: 5.5, 5.6, 5.7, 5.8_


- [x] 7. Fix wellness pillar grid overflow




  - [x] 7.1 Adjust childAspectRatio in WellnessPillarScreen


    - Change from 0.90 to 0.95 or 1.0 to reduce height
    - Test on various screen sizes
    - Ensure no content truncation
    - _Requirements: 1.1, 1.2, 1.3, 1.4_

  - [x] 7.2 Add flexible layout constraints


    - Wrap grid content in flexible containers
    - Add SafeArea bottom padding
    - Ensure proper spacing for step indicators
    - _Requirements: 1.2, 1.3_

- [x] 8. Implement step navigation






  - [x] 8.1 Update app bar back button behavior


    - Add conditional logic to back button onPressed
    - If currentStep > 0, call provider.goToPreviousStep()
    - If currentStep == 0, call context.pop() to exit flow
    - Update semantic label based on step
    - _Requirements: 8.1, 8.2, 8.7_

  - [x] 8.2 Create interactive step indicator widget


    - Create _buildStepIndicator method
    - Create _buildStepDot method with tap handling
    - Create _buildStepLine method
    - Display 3 dots connected by lines
    - Highlight current step and completed steps
    - _Requirements: 8.5, 8.6_

  - [x] 8.3 Implement step navigation logic


    - Create _navigateToStep method
    - Allow navigation to previous completed steps
    - Prevent navigation to future incomplete steps
    - Use provider.goToPreviousStep() in loop for backwards navigation
    - _Requirements: 8.3, 8.4, 8.6_

  - [x] 8.4 Replace static step text with interactive indicator


    - Remove "Step X of 3" text from all three steps
    - Add _buildStepIndicator() call in the same location
    - Ensure proper spacing and alignment
    - _Requirements: 8.5_

- [ ]* 9. Write widget tests for SelectionCard enhancements
  - Test outline icon rendering in unselected state
  - Test filled icon rendering in selected state
  - Verify color application for different accent colors
  - Test animation triggers on selection change
  - Verify card styling (border, shadow, background)
  - _Requirements: 4.1-4.10_

- [ ]* 10. Write widget tests for layout changes
  - Test energy level horizontal layout rendering
  - Test location 2-column grid layout rendering
  - Test wellness goal 2-column grid layout rendering
  - Verify horizontal scrolling behavior for energy cards
  - Test card sizing calculations
  - Ensure no overflow errors on various screen sizes
  - _Requirements: 2.1-2.5, 3.1-3.5_

- [ ]* 11. Write widget tests for step navigation
  - Test back button behavior on different steps
  - Test step indicator rendering
  - Test navigation to previous steps
  - Verify state preservation when navigating back and forth
  - Test tap handling on step dots
  - _Requirements: 8.1-8.7_

- [ ]* 12. Write integration tests for challenge flow
  - Navigate through all three steps
  - Verify color-coded styling on each step
  - Test selection state changes
  - Verify no overflow errors
  - Test auto-advance behavior
  - Test backwards navigation and reselection
  - _Requirements: All_

- [ ]* 13. Perform visual regression testing
  - Capture screenshots of energy selection (unselected and selected states)
  - Capture screenshots of location selection (all states)
  - Capture screenshots of wellness goals (various selections)
  - Capture screenshots of wellness pillar grid
  - Capture screenshots of step indicator in different states
  - Compare against design specifications
  - _Requirements: All_
