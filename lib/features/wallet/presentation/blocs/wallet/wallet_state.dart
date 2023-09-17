part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  @override
  List<Object> get props => [];
}

class FetchWalletLoadingState extends WalletState {
  @override
  List<Object> get props => [];
}

class FetchWalletFailedState extends WalletState {
  final String error;

  const FetchWalletFailedState(this.error);

  @override
  List<Object> get props => [error.hashCode];
}

class FetchWalletSuccessState extends WalletState {
  final FetchWalletResponse fetchWalletResponse;

  const FetchWalletSuccessState(this.fetchWalletResponse);

  @override
  List<Object> get props => [fetchWalletResponse];
}

class FetchTransactionsSuccessState extends WalletState {
  final FetchTransactionsResponse response;

  const FetchTransactionsSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class FetchTransactionsFailedState extends WalletState {
  final String error;

  const FetchTransactionsFailedState(this.error);

  @override
  List<Object> get props => [];
}

class FetchTransactionsLoadingState extends WalletState {
  @override
  List<Object> get props => [];
}

class FetchTransactionByIdSuccessState extends WalletState {
  final FetchTransactionByIdResponse response;

  const FetchTransactionByIdSuccessState(this.response);

  @override
  List<Object> get props => [];
}

class FetchTransactionByIdFailedState extends WalletState {
  final String error;
  const FetchTransactionByIdFailedState(this.error);
  @override
  List<Object> get props => [];
}

class FetchTransactionByIdLoadingState extends WalletState {
  @override
  List<Object> get props => [];
}
