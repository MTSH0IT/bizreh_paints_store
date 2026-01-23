class Address {
  String? addressLine;
  String? note;
  double? longitude;
  double? latitude;
  String? cityName;

  Address({
    this.addressLine,
    this.note,
    this.longitude,
    this.latitude,
    this.cityName,
  });

  @override
  String toString() {
    return 'Address(addressLine: $addressLine, note: $note, longitude: $longitude, latitude: $latitude, cityName: $cityName)';
  }

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressLine: json['address_line'] as String?,
    note: json['note'] as String?,
    longitude: (json['longitude'] as num?)?.toDouble(),
    latitude: (json['latitude'] as num?)?.toDouble(),
    cityName: json['city_name'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'address_line': addressLine,
    'note': note,
    'longitude': longitude,
    'latitude': latitude,
    'city_name': cityName,
  };
}
