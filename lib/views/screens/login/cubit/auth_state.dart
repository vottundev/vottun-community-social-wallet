part of 'auth_cubit.dart';

enum AuthStatus { initial, logged, notLogged }

class AuthState {
  final AuthStatus status;

  bool? hasAccessTokenExpired;

  AuthState({
    this.status = AuthStatus.initial,
    this.hasAccessTokenExpired,
  });

  AuthState copyWith({AuthStatus? status, bool? hasAccessTokenExpired}) {
    return AuthState(
        status: status ?? this.status,
        hasAccessTokenExpired:
            hasAccessTokenExpired ?? this.hasAccessTokenExpired);
  }
}
