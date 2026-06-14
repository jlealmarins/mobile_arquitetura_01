import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product.dart';
import 'products_providers.dart';

final productDetailsProvider = FutureProvider.family<Product, int>((ref, id) {
  return ref.read(getProductByIdUseCaseProvider).call(id);
});
