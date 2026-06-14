import '../../domain/repositories/auth_repository.dart';

/// Caso de uso de logout.
///
/// Mantido como classe separada para preservar a simetria das operacoes
/// de aplicacao e facilitar substituicao em testes.
class LogoutUseCase {
  const LogoutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}
