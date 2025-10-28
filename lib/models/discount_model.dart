class DiscountModel {
  final String title;
  final String subtitle;
  final String type;
  final double value;

  DiscountModel({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.value,
  });

  Map<String, dynamic> toJSON() {
    return {'title': title, 'subtitle': subtitle, 'type': type, 'value': value};
  }

  factory DiscountModel.fromJSON(Map<String, dynamic> json) {
    return DiscountModel(
      title: json['title'],
      subtitle: json['subtitle'],
      type: json['type'],
      value: json['value'],
    );
  }
}

final List<DiscountModel> demoDiscount = [
  DiscountModel(
    title: 'Buy 100 points get 10% off',
    subtitle: 'Get 10% off your total purchase',
    type: 'percentage',
    value: 0.10,
  ),
  DiscountModel(
    title: 'Buy 150 points get \$20 off',
    subtitle: 'Get \$20 off your total purchase',
    type: 'fixed',
    value: 20,
  ),
];
