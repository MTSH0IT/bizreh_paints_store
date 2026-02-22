import 'color.dart';

class Packaging {
  int? id;
  String? title;
  String? arTitle;
  num? pricePerUnit;
  int? stockQuantity;
  Color? color;

  Packaging({
    this.id,
    this.title,
    this.arTitle,
    this.pricePerUnit,
    this.stockQuantity,
    this.color,
  });

  @override
  String toString() {
    return 'Packaging(id: $id, title: $title, arTitle: $arTitle, pricePerUnit: $pricePerUnit, stockQuantity: $stockQuantity, color: $color)';
  }

  factory Packaging.fromJson(Map<String, dynamic> json) => Packaging(
    id: json['id'] as int?,
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
    pricePerUnit: json['price_per_unit'] as num?,
    stockQuantity: json['stock_quantity'] as int?,
    color: json['color'] == null
        ? null
        : Color.fromJson(json['color'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'ar_title': arTitle,
    'price_per_unit': pricePerUnit,
    'stock_quantity': stockQuantity,
    'color': color?.toJson(),
  };
}
