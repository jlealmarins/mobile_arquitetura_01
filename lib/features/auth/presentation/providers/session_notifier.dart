import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/auth_session.dart';
import 'auth_providers.dart';

class SessionNotifier extends AsyncNotifier<AuthSession?> {
  @override
  Future<AuthSession?> build() {
    return ref.read(getCurrentSessionUseCaseProvider).call();
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() {
      return ref.read(loginUseCaseProvider).call(
            username: username,
            password: password,
          );
    });
  }

  Future<void> logout() async {
    await ref.read(logoutUseCaseProvider).call();
    state = const AsyncValue.data(null);
  }
}

final sessionNotifierProvider =
    AsyncNotifierProvider<SessionNotifier, AuthSession?>(SessionNotifier.new);
