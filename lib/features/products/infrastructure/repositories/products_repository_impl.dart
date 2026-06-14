import '../../domain/entities/product.dart';
import '../../domain/errors/product_failure.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_remote_datasource.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl(this._remoteDataSource);

  final ProductsRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getAll() async {
    try {
      final dtos = await _remoteDataSource.getAll();
      return dtos.map((dto) => dto.toProduct()).toList(growable: false);
    } on ProductFailure {
      rethrow;
    } catch (e) {
      throw UnknownProductFailure(e.toString());
    }
  }

  @override
  Future<Product> getById(int id) async {
    try {
      final dto = await _remoteDataSource.getById(id);
      return dto.toProduct();
    } on ProductFailure {
      rethrow;
    } catch (e) {
      throw UnknownProductFailure(e.toString());
    }
  }
}
