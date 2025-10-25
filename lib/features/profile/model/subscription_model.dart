/// Subscription model for managing user subscription data
class SubscriptionModel {
  final String id;
  final String planName;
  final String planType; // 'free', 'premium', 'pro'
  final bool isActive;
  final DateTime? startDate;
  final DateTime? endDate;
  final double price;
  final String currency;
  final String billingCycle; // 'monthly', 'yearly', 'lifetime'
  final List<String> features;
  final bool autoRenew;
  final String? paymentMethod;
  final DateTime? lastPaymentDate;
  final DateTime? nextBillingDate;

  const SubscriptionModel({
    required this.id,
    required this.planName,
    required this.planType,
    required this.isActive,
    this.startDate,
    this.endDate,
    required this.price,
    required this.currency,
    required this.billingCycle,
    required this.features,
    required this.autoRenew,
    this.paymentMethod,
    this.lastPaymentDate,
    this.nextBillingDate,
  });

  /// Create a copy of the subscription with updated fields
  SubscriptionModel copyWith({
    String? id,
    String? planName,
    String? planType,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    double? price,
    String? currency,
    String? billingCycle,
    List<String>? features,
    bool? autoRenew,
    String? paymentMethod,
    DateTime? lastPaymentDate,
    DateTime? nextBillingDate,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      planName: planName ?? this.planName,
      planType: planType ?? this.planType,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      billingCycle: billingCycle ?? this.billingCycle,
      features: features ?? this.features,
      autoRenew: autoRenew ?? this.autoRenew,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      lastPaymentDate: lastPaymentDate ?? this.lastPaymentDate,
      nextBillingDate: nextBillingDate ?? this.nextBillingDate,
    );
  }

  /// Check if subscription is expired
  bool get isExpired {
    if (endDate == null) return false;
    return DateTime.now().isAfter(endDate!);
  }

  /// Check if subscription is expiring soon (within 7 days)
  bool get isExpiringSoon {
    if (endDate == null) return false;
    final daysUntilExpiry = endDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiry <= 7 && daysUntilExpiry > 0;
  }

  /// Get subscription status text
  String get statusText {
    if (!isActive) return 'Inactive';
    if (isExpired) return 'Expired';
    if (isExpiringSoon) return 'Expiring Soon';
    return 'Active';
  }

  /// Get days until expiry
  int get daysUntilExpiry {
    if (endDate == null) return -1;
    return endDate!.difference(DateTime.now()).inDays;
  }

  /// Get formatted price string
  String get formattedPrice {
    return '${currency.toUpperCase()} \$${price.toStringAsFixed(2)}';
  }

  /// Get formatted billing cycle
  String get formattedBillingCycle {
    switch (billingCycle.toLowerCase()) {
      case 'monthly':
        return 'per month';
      case 'yearly':
        return 'per year';
      case 'lifetime':
        return 'one-time';
      default:
        return billingCycle;
    }
  }

  @override
  String toString() {
    return 'SubscriptionModel(id: $id, planName: $planName, planType: $planType, isActive: $isActive, statusText: $statusText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SubscriptionModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Subscription plan types
class SubscriptionPlans {
  static const String free = 'free';
  static const String premium = 'premium';
  static const String pro = 'pro';
}

/// Billing cycles
class BillingCycles {
  static const String monthly = 'monthly';
  static const String yearly = 'yearly';
  static const String lifetime = 'lifetime';
}

/// Default subscription plans
class DefaultPlans {
  static const SubscriptionModel freePlan = SubscriptionModel(
    id: 'free_plan',
    planName: 'Free Plan',
    planType: SubscriptionPlans.free,
    isActive: true,
    price: 0.0,
    currency: 'USD',
    billingCycle: BillingCycles.lifetime,
    features: [
      'Basic goal tracking',
      'Up to 3 goals',
      'Basic analytics',
      'Community support',
    ],
    autoRenew: false,
  );

  static const SubscriptionModel premiumPlan = SubscriptionModel(
    id: 'premium_plan',
    planName: 'Premium Plan',
    planType: SubscriptionPlans.premium,
    isActive: false,
    price: 9.99,
    currency: 'USD',
    billingCycle: BillingCycles.monthly,
    features: [
      'Unlimited goals',
      'Advanced analytics',
      'Priority support',
      'Export data',
      'Custom themes',
    ],
    autoRenew: true,
  );

  static const SubscriptionModel proPlan = SubscriptionModel(
    id: 'pro_plan',
    planName: 'Pro Plan',
    planType: SubscriptionPlans.pro,
    isActive: false,
    price: 19.99,
    currency: 'USD',
    billingCycle: BillingCycles.monthly,
    features: [
      'Everything in Premium',
      'Team collaboration',
      'API access',
      'Advanced reporting',
      'White-label options',
    ],
    autoRenew: true,
  );
}
