import 'product_dto.dart';

class ProductsResponseDto {
  const ProductsResponseDto({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  final List<ProductDto> products;
  final int total;
  final int skip;
  final int limit;

  factory ProductsResponseDto.fromJson(Map<String, dynamic> json) {
    final rawProducts = json['products'];
    final products = rawProducts is List
        ? rawProducts
            .whereType<Map<String, dynamic>>()
            .map(ProductDto.fromJson)
            .toList(growable: false)
        : const <ProductDto>[];

    return ProductsResponseDto(
      products: products,
      total: (json['total'] as int?) ?? products.length,
      skip: (json['skip'] as int?) ?? 0,
      limit: (json['limit'] as int?) ?? products.length,
    );
  }
}
