import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/typography.dart';
import '../../../core/utils/animations.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../data/models/wellness_pillar.dart';

/// WellnessPillarCard displays a wellness pillar with icon, name, description,
/// and available activities count in a grid layout
class WellnessPillarCard extends StatefulWidget {
  final WellnessPillar pillar;
  final VoidCallback onTap;

  const WellnessPillarCard({
    super.key,
    required this.pillar,
    required this.onTap,
  });

  @override
  State<WellnessPillarCard> createState() => _WellnessPillarCardState();
}

class _WellnessPillarCardState extends State<WellnessPillarCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Use standardized, subtle card tap animation
    _controller = AppAnimations.createCardTapController(this);
    _scaleAnimation = AppAnimations.createCardTapAnimation(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: CustomCard(
          padding: const EdgeInsets.all(AppDimensions.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and badge row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIcon(),
                  _buildActivityBadge(),
                ],
              ),
              const SizedBox(height: AppDimensions.spacing12),
              
              // Pillar name
              Text(
                widget.pillar.name,
                style: AppTypography.headingMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
              const SizedBox(height: AppDimensions.spacing4),
              
              // Pillar description
              Text(
                widget.pillar.description,
                style: AppTypography.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    // Map pillar IDs to icons
    IconData iconData;
    Color iconColor;

    switch (widget.pillar.id) {
      case 'stress-reduction':
        iconData = Icons.spa_rounded;
        iconColor = AppColors.calmBlue;
        break;
      case 'increased-energy':
        iconData = Icons.bolt_rounded;
        iconColor = AppColors.warmOrange;
        break;
      case 'better-sleep':
        iconData = Icons.bedtime_rounded;
        iconColor = AppColors.calmBlue;
        break;
      case 'physical-fitness':
        iconData = Icons.fitness_center_rounded;
        iconColor = AppColors.softGreen;
        break;
      case 'healthy-eating':
        iconData = Icons.restaurant_rounded;
        iconColor = AppColors.softGreen;
        break;
      case 'social-connection':
        iconData = Icons.people_rounded;
        iconColor = AppColors.warmOrange;
        break;
      default:
        iconData = Icons.favorite_rounded;
        iconColor = AppColors.calmBlue;
    }

    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacing8),
      decoration: BoxDecoration(
        color: iconColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Icon(
        iconData,
        size: AppDimensions.iconSizeMedium,
        color: iconColor,
      ),
    );
  }

  Widget _buildActivityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacing8,
        vertical: AppDimensions.spacing4,
      ),
      decoration: BoxDecoration(
        color: AppColors.calmBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
      ),
      child: Text(
        '${widget.pillar.availableActivities}',
        style: AppTypography.captionBold.copyWith(
          color: AppColors.calmBlue,
        ),
      ),
    );
  }
}
