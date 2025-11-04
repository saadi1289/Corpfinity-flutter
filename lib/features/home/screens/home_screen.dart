import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/typography.dart';
import '../providers/home_provider.dart';
import '../widgets/energy_level_card.dart';
import '../widgets/quick_stats_widget.dart';

/// HomeScreen displays the main dashboard with energy level selection
/// and quick stats for the user
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize with mock data for now
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<HomeProvider>();
      provider.fetchQuickStats();
    });
  }

  void _handleEnergySelection(BuildContext context, EnergyLevel energy) {
    final provider = context.read<HomeProvider>();
    provider.selectEnergyLevel(energy);
    
    // Navigate to wellness pillar screen with energy level
    context.push('/pillars?energy=${energy.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            final state = provider.state;
            
            return CustomScrollView(
              slivers: [
                // App Bar with greeting
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.screenPaddingHorizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppDimensions.spacing16),
                        _buildGreeting(state.userName),
                        const SizedBox(height: AppDimensions.spacing8),
                        Text(
                          'How are you feeling today?',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.mediumGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Energy Level Cards
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.screenPaddingHorizontal,
                      vertical: AppDimensions.spacing20,
                    ),
                    child: Column(
                      children: [
                        EnergyLevelCard(
                          energyLevel: EnergyLevel.low,
                          onTap: () => _handleEnergySelection(context, EnergyLevel.low),
                          isSelected: state.selectedEnergy == EnergyLevel.low,
                        ),
                        const SizedBox(height: AppDimensions.spacing16),
                        EnergyLevelCard(
                          energyLevel: EnergyLevel.medium,
                          onTap: () => _handleEnergySelection(context, EnergyLevel.medium),
                          isSelected: state.selectedEnergy == EnergyLevel.medium,
                        ),
                        const SizedBox(height: AppDimensions.spacing16),
                        EnergyLevelCard(
                          energyLevel: EnergyLevel.high,
                          onTap: () => _handleEnergySelection(context, EnergyLevel.high),
                          isSelected: state.selectedEnergy == EnergyLevel.high,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Quick Stats Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.screenPaddingHorizontal,
                    ),
                    child: state.isLoading
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(AppDimensions.spacing24),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : QuickStatsWidget(
                            currentStreak: state.currentStreak,
                            weeklyProgress: state.weeklyProgress,
                            totalActivities: state.totalActivities,
                          ),
                  ),
                ),
                
                // Bottom spacing
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppDimensions.spacing32),
                ),
              ],
            );
          },
        ),
      ),
      
      // Bottom Navigation Bar (placeholder for future implementation)
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildGreeting(String userName) {
    final hour = DateTime.now().hour;
    String greeting;
    
    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }
    
    return RichText(
      text: TextSpan(
        style: AppTypography.displayMedium,
        children: [
          TextSpan(text: '$greeting, '),
          TextSpan(
            text: userName,
            style: AppTypography.displayMedium.copyWith(
              color: AppColors.calmBlue,
            ),
          ),
          const TextSpan(text: '!'),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing16,
            vertical: AppDimensions.spacing8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(
                key: const ValueKey('nav_home'),
                icon: Icons.home_rounded,
                label: 'Home',
                isActive: true,
                onTap: () {},
              ),
              _NavBarItem(
                key: const ValueKey('nav_library'),
                icon: Icons.library_books_rounded,
                label: 'Library',
                isActive: false,
                onTap: () => context.push('/library'),
              ),
              _NavBarItem(
                key: const ValueKey('nav_progress'),
                icon: Icons.trending_up_rounded,
                label: 'Progress',
                isActive: false,
                onTap: () => context.push('/progress'),
              ),
              _NavBarItem(
                key: const ValueKey('nav_profile'),
                icon: Icons.person_rounded,
                label: 'Profile',
                isActive: false,
                onTap: () => context.push('/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Navigation bar item widget
class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.calmBlue : AppColors.mediumGray;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacing12,
          vertical: AppDimensions.spacing8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: AppDimensions.iconSizeMedium,
            ),
            const SizedBox(height: AppDimensions.spacing4),
            Text(
              label,
              style: AppTypography.captionBold.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
