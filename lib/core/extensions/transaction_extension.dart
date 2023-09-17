import 'package:technical_assesment/core/helpers/enums.dart';
import 'package:technical_assesment/features/wallet/data/models/fetch_transactions_response.dart';
import 'package:technical_assesment/features/wallet/data/models/transaction_by_id_response.dart';

extension TransactiionExtension on Transaction {
  String get transactionTittle => switch (type) {
        "DEPOSIT" => 'Received from $source',
        "WITHDRAWAL" => 'Transfer to Bank',
        String() => '',
      };

  TransactionType get transactionType => switch (type) {
        "DEPOSIT" => TransactionType.deposit,
        "WITHDRAWAL" => TransactionType.withdrawal,
        String() => TransactionType.all,
      };
}
extension TransactionDataExtension on TransactionData {
  String get transactionTittle => switch (type) {
        "DEPOSIT" => 'Received from $source',
        "WITHDRAWAL" => 'Transfer to Bank',
        String() => '',
      };

  TransactionType get transactionType => switch (type) {
        "DEPOSIT" => TransactionType.deposit,
        "WITHDRAWAL" => TransactionType.withdrawal,
        String() => TransactionType.all,
      };
}
