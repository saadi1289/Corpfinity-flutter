# Design Document: Card Styling and Layout Improvements

## Overview

This design addresses styling inconsistencies and layout issues in the challenge flow screens. The solution implements a unified card styling system with color-coded outline/fill icon behavior, horizontal scrollable layouts for better space utilization, and fixes for bottom overflow errors.

### Key Design Principles

1. **Visual Consistency**: All selection cards follow the same styling pattern across energy, location, and wellness goal selections
2. **Color Semantics**: Each option type uses meaningful colors (red/yellow/green for energy, contextual colors for locations and goals)
3. **Progressive Disclosure**: Icons transition from outline to filled state to clearly indicate selection
4. **Responsive Layout**: Horizontal scrollable layouts adapt to various screen sizes
5. **Accessibility**: Maintain minimum touch targets and semantic labels throughout

## Architecture

### Component Hierarchy

```
ChallengeFlowScreen
├── Energy Selection Step
│   └── Horizontal ScrollView
│       └── Row of SelectionCards (3 cards)
├── Location Selection Step
│   └── Horizontal ScrollView
│       └── Row of SelectionCards (4 cards)
└── Wellness Goal Selection Step
    └── Horizontal ScrollView (or Grid on larger screens)
        └── SelectionCards (6 cards)

WellnessPillarScreen
└── Grid of WellnessPillarCards
```

### State Management

- **ChallengeFlowProvider**: Manages selection state for energy, location, and wellness goals
- **Local Widget State**: Handles animation controllers for card transitions
- **Selection State**: Boolean `isSelected` prop drives visual styling changes

## Components and Interfaces

### 1. Enhanced SelectionCard Widget

#### New Properties

```dart
class SelectionCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? accentColor;
  final double? iconSize;
  final bool useOutlineIcon; // NEW: Enable outline/fill behavior
  
  // ... constructor
}
```

#### Icon Rendering Logic

**Unselected State (Outline Icon)**:
- Icon rendered with colored stroke/outline
- Transparent or white fill
- No circular container background
- Accent color applied to outline with reduced opacity (0.7)

**Selected State (Filled Icon)**:
- Icon rendered with solid color fill
- Full accent color applied
- No outline needed (icon itself is filled)

**Implementation Approach**:
```dart
Widget _buildIcon(Color accentColor) {
  if (widget.useOutlineIcon) {
    // Outline icon for unselected, filled for selected
    return Icon(
      widget.icon,
      size: widget.iconSize ?? AppDimensions.iconSizeXLarge,
      color: widget.isSelected 
        ? accentColor  // Filled with full color
        : accentColor.withOpacity(0.7),  // Outline effect
    );
  } else {
    // Legacy behavior: circular container with icon
    return _buildLegacyIcon(accentColor);
  }
}
```

#### Card Container Styling

**Unselected State**:
- Background: `AppColors.white`
- Border: `AppColors.neutralGray`, 1px width
- Shadow: Subtle neutral shadow (existing `_defaultShadow`)
- Text: `AppColors.darkText`

**Selected State**:
- Background: `AppColors.white` (NOT filled with accent color)
- Border: `accentColor`, 3px width
- Shadow: Colored glow effect with accent color at 0.3 opacity, 12px blur, 2px spread
- Text: `AppColors.darkText` (remains dark for readability on white)

### 2. Color Mapping System

#### Energy Level Colors (Already Defined)

```dart
// In AppColors
static const Color energyLow = gentleRed;      // Red
static const Color energyMedium = warmOrange;  // Yellow/Orange
static const Color energyHigh = softGreen;     // Green
```

#### Location Context Colors (To Be Added)

```dart
// In AppColors
static const Color professionalBlue = calmBlue;    // Office
static const Color energeticRed = gentleRed;       // Gym
static const Color natureGreen = softGreen;        // Outdoor
// warmOrange already exists for Home
```

#### Wellness Goal Colors (To Be Added)

