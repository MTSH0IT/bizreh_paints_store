class AvailableGiftsModel {
  int? id;
  int? points;
  String? title;
  String? arTitle;
  String? image;
  int? isActive;
  DateTime? createdAt;
  int? totalRedemptions;
  String? userRedemptions;
  bool? userCanRedeem;
  bool? isAvailable;

  AvailableGiftsModel({
    this.id,
    this.points,
    this.title,
    this.arTitle,
    this.image,
    this.isActive,
    this.createdAt,
    this.totalRedemptions,
    this.userRedemptions,
    this.userCanRedeem,
    this.isAvailable,
  });

  factory AvailableGiftsModel.fromJson(Map<String, dynamic> json) {
    return AvailableGiftsModel(
      id: json['id'] as int?,
      points: json['points'] as int?,
      title: json['title'] as String?,
      arTitle: json['ar_title'] as String?,
      image: json['image'] as String?,
      isActive: json['is_active'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      totalRedemptions: json['total_redemptions'] as int?,
      userRedemptions: json['user_redemptions'] as String?,
      userCanRedeem: json['user_can_redeem'] as bool?,
      isAvailable: json['is_available'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'points': points,
    'title': title,
    'ar_title': arTitle,
    'image': image,
    'is_active': isActive,
    'created_at': createdAt?.toIso8601String(),
    'total_redemptions': totalRedemptions,
    'user_redemptions': userRedemptions,
    'user_can_redeem': userCanRedeem,
    'is_available': isAvailable,
  };
}

class AvailableGiftsResponse {
  int? availablePoints;
  List<AvailableGiftsModel> gifts;

  AvailableGiftsResponse({this.availablePoints, this.gifts = const []});

  factory AvailableGiftsResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['gifts'] as List?) ?? [];
    return AvailableGiftsResponse(
      availablePoints: json['available_points'] as int?,
      gifts: list
          .map((e) => AvailableGiftsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
