import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../dtos/login_response_dto.dart';

class SecureSessionStorage {
  SecureSessionStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _sessionKey = 'auth_session_v1';

  final FlutterSecureStorage _storage;

  Future<void> save(LoginResponseDto session) async {
    await _storage.write(
      key: _sessionKey,
      value: jsonEncode(session.toJson()),
    );
  }

  Future<LoginResponseDto?> read() async {
    final raw = await _storage.read(key: _sessionKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return LoginResponseDto.fromJson(json);
  }

  Future<void> clear() => _storage.delete(key: _sessionKey);
}
