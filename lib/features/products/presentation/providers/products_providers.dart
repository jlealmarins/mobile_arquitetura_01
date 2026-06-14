import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/network_providers.dart';
import '../../application/usecases/get_product_by_id_usecase.dart';
import '../../application/usecases/get_products_usecase.dart';
import '../../domain/repositories/products_repository.dart';
import '../../infrastructure/datasources/products_remote_datasource.dart';
import '../../infrastructure/repositories/products_repository_impl.dart';

final productsRemoteDataSourceProvider = Provider<ProductsRemoteDataSource>((ref) {
  return ProductsRemoteDataSource(client: ref.read(httpClientProvider));
});

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return ProductsRepositoryImpl(ref.read(productsRemoteDataSourceProvider));
});

final getProductsUseCaseProvider = Provider<GetProductsUseCase>((ref) {
  return GetProductsUseCase(ref.read(productsRepositoryProvider));
});

final getProductByIdUseCaseProvider = Provider<GetProductByIdUseCase>((ref) {
  return GetProductByIdUseCase(ref.read(productsRepositoryProvider));
});
