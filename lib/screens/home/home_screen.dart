import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock/mock_matches.dart';
import '../../data/mock/mock_news.dart';
import '../../data/mock/mock_user_data.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/cards/match_card.dart';
import '../../widgets/cards/news_card.dart';
import '../matches/match_detail_screen.dart';
import '../wallet/wallet_screen.dart';
import '../predictions/predictions_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockUserData.currentUser;
    final featuredMatches = MockMatches.featuredMatches;
    final upcomingMatches = MockMatches.upcomingMatches.take(3).toList();
    final news = MockNews.featuredNews;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.stadiumGradient,
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, ${user.name.split(' ').first}! 👋',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ready to predict?',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ScholarBalanceChip(
                            balance: user.scholarBalance,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const WalletScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 12),
                          IconButtonWithBg(
                            icon: Icons.notifications_outlined,
                            badge: '3',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Quick Stats
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildQuickStat(
                          context,
                          Icons.emoji_events_rounded,
                          '${user.correctPredictions}',
                          'Wins',
                          AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQuickStat(
                          context,
                          Icons.trending_up_rounded,
                          '${user.accuracyRate.toStringAsFixed(0)}%',
                          'Win Rate',
                          AppColors.gold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PredictionsScreen(),
                              ),
                            );
                          },
                          child: _buildQuickStat(
                            context,
                            Icons.sports_score_rounded,
                            '${MockUserData.activePredictions.length}',
                            'Active',
                            AppColors.upcoming,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Featured Matches Carousel
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeader(
                      title: 'Featured Matches',
                      actionLabel: 'See All',
                      onActionTap: () {},
                    ),
                    const SizedBox(height: 12),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 240,
                        viewportFraction: 0.85,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 5),
                      ),
                      items: featuredMatches.map((match) {
                        return FeaturedMatchCard(
                          match: match,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MatchDetailScreen(match: match),
                              ),
                            );
                          },
                          onPredictTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MatchDetailScreen(match: match),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Live Matches Section
              if (MockMatches.liveMatches.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: SectionHeader(
                    title: '🔴 Live Now',
                    actionLabel: 'See All',
                    onActionTap: () {},
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final match = MockMatches.liveMatches[index];
                      return MatchCard(
                        match: match,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MatchDetailScreen(match: match),
                            ),
                          );
                        },
                      );
                    },
                    childCount: MockMatches.liveMatches.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],

              // Upcoming Matches
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Upcoming Matches',
                  actionLabel: 'See All',
                  onActionTap: () {},
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final match = upcomingMatches[index];
                    return MatchCard(
                      match: match,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MatchDetailScreen(match: match),
                          ),
                        );
                      },
                    );
                  },
                  childCount: upcomingMatches.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Latest News
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Latest News',
                  actionLabel: 'See All',
                  onActionTap: () {},
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return NewsListItem(
                        article: news[index],
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStat(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
