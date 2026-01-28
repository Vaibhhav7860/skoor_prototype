/// Prediction Outcome Types
enum PredictionOutcome {
  homeWin,
  draw,
  awayWin,
}

/// Prediction Status
enum PredictionStatus {
  pending,  // Match not started
  active,   // Match in progress
  won,      // Prediction correct
  lost,     // Prediction wrong
  refunded, // Match cancelled/postponed
}

/// Prediction model
class Prediction {
  final String id;
  final String oduserId;
  final String matchId;
  final PredictionOutcome outcome;
  final int stake;
  final double odds;
  final int potentialWin;
  final PredictionStatus status;
  final DateTime createdAt;
  final int? actualWinnings;
  
  // Match info for display
  final String homeTeamName;
  final String awayTeamName;
  final String homeTeamLogo;
  final String awayTeamLogo;
  final DateTime matchDate;
  final String league;
  final int? finalHomeScore;
  final int? finalAwayScore;
  
  Prediction({
    required this.id,
    required this.oduserId,
    required this.matchId,
    required this.outcome,
    required this.stake,
    required this.odds,
    required this.potentialWin,
    required this.status,
    required this.createdAt,
    this.actualWinnings,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.matchDate,
    required this.league,
    this.finalHomeScore,
    this.finalAwayScore,
  });
  
  String get outcomeDisplay {
    switch (outcome) {
      case PredictionOutcome.homeWin:
        return homeTeamName;
      case PredictionOutcome.draw:
        return 'Draw';
      case PredictionOutcome.awayWin:
        return awayTeamName;
    }
  }
  
  String get statusDisplay {
    switch (status) {
      case PredictionStatus.pending:
        return 'Pending';
      case PredictionStatus.active:
        return 'In Progress';
      case PredictionStatus.won:
        return 'Won';
      case PredictionStatus.lost:
        return 'Lost';
      case PredictionStatus.refunded:
        return 'Refunded';
    }
  }
  
  bool get isActive => status == PredictionStatus.pending || status == PredictionStatus.active;
  bool get isSettled => status == PredictionStatus.won || status == PredictionStatus.lost;
}

/// Prediction Stats
class PredictionStats {
  final int totalPredictions;
  final int wins;
  final int losses;
  final int pending;
  final int totalStaked;
  final int totalWinnings;
  
  PredictionStats({
    required this.totalPredictions,
    required this.wins,
    required this.losses,
    required this.pending,
    required this.totalStaked,
    required this.totalWinnings,
  });
  
  double get winRate {
    final settled = wins + losses;
    if (settled == 0) return 0;
    return (wins / settled) * 100;
  }
  
  int get netProfit => totalWinnings - totalStaked;
}
