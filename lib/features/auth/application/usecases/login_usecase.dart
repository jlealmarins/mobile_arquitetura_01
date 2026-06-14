import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';

/// Caso de uso de login.
///
/// Encapsula a regra de aplicacao "autenticar um usuario", isolando a
/// camada de apresentacao do contrato do repositorio. Em projetos maiores
/// poderia validar regras de dominio adicionais (politicas de senha,
/// rate limiting local, etc.).
class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession> call({
    required String username,
    required String password,
  }) {
    return _repository.login(username: username, password: password);
  }
}
