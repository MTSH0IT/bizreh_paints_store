class UserGiftsModel {
  int? id;
  int? userId;
  int? giftId;
  String? status;
  DateTime? createdAt;
  String? giftTitle;
  String? giftArTitle;
  int? giftPoints;
  String? giftImage;

  UserGiftsModel({
    this.id,
    this.userId,
    this.giftId,
    this.status,
    this.createdAt,
    this.giftTitle,
    this.giftArTitle,
    this.giftPoints,
    this.giftImage,
  });

  @override
  String toString() {
    return 'UserGiftsModel(id: $id, userId: $userId, giftId: $giftId, status: $status, createdAt: $createdAt, giftTitle: $giftTitle, giftArTitle: $giftArTitle, giftPoints: $giftPoints, giftImage: $giftImage)';
  }

  factory UserGiftsModel.fromJson(Map<String, dynamic> json) {
    return UserGiftsModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      giftId: json['gift_id'] as int?,
      status: json['status'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      giftTitle: json['gift_title'] as String?,
      giftArTitle: json['gift_ar_title'] as String?,
      giftPoints: json['gift_points'] as int?,
      giftImage: json['gift_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'gift_id': giftId,
    'status': status,
    'created_at': createdAt?.toIso8601String(),
    'gift_title': giftTitle,
    'gift_ar_title': giftArTitle,
    'gift_points': giftPoints,
    'gift_image': giftImage,
  };
}
