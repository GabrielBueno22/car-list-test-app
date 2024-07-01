import 'package:intl/intl.dart';

String formatDoubleToBRL(double value) {
  final NumberFormat formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
  );
  return formatter.format(value);
}
