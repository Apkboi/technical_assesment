import 'package:intl/intl.dart';

formatMoney(dynamic e, [String? symbol, int? fractionDigits]) {
  if (e == null) {
    return NumberFormat.currency(
            locale: 'en_US',
            symbol: symbol ?? '\$',
            decimalDigits: fractionDigits ?? 0)
        .format(0);
  }
  
  return NumberFormat.currency(
          locale: 'en_US',
          symbol: symbol ?? '\$',
          decimalDigits: fractionDigits ?? 0)
      .format(e is String ? double.parse(e) : e);
}
