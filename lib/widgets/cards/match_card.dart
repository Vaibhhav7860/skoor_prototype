import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/match.dart';
import '../common/common_widgets.dart';

/// Match card for displaying match info
class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback? onTap;
  final bool showPredictionInfo;
  final bool compact;

  const MatchCard({
    super.key,
    required this.match,
    this.onTap,
    this.showPredictionInfo = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      margin: EdgeInsets.symmetric(
        horizontal: compact ? 0 : 20,
        vertical: compact ? 4 : 8,
      ),
      padding: EdgeInsets.all(compact ? 12 : 16),
      child: Column(
        children: [
          // League and status row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      match.leagueLogo,
                      width: 20,
                      height: 20,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.sports_soccer,
                        size: 20,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    match.league,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              _buildStatusBadge(),
            ],
          ),
          SizedBox(height: compact ? 12 : 16),
          // Teams and score row
          Row(
            children: [
              Expanded(child: _buildTeam(match.homeTeam, true)),
              _buildScore(),
              Expanded(child: _buildTeam(match.awayTeam, false)),
            ],
          ),
          if (showPredictionInfo && match.isPredictable) ...[
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            _buildPredictionInfo(),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color color;
    bool pulsing = false;
    
    switch (match.status) {
      case MatchStatus.live:
        color = AppColors.live;
        pulsing = true;
        break;
      case MatchStatus.halftime:
        color = AppColors.warning;
        break;
      case MatchStatus.upcoming:
        color = AppColors.upcoming;
        break;
      case MatchStatus.completed:
        color = AppColors.completed;
        break;
      default:
        color = AppColors.textMuted;
    }

    return StatusBadge(
      label: match.statusDisplay,
      color: color,
      pulsing: pulsing,
    );
  }

  Widget _buildTeam(Team team, bool isHome) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            team.logoUrl,
            width: compact ? 36 : 48,
            height: compact ? 36 : 48,
            errorBuilder: (_, __, ___) => Container(
              width: compact ? 36 : 48,
              height: compact ? 36 : 48,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.shield,
                color: AppColors.textMuted,
                size: compact ? 20 : 28,
              ),
            ),
          ),
        ),
        SizedBox(height: compact ? 6 : 8),
        Text(
          team.shortName,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: compact ? 12 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildScore() {
    if (match.status == MatchStatus.upcoming) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              DateFormat('HH:mm').format(match.matchDate),
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: compact ? 18 : 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              DateFormat('dd MMM').format(match.matchDate),
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${match.homeScore ?? 0}',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: compact ? 24 : 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              ':',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: compact ? 20 : 28,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            '${match.awayScore ?? 0}',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: compact ? 24 : 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.people_outline,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              '${match.totalPredictions} predictions',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.stars_rounded,
              size: 16,
              color: AppColors.gold,
            ),
            const SizedBox(width: 4),
            Text(
              '${match.predictionFee} to predict',
              style: TextStyle(
                color: AppColors.gold,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Featured match card for carousel
class FeaturedMatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback? onTap;
  final VoidCallback? onPredictTap;

  const FeaturedMatchCard({
    super.key,
    required this.match,
    this.onTap,
    this.onPredictTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryLight,
              AppColors.primary,
              AppColors.primaryDark,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(
                Icons.sports_soccer,
                size: 120,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // League and status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              match.leagueLogo,
                              width: 24,
                              height: 24,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.sports_soccer,
                                size: 24,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            match.league,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      _buildLiveIndicator(),
                    ],
                  ),
                  const Spacer(),
                  // Teams
                  Row(
                    children: [
                      _buildTeamColumn(match.homeTeam),
                      Expanded(
                        child: _buildCenterContent(),
                      ),
                      _buildTeamColumn(match.awayTeam),
                    ],
                  ),
                  const Spacer(),
                  // Prize pool and action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Prize Pool',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 11,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.stars_rounded,
                                size: 16,
                                color: AppColors.gold,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${match.prizePool}',
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (match.isPredictable)
                        ElevatedButton(
                          onPressed: onPredictTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            foregroundColor: AppColors.textOnGold,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Predict Now',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveIndicator() {
    if (!match.isLive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          DateFormat('HH:mm').format(match.matchDate),
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.live,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            match.statusDisplay,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamColumn(Team team) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              team.logoUrl,
              width: 44,
              height: 44,
              errorBuilder: (_, __, ___) => Icon(
                Icons.shield,
                size: 44,
                color: Colors.white54,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          team.shortName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCenterContent() {
    if (match.status == MatchStatus.upcoming) {
      return Column(
        children: [
          Text(
            'VS',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${match.homeScore ?? 0}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '-',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 28,
            ),
          ),
        ),
        Text(
          '${match.awayScore ?? 0}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
