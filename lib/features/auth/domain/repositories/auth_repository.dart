import '../entities/auth_session.dart';

/// Contrato de acesso a dados de autenticacao.
///
/// Definido na camada de dominio para que casos de uso dependam apenas
/// desta abstracao. A implementacao concreta vive em
/// `infrastructure/repositories/auth_repository_impl.dart` e orquestra
/// datasource remoto + storage local.
///
/// Quaisquer falhas devem ser propagadas como subtipos de [AuthFailure].
abstract class AuthRepository {
  /// Autentica o usuario, persiste a sessao e retorna o resultado.
  Future<AuthSession> login({
    required String username,
    required String password,
  });

  /// Limpa a sessao persistida.
  Future<void> logout();

  /// Recupera a sessao previamente salva (ou `null` se nao houver).
  Future<AuthSession?> getCurrentSession();
}