```dart
// In AppColors
static const Color softPurple = Color(0xFF9B59B6);   // Better Sleep
static const Color freshGreen = Color(0xFF27AE60);   // Healthy Eating
static const Color coralPink = Color(0xFFFF6B9D);    // Social Connection
// Reuse existing colors:
// calmBlue for Stress Reduction
// warmOrange for Increased Energy
// softGreen for Physical Fitness
```

#### Color Mapping Helpers

```dart
// In ChallengeFlowScreen
Color _getLocationColor(LocationContext location) {
  switch (location) {
    case LocationContext.home:
      return AppColors.warmOrange;
    case LocationContext.office:
      return AppColors.professionalBlue;
    case LocationContext.gym:
      return AppColors.energeticRed;
    case LocationContext.outdoor:
      return AppColors.natureGreen;
  }
}

Color _getGoalColor(WellnessGoal goal) {
  switch (goal) {
    case WellnessGoal.stressReduction:
      return AppColors.calmBlue;
    case WellnessGoal.increasedEnergy:
      return AppColors.warmOrange;
    case WellnessGoal.betterSleep:
      return AppColors.softPurple;
    case WellnessGoal.physicalFitness:
      return AppColors.softGreen;
    case WellnessGoal.healthyEating:
      return AppColors.freshGreen;
    case WellnessGoal.socialConnection:
      return AppColors.coralPink;
  }
}
```

### 3. Layout Implementation

#### Energy Level Selection

**Current**: Vertical column with scrolling
**New**: Horizontal row with scrolling

```dart
Widget _buildEnergySelectionStep(ChallengeFlowProvider provider) {
  return SafeArea(
    child: LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final padding = ResponsiveHelper.getScreenPadding(context);
        final cardWidth = (screenWidth - (padding * 2) - (16 * 2)) / 3; // 3 cards with spacing
        
        return Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              // Header
              Text('How\'s your energy today?', ...),
              SizedBox(height: ...),
              
              // Horizontal scrollable cards
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: _buildEnergyCard(provider, EnergyLevel.low, AppColors.energyLow),
                        ),
                        SizedBox(width: 16),
                        SizedBox(
                          width: cardWidth,
                          child: _buildEnergyCard(provider, EnergyLevel.medium, AppColors.energyMedium),
                        ),
                        SizedBox(width: 16),
                        SizedBox(
                          width: cardWidth,
                          child: _buildEnergyCard(provider, EnergyLevel.high, AppColors.energyHigh),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Step indicator
              Text('Step 1 of 3', ...),
            ],
          ),
        );
      },
    ),
  );
}
```

#### Location Selection

**Current**: 2-column grid (or single column on very small screens)
**New**: Keep 2-column grid layout, but fix overflow issues and add color-coding

The existing 2-column grid layout will be maintained. Changes focus on:
- Adding color-coded styling to each location card
- Fixing overflow issues with proper constraints
- Applying outline/fill icon behavior

```dart
Widget _buildLocationCard(
  ChallengeFlowProvider provider,
  LocationContext location,
) {
  final isSelected = provider.selectedLocation == location;
  final color = _getLocationColor(location); // NEW: Color mapping
  
  return RepaintBoundary(
    child: SizedBox(
      height: 120,
      child: SelectionCard(
        label: LocationContextHelper.getLabel(location),
        icon: LocationContextHelper.getIcon(location),
        isSelected: isSelected,
        accentColor: color, // NEW: Use location-specific color
        useOutlineIcon: true, // NEW: Enable outline/fill behavior
        onTap: () {
          provider.selectLocation(location);
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              provider.goToNextStep();
            }
          });
        },
        iconSize: 48,
      ),
    ),
  );
}
```

#### Wellness Goal Selection

**Current**: 2-column grid (or single column on very small screens)
**New**: Keep 2-column grid layout, but fix overflow issues and add color-coding

The existing 2-column grid layout will be maintained. Changes focus on:
- Adding color-coded styling to each wellness goal card
- Fixing overflow issues with proper constraints
- Applying outline/fill icon behavior

