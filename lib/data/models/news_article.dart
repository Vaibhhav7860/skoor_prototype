/// News Category
enum NewsCategory {
  matchPreview,
  matchAnalysis,
  transfers,
  breaking,
  opinions,
  highlights,
}

/// News Article model
class NewsArticle {
  final String id;
  final String title;
  final String summary;
  final String content;
  final String imageUrl;
  final String source;
  final String author;
  final DateTime publishedAt;
  final NewsCategory category;
  final int readTimeMinutes;
  final int views;
  final List<String> tags;
  final String? relatedMatchId;
  
  NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    required this.imageUrl,
    required this.source,
    required this.author,
    required this.publishedAt,
    required this.category,
    this.readTimeMinutes = 3,
    this.views = 0,
    this.tags = const [],
    this.relatedMatchId,
  });
  
  String get categoryLabel {
    switch (category) {
      case NewsCategory.matchPreview:
        return 'Match Preview';
      case NewsCategory.matchAnalysis:
        return 'Analysis';
      case NewsCategory.transfers:
        return 'Transfers';
      case NewsCategory.breaking:
        return 'Breaking';
      case NewsCategory.opinions:
        return 'Opinion';
      case NewsCategory.highlights:
        return 'Highlights';
    }
  }
  
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(publishedAt);
    
    if (difference.inDays > 7) {
      return '${difference.inDays ~/ 7}w ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
