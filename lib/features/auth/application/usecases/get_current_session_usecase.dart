import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';

class GetCurrentSessionUseCase {
  const GetCurrentSessionUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthSession?> call() => _repository.getCurrentSession();
}
