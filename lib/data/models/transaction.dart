/// Transaction Types
enum TransactionType {
  purchase,    // Bought Scholar coins
  prediction,  // Spent on prediction
  winnings,    // Won from prediction
  refund,      // Match cancelled/postponed
  storeOrder,  // Spent in store
  bonus,       // Welcome bonus, promotions
}

/// Transaction model
class Transaction {
  final String id;
  final String userId;
  final TransactionType type;
  final int amount;
  final int balanceAfter;
  final String description;
  final DateTime timestamp;
  final String? referenceId; // matchId, orderId, etc.
  
  Transaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.balanceAfter,
    required this.description,
    required this.timestamp,
    this.referenceId,
  });
  
  bool get isCredit => type == TransactionType.purchase || 
                        type == TransactionType.winnings || 
                        type == TransactionType.refund ||
                        type == TransactionType.bonus;
  
  String get typeIcon {
    switch (type) {
      case TransactionType.purchase:
        return '💳';
      case TransactionType.prediction:
        return '⚽';
      case TransactionType.winnings:
        return '🏆';
      case TransactionType.refund:
        return '↩️';
      case TransactionType.storeOrder:
        return '🛒';
      case TransactionType.bonus:
        return '🎁';
    }
  }
  
  String get typeLabel {
    switch (type) {
      case TransactionType.purchase:
        return 'Purchase';
      case TransactionType.prediction:
        return 'Prediction';
      case TransactionType.winnings:
        return 'Winnings';
      case TransactionType.refund:
        return 'Refund';
      case TransactionType.storeOrder:
        return 'Store Order';
      case TransactionType.bonus:
        return 'Bonus';
    }
  }
}

/// Scholar Package for purchase
class ScholarPackage {
  final String id;
  final int amount;
  final double price;
  final String? currency;
  final String? badge; // "Popular", "Best Value", etc.
  final double? bonusPercent;
  
  ScholarPackage({
    required this.id,
    required this.amount,
    required this.price,
    this.currency = 'USD',
    this.badge,
    this.bonusPercent,
  });
  
  int get totalScholars {
    if (bonusPercent == null) return amount;
    return amount + (amount * bonusPercent! ~/ 100);
  }
  
  double get pricePerScholar => price / totalScholars;
}
