sealed class ProductFailure implements Exception {
  const ProductFailure(this.message);

  final String message;

  @override
  String toString() => 'ProductFailure: $message';
}

class ProductNotFoundFailure extends ProductFailure {
  const ProductNotFoundFailure()
      : super('Produto nao encontrado.');
}

class ProductNetworkFailure extends ProductFailure {
  const ProductNetworkFailure([String? detail])
      : super(detail ?? 'Falha de conexao. Verifique sua internet.');
}

class UnknownProductFailure extends ProductFailure {
  const UnknownProductFailure([String? detail])
      : super(detail ?? 'Nao foi possivel carregar os produtos.');
}
