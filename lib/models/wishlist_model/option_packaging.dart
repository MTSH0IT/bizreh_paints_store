import 'color.dart';
import 'packaging.dart';

class OptionPackaging {
  int? id;
  int? packagingId;
  int? pricePerUnit;
  int? stockQuantity;
  Color? color;
  Packaging? packaging;

  OptionPackaging({
    this.id,
    this.packagingId,
    this.pricePerUnit,
    this.stockQuantity,
    this.color,
    this.packaging,
  });

  @override
  String toString() {
    return 'OptionPackaging(id: $id, packagingId: $packagingId, pricePerUnit: $pricePerUnit, stockQuantity: $stockQuantity, color: $color, packaging: $packaging)';
  }

  factory OptionPackaging.fromJson(Map<String, dynamic> json) {
    return OptionPackaging(
      id: json['id'] as int?,
      packagingId: json['packaging_id'] as int?,
      pricePerUnit: json['price_per_unit'] as int?,
      stockQuantity: json['stock_quantity'] as int?,
      color: json['color'] == null
          ? null
          : Color.fromJson(json['color'] as Map<String, dynamic>),
      packaging: json['packaging'] == null
          ? null
          : Packaging.fromJson(json['packaging'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'packaging_id': packagingId,
    'price_per_unit': pricePerUnit,
    'stock_quantity': stockQuantity,
    'color': color?.toJson(),
    'packaging': packaging?.toJson(),
  };
}
