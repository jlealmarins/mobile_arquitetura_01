import '../entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getAll();

  Future<Product> getById(int id);
}
