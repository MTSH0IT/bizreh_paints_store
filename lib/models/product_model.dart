class ProductModel {
  final String image;
  final String title;
  final String subTitle;
  final String description;
  final double price;

  ProductModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'subTitle': subTitle,
      'description': description,
      'price': price,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      image: json['image'] as String,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }
}

final List<ProductModel> demoProducts = [
  ProductModel(
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0EicNy1W3l04-ZEW1Tnp1TUN6FlX6SJ77Zg&s",
    title: "Eco-Friendly White",
    subTitle: "Low VOC, Matte",
    description:
        "Premium eco-friendly white paint with low VOC emissions, perfect for interior walls. Provides excellent coverage and a smooth matte finish.",
    price: 34.99,
  ),
  ProductModel(
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXh0jbwHf8ilhZiuSgraDthUCCn6kke6Lwgw&s",
    title: "Ocean Blue",
    subTitle: "Exterior, Satin",
    description:
        "Beautiful ocean blue exterior paint with satin finish. Weather-resistant and durable for outdoor applications.",
    price: 42.50,
  ),
  ProductModel(
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0EicNy1W3l04-ZEW1Tnp1TUN6FlX6SJ77Zg&s",
    title: "Sunset Orange",
    subTitle: "Interior, Eggshell",
    description:
        "Vibrant sunset orange with eggshell finish. Adds warmth and energy to any interior space with easy maintenance.",
    price: 38.00,
  ),
  ProductModel(
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0EicNy1W3l04-ZEW1Tnp1TUN6FlX6SJ77Zg&s",
    title: "Forest Green",
    subTitle: "Exterior, Semi-Gloss",
    description:
        "Rich forest green with semi-gloss finish. Ideal for exterior doors, trim, and accent walls with superior durability.",
    price: 45.99,
  ),
  ProductModel(
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0EicNy1W3l04-ZEW1Tnp1TUN6FlX6SJ77Zg&s",
    title: "Classic Gray",
    subTitle: "Interior, Matte",
    description:
        "Timeless classic gray with matte finish. Perfect for modern interiors and complements any decor style.",
    price: 36.50,
  ),
  ProductModel(
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0EicNy1W3l04-ZEW1Tnp1TUN6FlX6SJ77Zg&s",
    title: "Royal Purple",
    subTitle: "Interior, Satin",
    description:
        "Luxurious royal purple with satin finish. Creates a bold statement in bedrooms and accent walls.",
    price: 39.99,
  ),
];
