import 'package:technical_assesment/core/helpers/enums.dart';

extension TransactionTypeExtension on TransactionType {
  String get caption => switch (this) {
        TransactionType.all => 'All',
        TransactionType.withdrawal => 'Transfer',
        TransactionType.deposit => 'Received',
      };
}
