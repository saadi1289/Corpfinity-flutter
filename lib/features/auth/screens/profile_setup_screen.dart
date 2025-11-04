import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/typography.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/error_handler.dart';
import '../../../core/widgets/error_snackbar.dart';
import '../providers/auth_provider.dart';
import '../models/user.dart';

/// ProfileSetupScreen allows users to configure their profile after registration
/// 
/// Features:
/// - Name and company input fields
/// - Multi-select wellness goal chips with bounce animation
/// - Notification preferences toggle switches
/// - Navigation to home screen after completion
class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  
  // Wellness goals
  final List<String> _availableGoals = [
    'Stress Reduction',
    'Increased Energy',
    'Better Sleep',
    'Physical Fitness',
    'Healthy Eating',
    'Social Connection',
  ];
  final Set<String> _selectedGoals = {};
  
  // Notification preferences
  bool _notificationsEnabled = true;
  bool _dailyReminders = true;
  bool _achievementAlerts = true;
  
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedGoals.isEmpty) {
        ErrorSnackBar.show(
          context,
          'Please select at least one wellness goal',
        );
        return;
      }

      setState(() => _isLoading = true);
      
      final success = await ErrorHandler.handleAsync(
        context,
        () async {
          final authProvider = context.read<AuthProvider>();
          await authProvider.updateProfile(
            name: _nameController.text.trim(),
            company: _companyController.text.trim(),
            wellnessGoals: _selectedGoals.toList(),
            notifications: NotificationPreferences(
              enabled: _notificationsEnabled,
              dailyReminders: _dailyReminders,
              achievementAlerts: _achievementAlerts,
            ),
          );
        },
        onSuccess: () {
          if (mounted) {
            context.go('/home');
          }
        },
      );
      
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _toggleGoal(String goal) {
    setState(() {
      if (_selectedGoals.contains(goal)) {
        _selectedGoals.remove(goal);
      } else {
        _selectedGoals.add(goal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Set Up Your Profile',
          style: AppTypography.headingLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingHorizontal,
            vertical: AppDimensions.screenPaddingVertical,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Personal Information Section
                _buildSectionTitle('Personal Information'),
                const SizedBox(height: AppDimensions.spacing16),
                
                _buildInputCard(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        enabled: !_isLoading,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter your name',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                          ),
                        ),
                        validator: (value) => Validators.validateRequired(value, 'Name'),
                      ),
                      
                      const SizedBox(height: AppDimensions.spacing16),
                      
                      TextFormField(
                        controller: _companyController,
                        textInputAction: TextInputAction.done,
                        enabled: !_isLoading,
                        decoration: InputDecoration(
                          labelText: 'Company',
                          hintText: 'Enter your company name',
                          prefixIcon: const Icon(Icons.business_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                          ),
                        ),
                        validator: (value) => Validators.validateRequired(value, 'Company'),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppDimensions.spacing32),
                
                // Wellness Goals Section
                _buildSectionTitle('Wellness Goals'),
                const SizedBox(height: AppDimensions.spacing8),
                Text(
                  'Select areas you want to focus on',
                  style: AppTypography.bodySmall,
                ),
                const SizedBox(height: AppDimensions.spacing16),
                
                _buildInputCard(
                  child: Wrap(
                    spacing: AppDimensions.spacing8,
                    runSpacing: AppDimensions.spacing8,
                    children: _availableGoals.map((goal) {
                      return _WellnessGoalChip(
                        label: goal,
                        isSelected: _selectedGoals.contains(goal),
                        onTap: _isLoading ? null : () => _toggleGoal(goal),
                      );
                    }).toList(),
                  ),
                ),
                
                const SizedBox(height: AppDimensions.spacing32),
                
                // Notification Preferences Section
                _buildSectionTitle('Notification Preferences'),
                const SizedBox(height: AppDimensions.spacing16),
                
                _buildInputCard(
                  child: Column(
                    children: [
                      _buildToggleRow(
                        title: 'Enable Notifications',
                        subtitle: 'Receive wellness reminders and updates',
                        value: _notificationsEnabled,
                        onChanged: _isLoading
                            ? null
                            : (value) => setState(() => _notificationsEnabled = value),
                      ),
                      
                      const Divider(height: AppDimensions.spacing24),
                      
                      _buildToggleRow(
                        title: 'Daily Reminders',
                        subtitle: 'Get reminded to complete activities',
                        value: _dailyReminders,
                        onChanged: _isLoading || !_notificationsEnabled
                            ? null
                            : (value) => setState(() => _dailyReminders = value),
                      ),
                      
                      const Divider(height: AppDimensions.spacing24),
                      
                      _buildToggleRow(
                        title: 'Achievement Alerts',
                        subtitle: 'Celebrate your milestones and badges',
                        value: _achievementAlerts,
                        onChanged: _isLoading || !_notificationsEnabled
                            ? null
                            : (value) => setState(() => _achievementAlerts = value),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: AppDimensions.spacing40),
                
                // Continue button
                CustomButton(
                  text: 'Continue',
                  onPressed: _isLoading ? null : _handleContinue,
                  isLoading: _isLoading,
                  variant: ButtonVariant.primary,
                  size: ButtonSize.large,
                ),
                
                const SizedBox(height: AppDimensions.spacing24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.headingMedium,
    );
  }

  Widget _buildInputCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: AppDimensions.shadowBlurRadius,
            offset: const Offset(0, AppDimensions.shadowOffsetY),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppDimensions.spacing20),
      child: child,
    );
  }

  Widget _buildToggleRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.bodyMedium),
              const SizedBox(height: AppDimensions.spacing4),
              Text(
                subtitle,
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.calmBlue,
        ),
      ],
    );
  }
}

/// Animated wellness goal chip with bounce effect
class _WellnessGoalChip extends StatefulWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _WellnessGoalChip({
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  State<_WellnessGoalChip> createState() => _WellnessGoalChipState();
}

class _WellnessGoalChipState extends State<_WellnessGoalChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (widget.onTap == null) return;
    
    // Animate scale down then back up (bounce effect)
    await _controller.forward();
    await _controller.reverse();
    
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacing16,
            vertical: AppDimensions.spacing12,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected ? AppColors.calmBlue : AppColors.neutralGray,
            borderRadius: BorderRadius.circular(AppDimensions.radiusCircular),
            border: Border.all(
              color: widget.isSelected ? AppColors.calmBlue : Colors.transparent,
              width: 2,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTypography.bodyMedium.copyWith(
              color: widget.isSelected ? AppColors.white : AppColors.darkText,
              fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
