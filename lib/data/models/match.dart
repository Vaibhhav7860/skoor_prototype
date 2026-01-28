/// Team model
class Team {
  final String id;
  final String name;
  final String shortName;
  final String logoUrl;
  final String country;
  final String? league;
  
  Team({
    required this.id,
    required this.name,
    required this.shortName,
    required this.logoUrl,
    required this.country,
    this.league,
  });
}

/// Match Status
enum MatchStatus {
  upcoming,
  live,
  halftime,
  completed,
  postponed,
  cancelled,
}

/// Match model
class Match {
  final String id;
  final Team homeTeam;
  final Team awayTeam;
  final DateTime matchDate;
  final MatchStatus status;
  final int? homeScore;
  final int? awayScore;
  final String league;
  final String leagueLogo;
  final int? minute;
  final String? venue;
  final int predictionFee;
  final double homeWinOdds;
  final double drawOdds;
  final double awayWinOdds;
  final int totalPredictions;
  final int prizePool;
  
  Match({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchDate,
    required this.status,
    this.homeScore,
    this.awayScore,
    required this.league,
    required this.leagueLogo,
    this.minute,
    this.venue,
    this.predictionFee = 5,
    this.homeWinOdds = 2.5,
    this.drawOdds = 3.0,
    this.awayWinOdds = 2.8,
    this.totalPredictions = 0,
    this.prizePool = 0,
  });
  
  String get scoreDisplay {
    if (homeScore == null || awayScore == null) return '- : -';
    return '$homeScore : $awayScore';
  }
  
  String get statusDisplay {
    switch (status) {
      case MatchStatus.upcoming:
        return 'Upcoming';
      case MatchStatus.live:
        return minute != null ? "$minute'" : 'LIVE';
      case MatchStatus.halftime:
        return 'HT';
      case MatchStatus.completed:
        return 'FT';
      case MatchStatus.postponed:
        return 'Postponed';
      case MatchStatus.cancelled:
        return 'Cancelled';
    }
  }
  
  bool get isLive => status == MatchStatus.live || status == MatchStatus.halftime;
  bool get isPredictable => status == MatchStatus.upcoming;
  
  Match copyWith({
    String? id,
    Team? homeTeam,
    Team? awayTeam,
    DateTime? matchDate,
    MatchStatus? status,
    int? homeScore,
    int? awayScore,
    String? league,
    String? leagueLogo,
    int? minute,
    String? venue,
    int? predictionFee,
    double? homeWinOdds,
    double? drawOdds,
    double? awayWinOdds,
    int? totalPredictions,
    int? prizePool,
  }) {
    return Match(
      id: id ?? this.id,
      homeTeam: homeTeam ?? this.homeTeam,
      awayTeam: awayTeam ?? this.awayTeam,
      matchDate: matchDate ?? this.matchDate,
      status: status ?? this.status,
      homeScore: homeScore ?? this.homeScore,
      awayScore: awayScore ?? this.awayScore,
      league: league ?? this.league,
      leagueLogo: leagueLogo ?? this.leagueLogo,
      minute: minute ?? this.minute,
      venue: venue ?? this.venue,
      predictionFee: predictionFee ?? this.predictionFee,
      homeWinOdds: homeWinOdds ?? this.homeWinOdds,
      drawOdds: drawOdds ?? this.drawOdds,
      awayWinOdds: awayWinOdds ?? this.awayWinOdds,
      totalPredictions: totalPredictions ?? this.totalPredictions,
      prizePool: prizePool ?? this.prizePool,
    );
  }
}

/// Match Events
enum MatchEventType {
  goal,
  assist,
  yellowCard,
  redCard,
  substitution,
  penalty,
  ownGoal,
  var_check,
}

class MatchEvent {
  final String id;
  final MatchEventType type;
  final int minute;
  final String playerName;
  final String teamId;
  final String? assistPlayerName;
  
  MatchEvent({
    required this.id,
    required this.type,
    required this.minute,
    required this.playerName,
    required this.teamId,
    this.assistPlayerName,
  });
}
