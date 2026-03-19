class OffersCartModel {
  int? id;
  String? name;
  String? arName;
  String? description;
  String? arDescription;
  String? price;
  int? quantity;
  int? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? itemsCount;

  OffersCartModel({
    this.id,
    this.name,
    this.arName,
    this.description,
    this.arDescription,
    this.price,
    this.quantity,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.itemsCount,
  });

  factory OffersCartModel.fromJson(Map<String, dynamic> json) =>
      OffersCartModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        arName: json['ar_name'] as String?,
        description: json['description'] as String?,
        arDescription: json['ar_description'] as String?,
        price: json['price']?.toString(),
        quantity: json['quantity'] as int?,
        isActive: json['is_active'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        itemsCount: json['items_count'] as int?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'ar_name': arName,
    'description': description,
    'ar_description': arDescription,
    'price': price,
    'quantity': quantity,
    'is_active': isActive,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt,
    'items_count': itemsCount,
  };
}
