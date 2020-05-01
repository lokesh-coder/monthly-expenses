class Currency {
  String locale;
  String currencyCode;
  String currencySymbol;
  String currencyName;
  String decimalSep;

  Currency({
    this.locale,
    this.currencyCode,
    this.currencySymbol,
    this.currencyName,
    this.decimalSep,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      locale: json["locale"],
      currencyCode: json["currencyCode"],
      currencySymbol: json["currencySymbol"],
      currencyName: json["currencyName"],
      decimalSep: json["decimalSep"],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "locale": locale,
        "currencyCode": currencyCode,
        "currencySymbol": currencySymbol,
        "currencyName": currencyName,
        "decimalSep": decimalSep,
      };
}
