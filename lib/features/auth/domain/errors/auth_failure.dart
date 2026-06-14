/// Erros de dominio da feature de autenticacao.
///
/// Modelado como `sealed class` para que o `switch` exaustivo na camada de
/// apresentacao detecte ramos nao tratados em tempo de compilacao.
/// Implementa `Exception` para poder ser lancada e capturada pelo Riverpod
/// (`AsyncValue.error`) sem necessidade de tipo `Either`/`Result`.
sealed class AuthFailure implements Exception {
  const AuthFailure(this.message);

  final String message;

  @override
  String toString() => 'AuthFailure: $message';
}

/// Credenciais rejeitadas pelo backend (HTTP 400/401).
class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure()
      : super('Usuario ou senha invalidos.');
}

/// Falha de comunicacao com a API (offline, timeout, DNS, etc.).
class NetworkFailure extends AuthFailure {
  const NetworkFailure([String? detail])
      : super(detail ?? 'Falha de conexao. Verifique sua internet.');
}

/// Qualquer outra falha nao classificada (5xx, payload invalido, etc.).
class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure([String? detail])
      : super(detail ?? 'Nao foi possivel concluir a operacao.');
}
