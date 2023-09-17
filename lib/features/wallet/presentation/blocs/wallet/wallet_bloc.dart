import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_assesment/core/extensions/dartz_extension.dart';
import 'package:technical_assesment/core/helpers/enums.dart';
import 'package:technical_assesment/features/wallet/data/models/fetch_transactions_response.dart';
import 'package:technical_assesment/features/wallet/data/models/fetch_wallet_response.dart';
import 'package:technical_assesment/features/wallet/data/models/transaction_by_id_response.dart';
import 'package:technical_assesment/features/wallet/dormain/repositories/wallet_repository.dart';

part 'wallet_event.dart';

part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;
  UserWallet? userWallet;

  WalletBloc(this.walletRepository) : super(WalletInitial()) {
    on<WalletEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchWalletsEvent>(_mapFetchWalletEventToState);
    on<FetchTransactionsEvent>(_mapFetchTransactionsEventToState);
    on<FetchTransactionsByIdEvent>(_mapFetchTransactionsByIdEventToState);
  }

  FutureOr<void> _mapFetchWalletEventToState(
      FetchWalletsEvent event, Emitter<WalletState> emit) async {
    emit(FetchWalletLoadingState());

    try {
      var result = await walletRepository.getWallet();
      if (result.isLeft) {
        emit(FetchWalletFailedState(result.asLeft().errorMessage));
      } else {
        emit(FetchWalletSuccessState(result.asRight()));
        userWallet = result.asRight().userWallet;
      }
    } on Exception catch (e) {
      emit(FetchWalletFailedState(e.toString()));
    }
  }

  FutureOr<void> _mapFetchTransactionsEventToState(
      FetchTransactionsEvent event, Emitter<WalletState> emit) async {
    emit(FetchTransactionsLoadingState());

    var type = event.transactionType == TransactionType.all
        ? null
        : event.transactionType;

    try {
      var result = await walletRepository
          .getTransactions(type?.name.toUpperCase() ?? '');
      if (result.isLeft) {
        emit(FetchTransactionsFailedState(result.asLeft().errorMessage));
      } else {
        emit(FetchTransactionsSuccessState(result.asRight()));
      }
    } on Exception catch (e) {
      emit(FetchTransactionsFailedState(e.toString()));
    }
  }

  FutureOr<void> _mapFetchTransactionsByIdEventToState(
      FetchTransactionsByIdEvent event, Emitter<WalletState> emit) async {
    emit(FetchTransactionByIdLoadingState());

    try {
      var result = await walletRepository.getTransactionById(event.uid);
      if (result.isLeft) {
        emit(FetchTransactionByIdFailedState(result.asLeft().errorMessage));
      } else {
        emit(FetchTransactionByIdSuccessState(result.asRight()));
      }
    } on Exception catch (e) {
      emit(FetchTransactionByIdFailedState(e.toString()));
    }
  }
}
