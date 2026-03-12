class AvailableGiftsModel {
  int? id;
  int? points;
  String? title;
  String? arTitle;
  String? image;
  int? isActive;
  DateTime? createdAt;
  int? userRedemptions;
  bool? userCanRedeem;

  AvailableGiftsModel({
    this.id,
    this.points,
    this.title,
    this.arTitle,
    this.image,
    this.isActive,
    this.createdAt,
    this.userRedemptions,
    this.userCanRedeem,
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
      userRedemptions: json['user_redemptions'] as int?,
      userCanRedeem: json['user_can_redeem'] as bool?,
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
    'user_redemptions': userRedemptions,
    'user_can_redeem': userCanRedeem,
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
