class AddressModel {
  int? id;
  int? userId;
  int? cityId;
  String? nickname;
  String? addressLine;
  double? latitude;
  double? longitude;
  int? isActive;
  String? note;
  DateTime? createdAt;
  String? cityName;
  String? arCityName;

  AddressModel({
    this.id,
    this.userId,
    this.cityId,
    this.nickname,
    this.addressLine,
    this.latitude,
    this.longitude,
    this.isActive,
    this.note,
    this.createdAt,
    this.cityName,
    this.arCityName,
  });

  @override
  String toString() {
    return 'AddressModel(id: $id, userId: $userId, cityId: $cityId,nickname:$nickname, addressLine: $addressLine, latitude: $latitude, longitude: $longitude, isActive: $isActive, note: $note, createdAt: $createdAt, cityName: $cityName, arCityName: $arCityName)';
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json['id'] as int?,
    userId: json['user_id'] as int?,
    cityId: json['city_id'] as int?,
    nickname: json['nickname'] as String?,
    addressLine: json['address_line'] as String?,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    isActive: json['is_active'] as int?,
    note: json['note'] as String?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    cityName: json['city_name'] as String?,
    arCityName: json['ar_city_name'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'city_id': cityId,
    'address_line': addressLine,
    'latitude': latitude,
    'longitude': longitude,
    'is_active': isActive,
    'note': note,
    'created_at': createdAt?.toIso8601String(),
    'city_name': cityName,
    'ar_city_name': arCityName,
  };
}
