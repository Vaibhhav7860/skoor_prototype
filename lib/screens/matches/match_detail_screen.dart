import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/match.dart';
import '../../data/models/prediction.dart';
import '../../data/mock/mock_user_data.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/buttons/buttons.dart';

class MatchDetailScreen extends StatefulWidget {
  final Match match;

  const MatchDetailScreen({super.key, required this.match});

  @override
  State<MatchDetailScreen> createState() => _MatchDetailScreenState();
}

class _MatchDetailScreenState extends State<MatchDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  PredictionOutcome? _selectedOutcome;
  int _stakeAmount = 5;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int get _potentialWin {
    if (_selectedOutcome == null) return 0;
    double odds;
    switch (_selectedOutcome!) {
      case PredictionOutcome.homeWin:
        odds = widget.match.homeWinOdds;
        break;
      case PredictionOutcome.draw:
        odds = widget.match.drawOdds;
        break;
      case PredictionOutcome.awayWin:
        odds = widget.match.awayWinOdds;
        break;
    }
    return (_stakeAmount * odds).round();
  }

  void _showPredictionConfirmation() {
    if (_selectedOutcome == null) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Confirm Prediction',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            GlassCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Match',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      Text(
                        '${widget.match.homeTeam.shortName} vs ${widget.match.awayTeam.shortName}',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Your Pick',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      Text(
                        _getOutcomeLabel(),
                        style: TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stake',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      Row(
                        children: [
                          Icon(Icons.stars_rounded, size: 16, color: AppColors.gold),
                          const SizedBox(width: 4),
                          Text(
                            '$_stakeAmount',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(color: AppColors.surfaceLight),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Potential Win',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.stars_rounded, size: 20, color: AppColors.gold),
                          const SizedBox(width: 4),
                          Text(
                            '$_potentialWin',
                            style: TextStyle(
                              color: AppColors.gold,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Confirm Prediction',
              onPressed: () {
                Navigator.pop(context);
                _showSuccessDialog();
              },
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 48,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Prediction Placed!',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Good luck! You\'ll be notified when the match ends.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Done',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getOutcomeLabel() {
    switch (_selectedOutcome) {
      case PredictionOutcome.homeWin:
        return '${widget.match.homeTeam.name} Win';
      case PredictionOutcome.draw:
        return 'Draw';
      case PredictionOutcome.awayWin:
        return '${widget.match.awayTeam.name} Win';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.match.league,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share_outlined,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Match Header
              _buildMatchHeader(),
              const SizedBox(height: 16),

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
                  tabs: const [
                    Tab(text: 'Predict'),
                    Tab(text: 'Stats'),
                    Tab(text: 'H2H'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPredictTab(),
                    _buildStatsTab(),
                    _buildH2hTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Status Badge
          if (widget.match.isLive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                    widget.match.statusDisplay,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            Text(
              DateFormat('EEE, dd MMM • HH:mm').format(widget.match.matchDate),
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          const SizedBox(height: 20),
          // Teams and Score
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.match.homeTeam.logoUrl,
                        width: 64,
                        height: 64,
                        errorBuilder: (_, __, ___) => Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.shield, color: Colors.white54, size: 36),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.match.homeTeam.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Score or VS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: widget.match.status == MatchStatus.upcoming
                    ? Text(
                        'VS',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Row(
                        children: [
                          Text(
                            '${widget.match.homeScore ?? 0}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '-',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 32,
                              ),
                            ),
                          ),
                          Text(
                            '${widget.match.awayScore ?? 0}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.match.awayTeam.logoUrl,
                        width: 64,
                        height: 64,
                        errorBuilder: (_, __, ___) => Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.shield, color: Colors.white54, size: 36),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.match.awayTeam.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Venue
          if (widget.match.venue != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.stadium_outlined, size: 16, color: Colors.white54),
                const SizedBox(width: 6),
                Text(
                  widget.match.venue!,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPredictTab() {
    if (!widget.match.isPredictable) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_clock_outlined,
              size: 64,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 16),
            Text(
              'Predictions Closed',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This match has already started',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pool Info
          GlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.people_outline, color: AppColors.textSecondary),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.match.totalPredictions}',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Predictions',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(width: 1, height: 50, color: AppColors.surfaceLight),
                Column(
                  children: [
                    Icon(Icons.stars_rounded, color: AppColors.gold),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.match.prizePool}',
                      style: TextStyle(
                        color: AppColors.gold,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Prize Pool',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Outcome Selection
          Text(
            'Pick Your Outcome',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: PredictionButton(
                  label: widget.match.homeTeam.shortName,
                  odds: widget.match.homeWinOdds.toStringAsFixed(2),
                  isSelected: _selectedOutcome == PredictionOutcome.homeWin,
                  onTap: () {
                    setState(() {
                      _selectedOutcome = PredictionOutcome.homeWin;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PredictionButton(
                  label: 'Draw',
                  odds: widget.match.drawOdds.toStringAsFixed(2),
                  isSelected: _selectedOutcome == PredictionOutcome.draw,
                  onTap: () {
                    setState(() {
                      _selectedOutcome = PredictionOutcome.draw;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PredictionButton(
                  label: widget.match.awayTeam.shortName,
                  odds: widget.match.awayWinOdds.toStringAsFixed(2),
                  isSelected: _selectedOutcome == PredictionOutcome.awayWin,
                  onTap: () {
                    setState(() {
                      _selectedOutcome = PredictionOutcome.awayWin;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Stake Selection
          Text(
            'Stake Amount',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _stakeAmount > 5
                          ? () {
                              setState(() {
                                _stakeAmount -= 5;
                              });
                            }
                          : null,
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: _stakeAmount > 5
                            ? AppColors.textPrimary
                            : AppColors.textMuted,
                      ),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.stars_rounded, color: AppColors.gold, size: 24),
                          const SizedBox(width: 8),
                          Text(
                            '$_stakeAmount',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: _stakeAmount <
                              MockUserData.currentUser.scholarBalance
                          ? () {
                              setState(() {
                                _stakeAmount += 5;
                              });
                            }
                          : null,
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: _stakeAmount <
                                MockUserData.currentUser.scholarBalance
                            ? AppColors.textPrimary
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Balance: ${MockUserData.currentUser.scholarBalance} Scholars',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Potential Win
          if (_selectedOutcome != null) ...[
            GlassCard(
              borderColor: AppColors.gold.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Potential Win',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.stars_rounded, color: AppColors.gold, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '$_potentialWin',
                        style: TextStyle(
                          color: AppColors.gold,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Place Prediction Button
          PrimaryButton(
            label: 'Place Prediction',
            onPressed: _selectedOutcome != null ? _showPredictionConfirmation : null,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildStatRow('Possession', '54%', '46%'),
          _buildStatRow('Shots', '12', '8'),
          _buildStatRow('Shots on Target', '6', '3'),
          _buildStatRow('Corners', '7', '4'),
          _buildStatRow('Fouls', '9', '12'),
          _buildStatRow('Yellow Cards', '1', '2'),
          _buildStatRow('Passes', '487', '412'),
          _buildStatRow('Pass Accuracy', '89%', '84%'),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String home, String away) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                home,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              Text(
                away,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: AppColors.surfaceLight),
        ],
      ),
    );
  }

  Widget _buildH2hTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Meetings',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildH2hMatch('Dec 2024', '2', '1'),
          _buildH2hMatch('Aug 2024', '1', '1'),
          _buildH2hMatch('Apr 2024', '0', '2'),
          _buildH2hMatch('Jan 2024', '3', '1'),
          _buildH2hMatch('Oct 2023', '2', '2'),
        ],
      ),
    );
  }

  Widget _buildH2hMatch(String date, String homeScore, String awayScore) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            date,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Text(
            widget.match.homeTeam.shortName,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$homeScore - $awayScore',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            widget.match.awayTeam.shortName,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
