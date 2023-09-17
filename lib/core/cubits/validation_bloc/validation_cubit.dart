import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'validation_state.dart';

class TextFieldValidationCubit extends Cubit<ValidationState> {
  GlobalKey<FormFieldState> key = GlobalKey<FormFieldState>();
  bool formValidated = false;

  TextFieldValidationCubit() : super(ValidationInitial());

  void validate() async {
    emit(ValidationLoading());
    // Simulating a validation process,
    await Future.delayed(const Duration(milliseconds: 400));
    bool isValidated = key.currentState?.validate() ?? false;
    if (isValidated) {
      emit(ValidationSuccess());
    } else {
      emit(ValidationFailure('Validation failed'));
    }
  }
}
