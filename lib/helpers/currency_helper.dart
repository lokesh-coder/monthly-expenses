import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

class CurrencyHelper {
  static String getFormattedCurrency(
    value, [
    locale = 'ml',
    currencyCode = 'INR',
  ]) {
    var formatterObject = new NumberFormat();
    String symbol = formatterObject.simpleCurrencySymbol(currencyCode);
    int decimals = value.toString().contains('.') ? 2 : 0;

    return NumberFormat.currency(
      locale: locale,
      decimalDigits: decimals,
      name: ' $symbol ',
    ).format(value);
  }

  static get separator {
    return numberFormatSymbols['ml']?.DECIMAL_SEP ?? '.';
  }
}
