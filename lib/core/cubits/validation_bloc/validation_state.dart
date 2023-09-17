part of 'validation_cubit.dart';

abstract class ValidationState extends Equatable {
  const ValidationState();
}

class ValidationInitial extends ValidationState {
  @override
  List<Object> get props => [];
}




class ValidationLoading extends ValidationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ValidationSuccess extends ValidationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ValidationFailure extends ValidationState {
  final String error;

  ValidationFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
