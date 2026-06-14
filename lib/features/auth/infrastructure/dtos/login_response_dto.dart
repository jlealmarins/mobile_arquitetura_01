import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_user.dart';

/// Espelha a estrutura do JSON retornado por `POST /auth/login` da DummyJSON.
///
/// Vive na camada de infraestrutura e nao deve vazar para domain/application.
/// A conversao para a entidade [AuthSession] eh feita em [toAuthSession],
/// isolando o restante do app das particularidades do payload externo.
class LoginResponseDto {
  const LoginResponseDto({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.accessToken,
    required this.refreshToken,
    this.image,
  });

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String? image;
  final String accessToken;
  final String refreshToken;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      image: json['image'] as String?,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'image': image,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  AuthSession toAuthSession() => AuthSession(
        user: AuthUser(
          id: id,
          username: username,
          email: email,
          firstName: firstName,
          lastName: lastName,
          image: image,
        ),
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
}
