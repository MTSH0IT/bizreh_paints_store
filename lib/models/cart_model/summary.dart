class Summary {
  num? subtotal;
  num? discountAmount;
  num? deliveryFee;
  num? totalAmount;
  num? totalItems;
  num? itemsCount;

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
    subtotal: json['subtotal'] as num?,
    discountAmount: json['discount_amount'] as num?,
    deliveryFee: json['delivery_fee'] as num?,
    totalAmount: json['total_amount'] as num?,
    totalItems: json['total_items'] as num?,
    itemsCount: json['items_count'] as num?,
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
