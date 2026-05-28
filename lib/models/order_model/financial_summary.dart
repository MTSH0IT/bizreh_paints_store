class FinancialSummary {
  double? subTotal;
  double? totalDiscount;
  double? total;
  int? totalPoints;

  FinancialSummary({this.subTotal, this.totalDiscount, this.total, this.totalPoints});

  factory FinancialSummary.fromJson(Map<String, dynamic> json) {
    return FinancialSummary(
      subTotal: (json['sub_total'] as num?)?.toDouble(),
      totalDiscount: (json['total_discount'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      totalPoints: (json['total_points'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
    'sub_total': subTotal,
    'total_discount': totalDiscount,
    'total': total,
    'total_points': totalPoints,
  };
}

