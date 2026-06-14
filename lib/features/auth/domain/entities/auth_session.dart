import 'auth_user.dart';

/// Value object que representa uma sessao autenticada ativa.
///
/// Agrupa o usuario logado e os tokens emitidos pela DummyJSON.
/// Eh imutavel: qualquer mudanca produz uma nova instancia.
class AuthSession {
  const AuthSession({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  final AuthUser user;
  final String accessToken;
  final String refreshToken;
}
