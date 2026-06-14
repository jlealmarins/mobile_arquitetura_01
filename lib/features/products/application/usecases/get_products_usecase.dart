import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';

class GetProductsUseCase {
  const GetProductsUseCase(this._repository);

  final ProductsRepository _repository;

  Future<List<Product>> call() => _repository.getAll();
}
