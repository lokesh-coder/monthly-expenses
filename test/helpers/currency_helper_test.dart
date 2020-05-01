import "package:flutter_test/flutter_test.dart";
import "package:monex/helpers/currency_helper.dart";

main() {
  test("should get all currencies", () {
    expect(CurrencyHelper.all().length, 62);
  });

  test("should format amount with locale seperator", () {
    expect(CurrencyHelper.formatAmount("235000.45", "eu"), "235000,45");
    expect(CurrencyHelper.formatAmount("235000.45", "ml"), "235000.45");
  });

  test("should get currency info of a locale", () {
    expect(CurrencyHelper.getCurrency("sl=EUR").toJson(), {
      "locale": "sl",
      "currencyCode": "EUR",
      "currencySymbol": "€",
      "currencyName": "Euro",
      "decimalSep": ","
    });
  });

  test("should get formatted currency", () {
    var expected_1 = CurrencyHelper.getFormattedCurrency(450600.30, "sl=EUR");
    var expected_2 = CurrencyHelper.getFormattedCurrency(450600.30, "te=INR");
    expect(expected_1, "450.600,30  € ");
    expect(expected_2, " ₹ 4,50,600.30");
  });

  test("should validate amount pattern", () {
    expect(CurrencyHelper.isValidAmountPattern(".50"), true, reason: "a");
    expect(CurrencyHelper.isValidAmountPattern("00"), true, reason: "b");
    expect(CurrencyHelper.isValidAmountPattern("0.0"), true, reason: "c");
    expect(CurrencyHelper.isValidAmountPattern(".50999"), false, reason: "d");
    expect(CurrencyHelper.isValidAmountPattern("-.99"), true, reason: "e");
    expect(CurrencyHelper.isValidAmountPattern(".99-99"), false, reason: "f");
    expect(CurrencyHelper.isValidAmountPattern("450000."), true, reason: "g");
    expect(CurrencyHelper.isValidAmountPattern(" "), false, reason: "h");
  });

  test("should get separator for the locale", () {
    expect(CurrencyHelper.separator("eu"), ",");
    expect(CurrencyHelper.separator("te"), ".");
  });

  test("should get cached currencies", () {
    // expect(CurrencyHelper.cachedCurrencies.length, 0);
    // CurrencyHelper.all();
    expect(CurrencyHelper.cachedCurrencies.length, 62);
  });
}
