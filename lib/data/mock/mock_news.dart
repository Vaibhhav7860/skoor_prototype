import '../models/news_article.dart';

/// Mock news articles data
class MockNews {
  MockNews._();
  
  static final List<NewsArticle> articles = [
    NewsArticle(
      id: 'news_1',
      title: 'Manchester City vs Liverpool: El Clásico of English Football',
      summary: 'The two Premier League giants face off in what could be a title-deciding clash at the Etihad Stadium.',
      content: '''
The two Premier League giants face off in what could be a title-deciding clash at the Etihad Stadium.

Manchester City, under the guidance of Pep Guardiola, have been in scintillating form this season, winning their last five matches in all competitions. Their possession-based football has been a joy to watch, with Erling Haaland continuing his remarkable goal-scoring run.

Liverpool, on the other hand, have shown resilience under their management, bouncing back from early-season struggles to mount a serious title challenge. Mohamed Salah has been in imperious form, and the midfield additions have added steel to their play.

Key battles to watch include the midfield contest, where control of the game will be crucial. The defensive lines of both teams will be tested by some of the best attacking talent in world football.

This match has all the ingredients for a classic encounter, and fans worldwide will be glued to their screens for what promises to be 90 minutes of intense, high-quality football.
      ''',
      imageUrl: 'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=800',
      source: 'Skoor Sports',
      author: 'James Wilson',
      publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
      category: NewsCategory.matchPreview,
      readTimeMinutes: 4,
      views: 12540,
      tags: ['Premier League', 'Manchester City', 'Liverpool', 'Title Race'],
      relatedMatchId: 'live_1',
    ),
    NewsArticle(
      id: 'news_2',
      title: 'El Clásico Preview: Real Madrid Host Barcelona in La Liga Showdown',
      summary: 'The biggest rivalry in club football returns as Real Madrid welcome Barcelona to the Santiago Bernabéu.',
      content: '''
The biggest rivalry in club football returns as Real Madrid welcome Barcelona to the Santiago Bernabéu in a match that could have significant implications for the La Liga title race.

Real Madrid enter this fixture having won their last three league matches, with their attacking trio clicking perfectly. Barcelona, however, have been building momentum under their new tactical setup.

The match promises drama, passion, and world-class football as two of the sport's most decorated clubs battle for supremacy in Spanish football.

Historical statistics show that home advantage rarely guarantees success in this fixture, with both teams having won famous victories at the Bernabéu over the years.
      ''',
      imageUrl: 'https://images.unsplash.com/photo-1551958219-acbc608c6377?w=800',
      source: 'Skoor Sports',
      author: 'Carlos Martinez',
      publishedAt: DateTime.now().subtract(const Duration(hours: 4)),
      category: NewsCategory.matchPreview,
      readTimeMinutes: 5,
      views: 18930,
      tags: ['La Liga', 'Real Madrid', 'Barcelona', 'El Clásico'],
      relatedMatchId: 'live_2',
    ),
    NewsArticle(
      id: 'news_3',
      title: 'Transfer News: Premier League Giants Eye January Reinforcements',
      summary: 'As the January transfer window approaches, top English clubs are preparing their moves.',
      content: '''
As the January transfer window approaches, top English clubs are preparing their moves to strengthen their squads for the second half of the season.

Manchester United are reportedly close to finalizing a deal for a highly-rated central midfielder, while Arsenal continue their pursuit of a proven goal-scorer.

Chelsea's new ownership has shown willingness to invest, and multiple sources suggest they have identified targets across the pitch.

Liverpool are expected to be active as well, with their scouts having monitored several players throughout the season.

The January window traditionally sees fewer major moves than its summer counterpart, but this year could prove different as clubs seek the edge in their various competitions.
      ''',
      imageUrl: 'https://images.unsplash.com/photo-1560272564-c83b66b1ad12?w=800',
      source: 'Skoor Sports',
      author: 'David Thompson',
      publishedAt: DateTime.now().subtract(const Duration(hours: 8)),
      category: NewsCategory.transfers,
      readTimeMinutes: 6,
      views: 24100,
      tags: ['Transfer News', 'Premier League', 'January Window'],
    ),
    NewsArticle(
      id: 'news_4',
      title: 'Champions League Draw: Group Stage Analysis and Predictions',
      summary: 'Breaking down the Champions League groups and predicting which teams will advance.',
      content: '''
The Champions League group stage promises to deliver drama as usual, with several mouth-watering ties on the horizon.

Group of Death contenders include Bayern Munich, PSG, and several other European heavyweights all drawn together, setting up what could be the most competitive group in the tournament's history.

English clubs have been drawn into challenging groups, but their Premier League form suggests they have the quality to progress.

Spanish giants Real Madrid and Barcelona will look to add to their impressive European pedigrees, while Italian clubs aim to prove their recent resurgence is genuine.

Our analysts break down each group and provide their predictions for the knockout stages.
      ''',
      imageUrl: 'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?w=800',
      source: 'Skoor Sports',
      author: 'Emma Richards',
      publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      category: NewsCategory.matchAnalysis,
      readTimeMinutes: 7,
      views: 31250,
      tags: ['Champions League', 'Group Stage', 'Predictions'],
    ),
    NewsArticle(
      id: 'news_5',
      title: 'BREAKING: Star Striker Signs New Long-Term Contract',
      summary: 'In a major boost for the club, their talisman has committed his future with a new five-year deal.',
      content: '''
In news that will delight fans worldwide, one of football's most exciting talents has signed a new long-term contract with his current club.

The deal reportedly makes him one of the highest-paid players in the league, reflecting his outstanding contributions over recent seasons.

Club officials expressed their delight at securing the player's future, emphasizing his importance to the team's ambitions.

The player himself spoke of his happiness at the club and his desire to help bring more trophies to the fans.

This commitment ends months of speculation about potential moves and allows both player and club to focus fully on their on-pitch objectives.
      ''',
      imageUrl: 'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?w=800',
      source: 'Skoor Sports',
      author: 'Michael Brown',
      publishedAt: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      category: NewsCategory.breaking,
      readTimeMinutes: 3,
      views: 45600,
      tags: ['Breaking News', 'Contract', 'Transfer'],
    ),
    NewsArticle(
      id: 'news_6',
      title: 'Weekend Roundup: All the Goals and Talking Points',
      summary: 'A comprehensive review of all the action from across European football this weekend.',
      content: '''
What a weekend of football we have witnessed across Europe's top leagues!

The Premier League delivered drama as always, with late goals, VAR controversies, and standout individual performances.

La Liga saw the title race tighten as the top teams dropped points unexpectedly.

Bundesliga action was equally thrilling, with high-scoring affairs across multiple venues.

Serie A continues to surprise, with the traditional powers facing stiff competition from emerging challengers.

Our comprehensive review covers all the key moments, goals, and talking points from a memorable weekend of European football.
      ''',
      imageUrl: 'https://images.unsplash.com/photo-1489944440615-453fc2b6a9a9?w=800',
      source: 'Skoor Sports',
      author: 'Sarah Johnson',
      publishedAt: DateTime.now().subtract(const Duration(days: 2)),
      category: NewsCategory.highlights,
      readTimeMinutes: 8,
      views: 19870,
      tags: ['Weekend Roundup', 'Highlights', 'European Football'],
    ),
  ];
  
  static List<NewsArticle> get featuredNews => articles.take(3).toList();
  
  static List<NewsArticle> getByCategory(NewsCategory category) {
    return articles.where((a) => a.category == category).toList();
  }
}
