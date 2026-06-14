import '../../domain/entities/product.dart';

class ProductDto {
  const ProductDto({
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

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    final rawImages = json['images'];
    final images = rawImages is List
        ? rawImages.whereType<String>().toList(growable: false)
        : const <String>[];

    return ProductDto(
      id: json['id'] as int,
      title: json['title'] as String,
      description: (json['description'] as String?) ?? '',
      price: (json['price'] as num).toDouble(),
      thumbnail: (json['thumbnail'] as String?) ?? '',
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      stock: json['stock'] as int?,
      brand: json['brand'] as String?,
      category: json['category'] as String?,
      images: images,
    );
  }

  Product toProduct() => Product(
        id: id,
        title: title,
        description: description,
        price: price,
        thumbnail: thumbnail,
        discountPercentage: discountPercentage,
        rating: rating,
        stock: stock,
        brand: brand,
        category: category,
        images: images,
      );
}
