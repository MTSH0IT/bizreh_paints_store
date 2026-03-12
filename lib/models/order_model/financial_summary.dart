class FinancialSummary {
  int? subTotal;
  int? totalDiscount;
  int? total;

  FinancialSummary({this.subTotal, this.totalDiscount, this.total});

  factory FinancialSummary.fromJson(Map<String, dynamic> json) {
    return FinancialSummary(
      subTotal: json['sub_total'] as int?,
      totalDiscount: json['total_discount'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'sub_total': subTotal,
    'total_discount': totalDiscount,
    'total': total,
  };
}