```dart
Widget _buildGoalCard(
  ChallengeFlowProvider provider,
  WellnessGoal goal,
) {
  final isSelected = provider.selectedGoal == goal;
  final color = _getGoalColor(goal); // NEW: Color mapping
  
  return RepaintBoundary(
    child: SizedBox(
      height: 100,
      child: SelectionCard(
        label: WellnessGoalHelper.getLabel(goal),
        icon: WellnessGoalHelper.getIcon(goal),
        isSelected: isSelected,
        accentColor: color, // NEW: Use goal-specific color
        useOutlineIcon: true, // NEW: Enable outline/fill behavior
        onTap: () {
          provider.selectGoal(goal);
        },
        iconSize: 40,
      ),
    ),
  );
}
```

### 4. WellnessPillarCard Enhancement

#### New Properties

```dart
class WellnessPillarCard extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;
  final int availableActivities;
  final VoidCallback onTap;
  final Color? accentColor;
  final bool isSelected; // NEW: Track selection state
  
  // ... constructor
}
```

#### Styling Updates

Apply the same outline/fill icon behavior and colored border/shadow when selected:

```dart
@override
Widget build(BuildContext context) {
  final color = accentColor ?? AppColors.calmBlue;
  
  return AnimatedContainer(
    duration: Duration(milliseconds: 200),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
      border: Border.all(
        color: isSelected ? color : AppColors.neutralGray,
        width: isSelected ? 3 : 1,
      ),
      boxShadow: isSelected
        ? [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ]
        : [/* default shadow */],
    ),
    // ... rest of card content
  );
}
```

## Data Models

No new data models required. Existing enums are sufficient:
- `EnergyLevel` (low, medium, high)
- `LocationContext` (home, office, gym, outdoor)
- `WellnessGoal` (stressReduction, increasedEnergy, betterSleep, physicalFitness, healthyEating, socialConnection)

## Error Handling

### Overflow Prevention

1. **Horizontal Scrolling**: Wrap card rows in `SingleChildScrollView` with `Axis.horizontal`
2. **Flexible Sizing**: Use `LayoutBuilder` to calculate responsive card widths
3. **SafeArea**: Ensure content respects system UI (notches, navigation bars)
4. **Expanded Widgets**: Use `Expanded` to allow flexible height allocation

### Edge Cases

- **Very Small Screens**: Cards shrink proportionally but maintain minimum touch target (44x44)
- **Very Large Screens**: Cards have maximum width constraints to prevent excessive stretching
- **Long Text**: Labels use `maxLines` and `overflow: TextOverflow.ellipsis`
- **Missing Colors**: Fallback to `AppColors.calmBlue` if color mapping fails

## Testing Strategy

### Unit Tests

1. **Color Mapping Functions**:
   - Test `_getLocationColor()` returns correct color for each location
   - Test `_getGoalColor()` returns correct color for each goal
   - Verify fallback behavior

2. **SelectionCard Widget**:
   - Test outline icon rendering when `useOutlineIcon: true` and `isSelected: false`
   - Test filled icon rendering when `useOutlineIcon: true` and `isSelected: true`
   - Verify border width changes (1px → 3px)
   - Verify shadow changes (subtle → colored glow)
   - Test animation triggers

### Widget Tests

1. **Layout Tests**:
   - Verify horizontal scrolling is enabled
   - Test card width calculations for various screen sizes
   - Ensure no overflow errors on small screens (320px width)
   - Verify spacing between cards

2. **Visual Tests**:
   - Snapshot test for unselected energy cards (red, yellow, green outlines)
   - Snapshot test for selected energy cards (filled icons with colored borders)
   - Snapshot test for location cards with different colors
   - Snapshot test for wellness goal cards

### Integration Tests

1. **Challenge Flow**:
   - Navigate through all three steps
   - Select each option and verify visual changes
   - Test auto-advance behavior after selection
   - Verify no overflow errors during navigation

2. **Accessibility**:
   - Verify semantic labels include color information
   - Test with screen reader
   - Verify minimum touch targets maintained

## Performance Considerations

