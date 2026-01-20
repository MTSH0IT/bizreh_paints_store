class Summary {
  double? subtotal;
  double? discountAmount;
  int? deliveryFee;
  double? totalAmount;
  int? totalItems;
  int? itemsCount;

  Summary({
    this.subtotal,
    this.discountAmount,
    this.deliveryFee,
    this.totalAmount,
    this.totalItems,
    this.itemsCount,
  });

  @override
  String toString() {
    return 'Summary(subtotal: $subtotal, discountAmount: $discountAmount, deliveryFee: $deliveryFee, totalAmount: $totalAmount, totalItems: $totalItems, itemsCount: $itemsCount)';
  }

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    subtotal: (json['subtotal'] as num?)?.toDouble(),
    discountAmount: (json['discount_amount'] as num?)?.toDouble(),
    deliveryFee: json['delivery_fee'] as int?,
    totalAmount: (json['total_amount'] as num?)?.toDouble(),
    totalItems: json['total_items'] as int?,
    itemsCount: json['items_count'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'subtotal': subtotal,
    'discount_amount': discountAmount,
    'delivery_fee': deliveryFee,
    'total_amount': totalAmount,
    'total_items': totalItems,
    'items_count': itemsCount,
  };
}
