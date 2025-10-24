class AddressModel {
  final String id;
  final String nickname;
  final String city;
  final String address;
  final String notes;
  final String latitude;
  final String longitude;

  const AddressModel({
    required this.id,
    required this.nickname,
    required this.city,
    required this.address,
    required this.notes,
    required this.latitude,
    required this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      nickname: json['nickname'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      notes: json['notes'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'city': city,
      'address': address,
      'notes': notes,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

final List<AddressModel> demoAddressesModel = [
  const AddressModel(
    id: '1',
    nickname: 'Home',
    city: 'damascus',
    address: '123 Main Street, New York, NY 10001',
    notes: 'Please leave the package at the front door.',
    latitude: '33.5186',
    longitude: '36.2819',
  ),
  const AddressModel(
    id: '2',
    nickname: 'Work',
    city: 'homs',
    address: 'al-manshiyeh, hama street',
    notes: 'Deliver to reception on the 5th floor.',
    latitude: '33.5186',
    longitude: '36.2819',
  ),
  const AddressModel(
    id: '3',
    nickname: 'Parents\' House',
    city: 'hama',
    address: '789 Oak Lane, Chicago, IL 60611',
    notes: 'N/A',
    latitude: '33.5186',
    longitude: '36.2819',
  ),
];
