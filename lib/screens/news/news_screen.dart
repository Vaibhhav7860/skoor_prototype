import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock/mock_news.dart';
import '../../data/models/news_article.dart';
import '../../widgets/cards/news_card.dart';
import 'news_detail_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsCategory? _selectedCategory;

  List<NewsArticle> get _filteredArticles {
    if (_selectedCategory == null) return MockNews.articles;
    return MockNews.getByCategory(_selectedCategory!);
  }

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        'News',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search_rounded,
                          color: AppColors.textPrimary,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Category Filter
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildCategoryChip(null, 'All'),
                      ...NewsCategory.values.map((cat) {
                        String label;
                        switch (cat) {
                          case NewsCategory.matchPreview:
                            label = 'Previews';
                            break;
                          case NewsCategory.matchAnalysis:
                            label = 'Analysis';
                            break;
                          case NewsCategory.transfers:
                            label = 'Transfers';
                            break;
                          case NewsCategory.breaking:
                            label = 'Breaking';
                            break;
                          case NewsCategory.opinions:
                            label = 'Opinions';
                            break;
                          case NewsCategory.highlights:
                            label = 'Highlights';
                            break;
                        }
                        return _buildCategoryChip(cat, label);
                      }),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Featured Article
              if (_selectedCategory == null && MockNews.articles.isNotEmpty)
                SliverToBoxAdapter(
                  child: NewsCard(
                    article: MockNews.articles.first,
                    featured: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NewsDetailScreen(
                            article: MockNews.articles.first,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),

              // News List
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final article = _selectedCategory == null
                        ? _filteredArticles.skip(1).toList()[index]
                        : _filteredArticles[index];
                    return NewsCard(
                      article: article,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NewsDetailScreen(article: article),
                          ),
                        );
                      },
                    );
                  },
                  childCount: _selectedCategory == null
                      ? _filteredArticles.length - 1
                      : _filteredArticles.length,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(NewsCategory? category, String label) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = category;
          });
        },
        backgroundColor: AppColors.surface,
        selectedColor: AppColors.gold.withOpacity(0.2),
        labelStyle: TextStyle(
          color: isSelected ? AppColors.gold : AppColors.textSecondary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
        side: BorderSide(
          color: isSelected ? AppColors.gold : AppColors.surfaceLight,
        ),
        showCheckmark: false,
      ),
    );
  }
}
