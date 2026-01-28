import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock/mock_user_data.dart';
import '../../widgets/common/common_widgets.dart';
import '../wallet/wallet_screen.dart';
import '../predictions/predictions_screen.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockUserData.currentUser;
    final stats = MockUserData.stats;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.stadiumGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings_outlined,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Profile Card
                GlassCard(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: AppColors.surface,
                                backgroundImage: NetworkImage(user.avatarUrl ?? ''),
                                onBackgroundImageError: (_, __) {},
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              if (user.isVerified)
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: AppColors.success,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.card,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.email,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit_outlined,
                              color: AppColors.gold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Balance
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const WalletScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: AppColors.goldGradient,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.stars_rounded,
                                color: AppColors.textOnGold,
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Scholar Balance',
                                      style: TextStyle(
                                        color: AppColors.textOnGold.withOpacity(0.8),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '${user.scholarBalance}',
                                      style: TextStyle(
                                        color: AppColors.textOnGold,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppColors.textOnGold,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Stats Card
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Performance',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          CircularPercentIndicator(
                            radius: 50,
                            lineWidth: 8,
                            percent: stats.winRate / 100,
                            center: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${stats.winRate.toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Win Rate',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            progressColor: AppColors.gold,
                            backgroundColor: AppColors.surface,
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              children: [
                                _buildStatRow(
                                  'Total Predictions',
                                  '${stats.totalPredictions}',
                                  Icons.sports_score_rounded,
                                ),
                                _buildStatRow(
                                  'Wins',
                                  '${stats.wins}',
                                  Icons.emoji_events_rounded,
                                  color: AppColors.success,
                                ),
                                _buildStatRow(
                                  'Total Winnings',
                                  '${stats.totalWinnings}',
                                  Icons.stars_rounded,
                                  color: AppColors.gold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Menu Items
                GlassCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _buildMenuItem(
                        context,
                        Icons.history_rounded,
                        'Prediction History',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PredictionsScreen(),
                            ),
                          );
                        },
                      ),
                      Divider(color: AppColors.surfaceLight, height: 1),
                      _buildMenuItem(
                        context,
                        Icons.shopping_bag_outlined,
                        'Order History',
                        onTap: () {},
                      ),
                      Divider(color: AppColors.surfaceLight, height: 1),
                      _buildMenuItem(
                        context,
                        Icons.notifications_outlined,
                        'Notifications',
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                      Divider(color: AppColors.surfaceLight, height: 1),
                      _buildMenuItem(
                        context,
                        Icons.privacy_tip_outlined,
                        'Privacy & Security',
                        onTap: () {},
                      ),
                      Divider(color: AppColors.surfaceLight, height: 1),
                      _buildMenuItem(
                        context,
                        Icons.help_outline_rounded,
                        'Help & Support',
                        onTap: () {},
                      ),
                      Divider(color: AppColors.surfaceLight, height: 1),
                      _buildMenuItem(
                        context,
                        Icons.info_outline_rounded,
                        'About',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Logout
                GlassCard(
                  padding: EdgeInsets.zero,
                  child: _buildMenuItem(
                    context,
                    Icons.logout_rounded,
                    'Log Out',
                    color: AppColors.error,
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 40),

                // Version
                Text(
                  'Skoor v1.0.0',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color ?? AppColors.textSecondary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color ?? AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label, {
    Widget? trailing,
    Color? color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: color ?? AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: color ?? AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (trailing != null) trailing,
            if (trailing == null)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: color ?? AppColors.textMuted,
              ),
          ],
        ),
      ),
    );
  }
}
