import '../../domain/entities/auth_session.dart';
import '../../domain/errors/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../storage/secure_session_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._sessionStorage);

  final AuthRemoteDataSource _remoteDataSource;
  final SecureSessionStorage _sessionStorage;

  @override
  Future<AuthSession> login({
    required String username,
    required String password,
  }) async {
    try {
      final dto = await _remoteDataSource.login(
        username: username,
        password: password,
      );
      await _sessionStorage.save(dto);
      return dto.toAuthSession();
    } on AuthFailure {
      rethrow;
    } catch (e) {
      throw UnknownAuthFailure(e.toString());
    }
  }

  @override
  Future<void> logout() => _sessionStorage.clear();

  @override
  Future<AuthSession?> getCurrentSession() async {
    try {
      final dto = await _sessionStorage.read();
      return dto?.toAuthSession();
    } catch (_) {
      await _sessionStorage.clear();
      return null;
    }
  }
}
