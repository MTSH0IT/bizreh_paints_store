class BannerModel {
  final String image;
  final String title;
  final String subtitle;
  final String description;

  BannerModel({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'subtitle': subtitle,
      'description': description,
    };
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
    );
  }
}

final List<BannerModel> demoBanners = [
  BannerModel(
    image:
        'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
    title: 'Vibrant Colors',
    subtitle: '20% off on all interior paints',
    description:
        'Transform your home with our premium collection of vibrant interior paints. Limited time offer!',
  ),
  BannerModel(
    image:
        'https://images.unsplash.com/photo-1562259949-e8e7689d7828?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80',
    title: 'Premium Quality',
    subtitle: 'Professional grade paints',
    description:
        'Experience the difference with our professional-grade paint collection. Perfect coverage guaranteed.',
  ),
  BannerModel(
    image:
        'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80',
    title: 'Eco-Friendly',
    subtitle: 'Low VOC & sustainable options',
    description:
        'Choose from our eco-friendly paint range. Safe for your family and the environment.',
  ),
  BannerModel(
    image:
        'https://images.unsplash.com/photo-1513467535987-fd81bc7d62f8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1170&q=80',
    title: 'New Arrivals',
    subtitle: 'Latest color trends 2024',
    description:
        'Discover the latest color trends and new arrivals. Stay ahead with modern paint solutions.',
  ),
];
