part of 'navigation_cubit.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
}

class NavigationInitial extends NavigationState {
  @override
  List<Object> get props => [];
}

class OpenDrawerState extends NavigationState {
  @override
  List<Object?> get props => [];

  @override
  bool operator ==(Object other) {
    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

class SwitchDrawerState extends NavigationState {
  int index;

  @override
  List<Object?> get props => [index];

  SwitchDrawerState(this.index);
}

class CloseDrawerState extends NavigationState {
  @override
  List<Object?> get props => [];
}
