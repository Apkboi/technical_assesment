part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class FetchWalletsEvent extends WalletEvent {
  @override
  List<Object?> get props => [];
}

class FetchTransactionsEvent extends WalletEvent {
 final TransactionType? transactionType;

  const FetchTransactionsEvent({this.transactionType});

  @override
  List<Object?> get props => [];
}

class FetchTransactionsByIdEvent extends WalletEvent {
  final String uid;

  const FetchTransactionsByIdEvent(this.uid);

  @override
  List<Object?> get props => [uid];
}
