sealed class AuthFailure implements Exception {
  const AuthFailure(this.message);

  final String message;

  @override
  String toString() => 'AuthFailure: $message';
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure()
      : super('Usuario ou senha invalidos.');
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure([String? detail])
      : super(detail ?? 'Falha de conexao. Verifique sua internet.');
}

class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure([String? detail])
      : super(detail ?? 'Nao foi possivel concluir a operacao.');
}
