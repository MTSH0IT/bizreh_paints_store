class Summary {
  double? totalRegularPayments;
  double? totalBonus;
  double? totalTransactions;

  Summary({this.totalRegularPayments, this.totalBonus, this.totalTransactions});

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalRegularPayments: (json['total_regular_payments'] as num?)?.toDouble(),
    totalBonus: (json['total_bonus'] as num?)?.toDouble(),
    totalTransactions: (json['total_transactions'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'total_regular_payments': totalRegularPayments,
    'total_bonus': totalBonus,
    'total_transactions': totalTransactions,
  };
}
