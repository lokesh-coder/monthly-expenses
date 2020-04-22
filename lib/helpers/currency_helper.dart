import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;
import 'package:monex/data/local/object/files/currencies.dart';
import 'package:monex/models/currency.dart';

class CurrencyHelper {
  static List<Currency> cachedCurrencies = [];
  static String getFormattedCurrency(num value, String currencyTag) {
    if (currencyTag == '0=0') return value.toString();
    var currency = getCurrency(currencyTag);
    int decimals = value.toString().contains('.') ? 2 : 0;

    return NumberFormat.currency(
      locale: currency.locale,
      decimalDigits: decimals,
      name: ' ${currency.currencySymbol} ',
    ).format(value);
  }

  static separator(String locale) {
    return numberFormatSymbols[locale]?.DECIMAL_SEP ?? '.';
  }

  static List<Currency> all() {
    if (cachedCurrencies.length > 0) {
      return cachedCurrencies;
    }
    Map<String, Currency> data = {};

    numberFormatSymbols.keys.forEach((x) {
      var currCode = numberFormatSymbols[x].DEF_CURRENCY_CODE;
      data[currCode] = Currency(
        locale: x,
        currencyCode: currCode,
        currencySymbol: NumberFormat().simpleCurrencySymbol(currCode),
        decimalSep: numberFormatSymbols[x].DECIMAL_SEP,
        currencyName: Currencies.all[currCode],
      );
    });

    var currencies = data.values.toList();

    currencies.sort((a, b) => a.currencyName.compareTo(b.currencyName));
    currencies.add(Currency(
      locale: '0',
      currencyCode: '0',
      currencySymbol: '',
      decimalSep: '.',
      currencyName: 'Others',
    ));
    cachedCurrencies = currencies;
    return currencies;
  }

  static Currency getCurrency(String currencyTag) {
    List<String> tags = currencyTag.split('=');
    var currency = CurrencyHelper.all().firstWhere(
        (c) => c.locale == tags[0] && c.currencyCode == tags[1],
        orElse: () => CurrencyHelper.all().last);
    return currency;
  }
}
