class Brand {
  String? title;
  String? arTitle;

  Brand({this.title, this.arTitle});

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    title: json['title'] as String?,
    arTitle: json['ar_title'] as String?,
  );

  Map<String, dynamic> toJson() => {'title': title, 'ar_title': arTitle};
}
