import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../domain/errors/product_failure.dart';
import '../dtos/product_dto.dart';
import '../dtos/products_response_dto.dart';

class ProductsRemoteDataSource {
  ProductsRemoteDataSource({
    http.Client? client,
    Uri? baseEndpoint,
  })  : _client = client ?? http.Client(),
        _baseEndpoint =
            baseEndpoint ?? Uri.parse('https://dummyjson.com/products');

  final http.Client _client;
  final Uri _baseEndpoint;

  Future<List<ProductDto>> getAll() async {
    final response = await _safeGet(_baseEndpoint);

    if (response.statusCode != 200) {
      throw UnknownProductFailure(
        'Falha inesperada (HTTP ${response.statusCode}).',
      );
    }

    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ProductsResponseDto.fromJson(json).products;
    } on FormatException {
      throw const UnknownProductFailure('Resposta invalida do servidor.');
    }
  }

  Future<ProductDto> getById(int id) async {
    final uri = _baseEndpoint.replace(
      pathSegments: [..._baseEndpoint.pathSegments, '$id'],
    );
    final response = await _safeGet(uri);

    if (response.statusCode == 404) {
      throw const ProductNotFoundFailure();
    }

    if (response.statusCode != 200) {
      throw UnknownProductFailure(
        'Falha inesperada (HTTP ${response.statusCode}).',
      );
    }

    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ProductDto.fromJson(json);
    } on FormatException {
      throw const UnknownProductFailure('Resposta invalida do servidor.');
    }
  }

  Future<http.Response> _safeGet(Uri uri) async {
    try {
      return await _client.get(uri);
    } on SocketException catch (e) {
      throw ProductNetworkFailure(e.message);
    } on http.ClientException catch (e) {
      throw ProductNetworkFailure(e.message);
    } on TimeoutException {
      throw const ProductNetworkFailure('Tempo de conexao esgotado.');
    }
  }
}
