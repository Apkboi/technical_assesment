part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthFailureState extends AuthState {
  final String error;

  const AuthFailureState(this.error);

  @override
  List<Object> get props => [error];
}

class LoginSuccessState extends AuthState {
  final LoginResponse loginResponse;

  const LoginSuccessState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}
