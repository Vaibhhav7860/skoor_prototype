/// Product Category
enum ProductCategory {
  jerseys,
  merchandise,
  accessories,
  collectibles,
  experiences,
}

/// Shipping Method
enum ShippingMethod {
  companyDirect,
  agentPartner,
  digitalDelivery,
}

/// Product model for store
class Product {
  final String id;
  final String name;
  final String description;
  final int scholarPrice;
  final String imageUrl;
  final List<String> galleryImages;
  final ProductCategory category;
  final ShippingMethod shippingMethod;
  final int stockQuantity;
  final bool isAvailable;
  final double? rating;
  final int reviewCount;
  final List<String>? sizes;
  final List<String>? colors;
  final String? brand;
  final bool isFeatured;
  
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.scholarPrice,
    required this.imageUrl,
    this.galleryImages = const [],
    required this.category,
    this.shippingMethod = ShippingMethod.companyDirect,
    this.stockQuantity = 0,
    this.isAvailable = true,
    this.rating,
    this.reviewCount = 0,
    this.sizes,
    this.colors,
    this.brand,
    this.isFeatured = false,
  });
  
  bool get inStock => stockQuantity > 0;
  
  String get categoryLabel {
    switch (category) {
      case ProductCategory.jerseys:
        return 'Jerseys';
      case ProductCategory.merchandise:
        return 'Merchandise';
      case ProductCategory.accessories:
        return 'Accessories';
      case ProductCategory.collectibles:
        return 'Collectibles';
      case ProductCategory.experiences:
        return 'Experiences';
    }
  }
  
  String get shippingLabel {
    switch (shippingMethod) {
      case ShippingMethod.companyDirect:
        return 'Direct Shipping';
      case ShippingMethod.agentPartner:
        return 'Partner Delivery';
      case ShippingMethod.digitalDelivery:
        return 'Digital Delivery';
    }
  }
}

/// Cart Item
class CartItem {
  final Product product;
  int quantity;
  final String? selectedSize;
  final String? selectedColor;
  
  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
  });
  
  int get totalPrice => product.scholarPrice * quantity;
}

/// Order Status
enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
}

/// Order model
class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final int totalScholars;
  final OrderStatus status;
  final DateTime createdAt;
  final String? trackingNumber;
  final String? shippingAddress;
  final DateTime? estimatedDelivery;
  
  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalScholars,
    required this.status,
    required this.createdAt,
    this.trackingNumber,
    this.shippingAddress,
    this.estimatedDelivery,
  });
  
  String get statusLabel {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}
