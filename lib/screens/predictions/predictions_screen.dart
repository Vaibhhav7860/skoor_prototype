import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock/mock_user_data.dart';
import '../../data/models/prediction.dart';
import '../../widgets/common/common_widgets.dart';

class PredictionsScreen extends StatefulWidget {
  const PredictionsScreen({super.key});

  @override
  State<PredictionsScreen> createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stats = MockUserData.stats;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.stadiumGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'My Predictions',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              // Stats Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        '${stats.wins}',
                        'Wins',
                        AppColors.success,
                        Icons.emoji_events_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        '${stats.losses}',
                        'Losses',
                        AppColors.error,
                        Icons.cancel_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        '${stats.winRate.toStringAsFixed(0)}%',
                        'Win Rate',
                        AppColors.gold,
                        Icons.trending_up_rounded,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tab Bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  labelColor: AppColors.textPrimary,
                  unselectedLabelColor: AppColors.textSecondary,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Active'),
                          if (MockUserData.activePredictions.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gold,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${MockUserData.activePredictions.length}',
                                style: TextStyle(
                                  color: AppColors.textOnGold,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const Tab(text: 'History'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPredictionList(MockUserData.activePredictions),
                    _buildPredictionList(MockUserData.settledPredictions),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color, IconData icon) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionList(List<Prediction> predictions) {
    if (predictions.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.sports_score_outlined,
        title: 'No predictions yet',
        subtitle: 'Start predicting to see your history here',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: predictions.length,
      itemBuilder: (context, index) {
        return _buildPredictionCard(predictions[index]);
      },
    );
  }

  Widget _buildPredictionCard(Prediction prediction) {
    Color statusColor;
    IconData statusIcon;
    
    switch (prediction.status) {
      case PredictionStatus.pending:
        statusColor = AppColors.upcoming;
        statusIcon = Icons.schedule_rounded;
        break;
      case PredictionStatus.active:
        statusColor = AppColors.live;
        statusIcon = Icons.play_circle_outline;
        break;
      case PredictionStatus.won:
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle_outline;
        break;
      case PredictionStatus.lost:
        statusColor = AppColors.error;
        statusIcon = Icons.cancel_outlined;
        break;
      case PredictionStatus.refunded:
        statusColor = AppColors.warning;
        statusIcon = Icons.replay_rounded;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: GlassCard(
        borderColor: statusColor.withOpacity(0.3),
        child: Column(
          children: [
            // Match Info
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          prediction.homeTeamLogo,
                          width: 32,
                          height: 32,
                          errorBuilder: (_, __, ___) => Container(
                            width: 32,
                            height: 32,
                            color: AppColors.surface,
                            child: Icon(Icons.shield, size: 20, color: AppColors.textMuted),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${prediction.homeTeamName} vs ${prediction.awayTeamName}',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          prediction.awayTeamLogo,
                          width: 32,
                          height: 32,
                          errorBuilder: (_, __, ___) => Container(
                            width: 32,
                            height: 32,
                            color: AppColors.surface,
                            child: Icon(Icons.shield, size: 20, color: AppColors.textMuted),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(color: AppColors.surfaceLight, height: 1),
            const SizedBox(height: 12),
            
            // Prediction Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Pick',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      prediction.outcomeDisplay,
                      style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Stake',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.stars_rounded, size: 14, color: AppColors.gold),
                        const SizedBox(width: 4),
                        Text(
                          '${prediction.stake}',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      prediction.isSettled ? 'Result' : 'Potential Win',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.stars_rounded, size: 14, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          prediction.status == PredictionStatus.won
                              ? '+${prediction.actualWinnings}'
                              : prediction.status == PredictionStatus.lost
                                  ? '0'
                                  : '${prediction.potentialWin}',
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prediction.league,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
                StatusBadge(
                  label: prediction.statusDisplay,
                  color: statusColor,
                  pulsing: prediction.status == PredictionStatus.active,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
