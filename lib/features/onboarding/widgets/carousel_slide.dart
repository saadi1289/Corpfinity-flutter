import 'package:flutter/material.dart';
import 'package:corpfinity_employee_app/core/constants/colors.dart';
import 'package:corpfinity_employee_app/core/constants/typography.dart';
import 'package:corpfinity_employee_app/core/constants/dimensions.dart';

/// CarouselSlide widget displays a single slide in the welcome carousel
/// with an illustration, header, and body text.
class CarouselSlide extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  const CarouselSlide({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.iconColor = AppColors.calmBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration placeholder (using icon for now)
          _buildIllustration(),
          const SizedBox(height: AppDimensions.spacing48),
          // Header text
          Text(
            title,
            style: AppTypography.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spacing16),
          // Body text
          Text(
            description,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.mediumGray,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: 100,
          color: iconColor,
        ),
      ),
    );
  }
}
