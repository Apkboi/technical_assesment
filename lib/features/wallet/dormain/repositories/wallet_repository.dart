import 'package:either_dart/either.dart';
import 'package:technical_assesment/common/models/server_error_model.dart';
import 'package:technical_assesment/features/wallet/data/models/fetch_transactions_response.dart';
import 'package:technical_assesment/features/wallet/data/models/fetch_wallet_response.dart';
import 'package:technical_assesment/features/wallet/data/models/transaction_by_id_response.dart';

abstract class WalletRepository {
  Future<Either<ServerErrorModel, FetchWalletResponse>> getWallet();

  Future<Either<ServerErrorModel, FetchTransactionByIdResponse>> getTransactionById(String transactionId);

  Future<Either<ServerErrorModel, FetchTransactionsResponse>> getTransactions(String type);
}
