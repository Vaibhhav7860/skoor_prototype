import '../models/user.dart';
import '../models/prediction.dart';
import '../models/transaction.dart';

/// Mock user and prediction data
class MockUserData {
  MockUserData._();
  
  static final User currentUser = User(
    id: 'user_1',
    name: 'Alex Johnson',
    email: 'alex.johnson@email.com',
    phone: '+1 234 567 8900',
    avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    scholarBalance: 245,
    totalPredictions: 47,
    correctPredictions: 28,
    totalWinnings: 892,
    createdAt: DateTime.now().subtract(const Duration(days: 45)),
    isVerified: true,
  );
  
  static final List<Prediction> predictions = [
    Prediction(
      id: 'pred_1',
      oduserId: 'user_1',
      matchId: 'live_1',
      outcome: PredictionOutcome.homeWin,
      stake: 10,
      odds: 2.1,
      potentialWin: 21,
      status: PredictionStatus.active,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      homeTeamName: 'Manchester City',
      awayTeamName: 'Liverpool',
      homeTeamLogo: 'https://media.api-sports.io/football/teams/50.png',
      awayTeamLogo: 'https://media.api-sports.io/football/teams/40.png',
      matchDate: DateTime.now().subtract(const Duration(hours: 1)),
      league: 'Premier League',
    ),
    Prediction(
      id: 'pred_2',
      oduserId: 'user_1',
      matchId: 'up_1',
      outcome: PredictionOutcome.homeWin,
      stake: 5,
      odds: 2.1,
      potentialWin: 11,
      status: PredictionStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      homeTeamName: 'Arsenal',
      awayTeamName: 'Chelsea',
      homeTeamLogo: 'https://media.api-sports.io/football/teams/42.png',
      awayTeamLogo: 'https://media.api-sports.io/football/teams/49.png',
      matchDate: DateTime.now().add(const Duration(hours: 3)),
      league: 'Premier League',
    ),
    Prediction(
      id: 'pred_3',
      oduserId: 'user_1',
      matchId: 'comp_1',
      outcome: PredictionOutcome.homeWin,
      stake: 15,
      odds: 1.8,
      potentialWin: 27,
      status: PredictionStatus.won,
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 10)),
      actualWinnings: 27,
      homeTeamName: 'Liverpool',
      awayTeamName: 'Manchester United',
      homeTeamLogo: 'https://media.api-sports.io/football/teams/40.png',
      awayTeamLogo: 'https://media.api-sports.io/football/teams/33.png',
      matchDate: DateTime.now().subtract(const Duration(days: 1)),
      league: 'Premier League',
      finalHomeScore: 3,
      finalAwayScore: 0,
    ),
    Prediction(
      id: 'pred_4',
      oduserId: 'user_1',
      matchId: 'comp_2',
      outcome: PredictionOutcome.homeWin,
      stake: 10,
      odds: 2.2,
      potentialWin: 22,
      status: PredictionStatus.lost,
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 8)),
      homeTeamName: 'Chelsea',
      awayTeamName: 'Tottenham',
      homeTeamLogo: 'https://media.api-sports.io/football/teams/49.png',
      awayTeamLogo: 'https://media.api-sports.io/football/teams/47.png',
      matchDate: DateTime.now().subtract(const Duration(days: 2)),
      league: 'Premier League',
      finalHomeScore: 2,
      finalAwayScore: 2,
    ),
    Prediction(
      id: 'pred_5',
      oduserId: 'user_1',
      matchId: 'comp_3',
      outcome: PredictionOutcome.awayWin,
      stake: 20,
      odds: 3.5,
      potentialWin: 70,
      status: PredictionStatus.won,
      createdAt: DateTime.now().subtract(const Duration(days: 3, hours: 12)),
      actualWinnings: 70,
      homeTeamName: 'Paris Saint-Germain',
      awayTeamName: 'Real Madrid',
      homeTeamLogo: 'https://media.api-sports.io/football/teams/85.png',
      awayTeamLogo: 'https://media.api-sports.io/football/teams/541.png',
      matchDate: DateTime.now().subtract(const Duration(days: 3)),
      league: 'Champions League',
      finalHomeScore: 1,
      finalAwayScore: 2,
    ),
  ];
  
  static List<Prediction> get activePredictions =>
      predictions.where((p) => p.isActive).toList();
  
  static List<Prediction> get settledPredictions =>
      predictions.where((p) => p.isSettled).toList();
  
  static final PredictionStats stats = PredictionStats(
    totalPredictions: 47,
    wins: 28,
    losses: 17,
    pending: 2,
    totalStaked: 425,
    totalWinnings: 892,
  );
  
  static final List<Transaction> transactions = [
    Transaction(
      id: 'tx_1',
      userId: 'user_1',
      type: TransactionType.prediction,
      amount: -10,
      balanceAfter: 245,
      description: 'Prediction on Man City vs Liverpool',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      referenceId: 'pred_1',
    ),
    Transaction(
      id: 'tx_2',
      userId: 'user_1',
      type: TransactionType.prediction,
      amount: -5,
      balanceAfter: 255,
      description: 'Prediction on Arsenal vs Chelsea',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      referenceId: 'pred_2',
    ),
    Transaction(
      id: 'tx_3',
      userId: 'user_1',
      type: TransactionType.winnings,
      amount: 27,
      balanceAfter: 260,
      description: 'Won: Liverpool 3-0 Man United',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      referenceId: 'pred_3',
    ),
    Transaction(
      id: 'tx_4',
      userId: 'user_1',
      type: TransactionType.prediction,
      amount: -15,
      balanceAfter: 233,
      description: 'Prediction on Liverpool vs Man United',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 10)),
      referenceId: 'pred_3',
    ),
    Transaction(
      id: 'tx_5',
      userId: 'user_1',
      type: TransactionType.winnings,
      amount: 70,
      balanceAfter: 248,
      description: 'Won: PSG 1-2 Real Madrid',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      referenceId: 'pred_5',
    ),
    Transaction(
      id: 'tx_6',
      userId: 'user_1',
      type: TransactionType.purchase,
      amount: 100,
      balanceAfter: 178,
      description: 'Purchased 100 Scholars',
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: 'tx_7',
      userId: 'user_1',
      type: TransactionType.bonus,
      amount: 5,
      balanceAfter: 78,
      description: 'Welcome bonus - 5 free Scholars!',
      timestamp: DateTime.now().subtract(const Duration(days: 45)),
    ),
  ];
}

/// Scholar packages for purchase
class MockScholarPackages {
  MockScholarPackages._();
  
  static final List<ScholarPackage> packages = [
    ScholarPackage(
      id: 'pkg_1',
      amount: 50,
      price: 4.99,
      currency: 'USD',
    ),
    ScholarPackage(
      id: 'pkg_2',
      amount: 100,
      price: 8.99,
      currency: 'USD',
      badge: 'Popular',
      bonusPercent: 10,
    ),
    ScholarPackage(
      id: 'pkg_3',
      amount: 250,
      price: 19.99,
      currency: 'USD',
      badge: 'Best Value',
      bonusPercent: 20,
    ),
    ScholarPackage(
      id: 'pkg_4',
      amount: 500,
      price: 34.99,
      currency: 'USD',
      bonusPercent: 30,
    ),
    ScholarPackage(
      id: 'pkg_5',
      amount: 1000,
      price: 59.99,
      currency: 'USD',
      badge: 'Premium',
      bonusPercent: 50,
    ),
  ];
}
