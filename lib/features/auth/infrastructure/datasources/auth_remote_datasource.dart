import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../domain/errors/auth_failure.dart';
import '../dtos/login_response_dto.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    http.Client? client,
    Uri? loginEndpoint,
  })  : _client = client ?? http.Client(),
        _loginEndpoint =
            loginEndpoint ?? Uri.parse('https://dummyjson.com/auth/login');

  final http.Client _client;
  final Uri _loginEndpoint;

  Future<LoginResponseDto> login({
    required String username,
    required String password,
  }) async {
    final http.Response response;

    try {
      response = await _client.post(
        _loginEndpoint,
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );
    } on SocketException catch (e) {
      throw NetworkFailure(e.message);
    } on http.ClientException catch (e) {
      throw NetworkFailure(e.message);
    } on TimeoutException {
      throw const NetworkFailure('Tempo de conexao esgotado.');
    }

    if (response.statusCode == 200) {
      try {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return LoginResponseDto.fromJson(json);
      } on FormatException {
        throw const UnknownAuthFailure('Resposta invalida do servidor.');
      }
    }

    if (response.statusCode == 400 || response.statusCode == 401) {
      throw const InvalidCredentialsFailure();
    }

    throw UnknownAuthFailure(
      'Falha inesperada (HTTP ${response.statusCode}).',
    );
  }
}
