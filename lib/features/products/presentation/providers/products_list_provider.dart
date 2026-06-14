import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product.dart';
import 'products_providers.dart';

final productsListProvider = FutureProvider<List<Product>>((ref) {
  return ref.read(getProductsUseCaseProvider).call();
});