1. **RepaintBoundary**: Wrap individual cards to isolate repaints
2. **Const Constructors**: Use const where possible for static widgets
3. **Animation Controllers**: Properly dispose controllers to prevent memory leaks
4. **Shadow Optimization**: Reuse static shadow definitions to avoid recreation

## Step Navigation

### Back Button Implementation

The app bar will display a conditional back button based on the current step:

```dart
AppBar(
  title: const Text('Create Challenge'),
  leading: Semantics(
    label: provider.currentStep > 0 
      ? 'Go back to previous step' 
      : 'Go back to previous screen',
    button: true,
    child: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        if (provider.currentStep > 0) {
          provider.goToPreviousStep();
        } else {
          context.pop();
        }
      },
    ),
  ),
)
```

### Interactive Step Indicator

Replace the static step text with an interactive step indicator:

```dart
Widget _buildStepIndicator(ChallengeFlowProvider provider) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildStepDot(0, provider.currentStep, provider.selectedEnergy != null),
      _buildStepLine(provider.selectedEnergy != null),
      _buildStepDot(1, provider.currentStep, provider.selectedLocation != null),
      _buildStepLine(provider.selectedLocation != null),
      _buildStepDot(2, provider.currentStep, provider.selectedGoal != null),
    ],
  );
}

Widget _buildStepDot(int step, int currentStep, bool isCompleted) {
  final isActive = step == currentStep;
  final canNavigate = step < currentStep || isCompleted;
  
  return GestureDetector(
    onTap: canNavigate ? () => _navigateToStep(step) : null,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted || isActive 
          ? AppColors.calmBlue 
          : AppColors.neutralGray,
        border: isActive 
          ? Border.all(color: AppColors.calmBlue, width: 2)
          : null,
      ),
    ),
  );
}

Widget _buildStepLine(bool isCompleted) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 200),
    width: 40,
    height: 2,
    color: isCompleted ? AppColors.calmBlue : AppColors.neutralGray,
  );
}

void _navigateToStep(int step) {
  final provider = context.read<ChallengeFlowProvider>();
  if (step < provider.currentStep) {
    // Navigate backwards
    while (provider.currentStep > step) {
      provider.goToPreviousStep();
    }
  }
}
```

### State Preservation

The `ChallengeFlowProvider` already maintains state for all selections, so navigating back and forth will preserve user choices. No additional state management needed.

## Accessibility

1. **Semantic Labels**: Update to include color information (e.g., "Low energy, red icon")
2. **Touch Targets**: Maintain 44x44 minimum size even in horizontal layouts
3. **Color Contrast**: Ensure text remains readable on white backgrounds
4. **Focus Order**: Horizontal scrolling maintains logical focus order
5. **Navigation Labels**: Back button and step indicators have clear semantic labels

## Migration Path

1. Add new color constants to `AppColors`
2. Update `SelectionCard` with `useOutlineIcon` parameter (default: false for backward compatibility)
3. Refactor energy selection layout to horizontal
4. Refactor location selection layout to horizontal
5. Update wellness goal cards with color mapping
6. Enhance `WellnessPillarCard` with selection state
7. Fix grid overflow by adjusting `childAspectRatio`

## Visual Design Specifications

### Card Dimensions

- **Energy Cards**: Height 80px, Width calculated (screenWidth - padding) / 3 (horizontal layout)
- **Location Cards**: Height 120px, Width flexible in 2-column grid
- **Wellness Goal Cards**: Height 100px, Width flexible in 2-column grid

### Spacing

- **Between Cards**: 16px for energy, 12px for location and goals
- **Horizontal Padding**: Responsive (16-24px based on screen size)
- **Vertical Spacing**: 24-40px between header and cards

### Animation Timing

- **Selection Animation**: 200ms ease-out
- **Scale Animation**: 1.0 → 1.05 over 200ms
- **Border/Shadow Transition**: 200ms ease-out

### Color Opacity Values

- **Unselected Icon Outline**: 0.7 opacity
- **Selected Shadow**: 0.3 opacity
- **Icon Container Background** (legacy): 0.15 opacity
