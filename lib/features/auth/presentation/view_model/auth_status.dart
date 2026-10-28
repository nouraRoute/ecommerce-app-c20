abstract class AuthState {}

class AuthInitialStatus extends AuthState {}

class LoginLoadingStatus extends AuthState {}

class LoginErrorStatus extends AuthState {
  final String errorMessage;

  LoginErrorStatus({required this.errorMessage});
}

class LoginSuccessStatus extends AuthState {}
