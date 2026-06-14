/// Entidade de dominio que representa o usuario autenticado.
///
/// Vive na camada de dominio: nao depende de nenhum framework, biblioteca
/// HTTP ou mecanismo de persistencia. Eh construida a partir do DTO da
/// resposta da DummyJSON na camada de infraestrutura.
class AuthUser {
  const AuthUser({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.image,
  });

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String? image;

  String get displayName {
    final full = '$firstName $lastName'.trim();
    return full.isEmpty ? username : full;
  }
}
