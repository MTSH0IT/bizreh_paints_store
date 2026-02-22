class FinancialSummary {
  num? subTotal;
  num? totalDiscount;
  num? total;

  FinancialSummary({this.subTotal, this.totalDiscount, this.total});

  factory FinancialSummary.fromJson(Map<String, dynamic> json) {
    return FinancialSummary(
      subTotal: json['sub_total'] as num?,
      totalDiscount: json['total_discount'] as num?,
      total: json['total'] as num?,
    );
  }

  Map<String, dynamic> toJson() => {
    'sub_total': subTotal,
    'total_discount': totalDiscount,
    'total': total,
  };
}
