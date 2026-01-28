/// User model for Skoor app
class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final int scholarBalance;
  final int totalPredictions;
  final int correctPredictions;
  final int totalWinnings;
  final DateTime createdAt;
  final bool isVerified;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatarUrl,
    required this.scholarBalance,
    this.totalPredictions = 0,
    this.correctPredictions = 0,
    this.totalWinnings = 0,
    required this.createdAt,
    this.isVerified = false,
  });
  
  double get accuracyRate {
    if (totalPredictions == 0) return 0;
    return (correctPredictions / totalPredictions) * 100;
  }
  
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    int? scholarBalance,
    int? totalPredictions,
    int? correctPredictions,
    int? totalWinnings,
    DateTime? createdAt,
    bool? isVerified,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      scholarBalance: scholarBalance ?? this.scholarBalance,
      totalPredictions: totalPredictions ?? this.totalPredictions,
      correctPredictions: correctPredictions ?? this.correctPredictions,
      totalWinnings: totalWinnings ?? this.totalWinnings,
      createdAt: createdAt ?? this.createdAt,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
