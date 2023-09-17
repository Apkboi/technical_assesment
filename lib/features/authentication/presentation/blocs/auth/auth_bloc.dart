import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:technical_assesment/core/constants/storage_keys.dart';
import 'package:technical_assesment/core/extensions/dartz_extension.dart';
import 'package:technical_assesment/core/helpers/storage_helper.dart';
import 'package:technical_assesment/features/authentication/data/models/login_response.dart';
import 'package:technical_assesment/features/authentication/dormain/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
    });
    on<LoginEvent>(_mapLoginEventToState);
  }

  FutureOr<void> _mapLoginEventToState(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      var result = await authRepository.login(
          email: event.email, password: event.password);
      if (result.isLeft) {
        emit(AuthFailureState(result.asLeft().errorMessage));
      } else {
        StorageHelper.setString(StorageKeys.token, result.asRight().data.token);
        StorageHelper.setBoolean(StorageKeys.stayLoggedIn, true);

        emit(LoginSuccessState(result.asRight()));
      }
    } on Exception catch (e) {
      emit(AuthFailureState(e.toString()));
    }
  }
}
