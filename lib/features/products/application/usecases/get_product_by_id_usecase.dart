import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';

class GetProductByIdUseCase {
  const GetProductByIdUseCase(this._repository);

  final ProductsRepository _repository;

  Future<Product> call(int id) => _repository.getById(id);
}
