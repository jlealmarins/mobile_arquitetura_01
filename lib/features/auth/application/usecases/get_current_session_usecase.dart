import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';

/// Caso de uso de recuperacao da sessao persistida.
///
/// Executado no boot da aplicacao: se houver sessao, o usuario eh
/// direcionado para a area autenticada; caso contrario, para a tela de
/// login.
class GetCurrentSessionUseCase {
  const GetCurrentSessionUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession?> call() => _repository.getCurrentSession();
}
