import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../application/usecases/get_current_session_usecase.dart';
import '../../application/usecases/login_usecase.dart';
import '../../application/usecases/logout_usecase.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../infrastructure/datasources/auth_remote_datasource.dart';
import '../../infrastructure/repositories/auth_repository_impl.dart';
import '../../infrastructure/storage/secure_session_storage.dart';

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(client: ref.read(httpClientProvider));
});

final secureSessionStorageProvider = Provider<SecureSessionStorage>((ref) {
  return SecureSessionStorage(storage: ref.read(flutterSecureStorageProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
    ref.read(secureSessionStorageProvider),
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref.read(authRepositoryProvider));
});

final getCurrentSessionUseCaseProvider = Provider<GetCurrentSessionUseCase>((ref) {
  return GetCurrentSessionUseCase(ref.read(authRepositoryProvider));
});
