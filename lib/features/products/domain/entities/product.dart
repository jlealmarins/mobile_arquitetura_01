class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.images = const [],
  });

  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final String? brand;
  final String? category;
  final List<String> images;
}
