class VersionInfo {
  final String version;
  final String androidLink;
  final String iOSLink;

  VersionInfo({
    required this.version,
    required this.androidLink,
    required this.iOSLink,
  });

  factory VersionInfo.fromJson(Map<String, dynamic> json) {
    return VersionInfo(
      version: json['version'] ?? '',
      androidLink: json['android_link'] ?? '',
      iOSLink: json['iOS_link'] ?? '',
    );
  }
}
