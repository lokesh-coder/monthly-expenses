import "package:intl/intl.dart";
import "package:intl/number_symbols_data.dart" show numberFormatSymbols;
import "package:monex/config/app.dart";
import "package:monex/config/labels.dart";
import "package:monex/data/local/object/files/currencies.dart";
import "package:monex/models/currency.dart";

class CurrencyHelper {
  static List<Currency> cachedCurrencies = [];

  static String getFormattedCurrency(num value, String currencyTag) {
    var currency = getCurrency(currencyTag);
    if (currency.locale == "0") return value.toString();
    int decimals =
        value.toString().contains(".") ? AppConfig.maxDecimalsInAmount : 0;

    return NumberFormat.currency(
      locale: currency.locale,
      decimalDigits: decimals,
      name: " ${currency.currencySymbol} ",
    ).format(value);
  }

  static separator(String locale) {
    return numberFormatSymbols[locale]?.DECIMAL_SEP ?? ".";
  }

  static List<Currency> all() {
    if (cachedCurrencies.isNotEmpty) {
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
      locale: "0",
      currencyCode: "0",
      currencySymbol: "",
      decimalSep: ".",
      currencyName: Labels.otherCurrency,
    ));
    cachedCurrencies = currencies;
    return currencies;
  }

  static Currency getCurrency(String currencyTag) {
    List<String> tags = currencyTag.split("=");
    var currency = CurrencyHelper.all().firstWhere(
        (c) => c.locale == tags[0] && c.currencyCode == tags[1],
        orElse: () => CurrencyHelper.all().last);
    return currency;
  }

  static String formatAmount(String value, String locale) {
    return ((NumberFormat(null, locale)..turnOffGrouping())
          ..maximumFractionDigits = AppConfig.maxDecimalsInAmount)
        .format(num.tryParse(value))
        .toString();
  }

  static bool isValidAmountPattern(String val) {
    if (val.contains(".")) {
      if (val.allMatches(".").length > 1) {
        return false;
      }
      if (val.split(".").last.length > AppConfig.maxDecimalsInAmount) {
        return false;
      }
    }
    if (num.tryParse(val) == null) {
      return false;
    }
    if (num.parse(val) > AppConfig.maxAmoutLimit) {
      return false;
    }
    return true;
  }
}
