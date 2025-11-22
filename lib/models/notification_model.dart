class NotificationModel {
  int? id;
  String? title;
  String? message;
  int? userId;
  int? isRead;
  DateTime? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.message,
    this.userId,
    this.isRead,
    this.createdAt,
  });

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, message: $message, userId: $userId, isRead: $isRead, createdAt: $createdAt)';
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      userId: json['user_id'] as int?,
      isRead: json['is_read'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
    'user_id': userId,
    'is_read': isRead,
    'created_at': createdAt?.toIso8601String(),
  };
}
