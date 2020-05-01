import "package:flutter/material.dart";
import "package:monex/config/app.dart";
import "package:monex/config/colors.dart";
import "package:monex/config/m_icons.dart";
import "package:monex/config/typography.dart";
import "package:monex/helpers/currency_helper.dart";
import "package:monex/models/enums.dart";
import "package:monex/services/service_locator.dart";
import "package:monex/stores/settings/settings.store.dart";
import "package:monex/ui/common/amount.dart";
import "package:monex/ui/common/button.dart";

class AmountNumpad extends StatefulWidget {
  final Function onSelect;
  final Function close;
  final String selected;

  const AmountNumpad({this.selected, this.close, this.onSelect});

  @override
  _AmountNumpadState createState() => _AmountNumpadState();
}

class _AmountNumpadState extends State<AmountNumpad> {
  var store = sl<SettingsStore>();
  String value, locale, separator, currencySymbol;

  @override
  void initState() {
    super.initState();
    value = widget.selected == "null" ? "" : widget.selected;
    locale = store.currency.split("=")[0];
    separator = CurrencyHelper.separator(locale);
    currencySymbol = CurrencyHelper.getCurrency(store.currency).currencySymbol;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _KeypadDisplay(
          value,
          locale: locale,
          separator: separator,
          currencySymbol: currencySymbol,
          onClear: _onClear,
          onReset: _onReset,
        ),
        _KeypadLayout(
          value,
          locale: locale,
          separator: separator,
          onValueChange: _onValueChange,
          onDone: _onDone,
        )
      ],
    );
  }

  _onClear() {
    if (value.isEmpty) return;
    value = value.substring(0, value.length - 1);
    setState(() {});
  }

  _onReset() {
    value = "";
    setState(() {});
  }

  _onDone(newValue) {
    widget.onSelect(num.parse(newValue));
  }

  _onValueChange(newValue) {
    value = newValue;
    setState(() {});
  }
}

class _KeypadLayout extends StatelessWidget {
  final String value;
  final String locale;
  final String separator;
  final Function onValueChange;
  final Function onDone;
  const _KeypadLayout(this.value,
      {this.locale, this.separator, this.onValueChange, this.onDone});

  @override
  Widget build(BuildContext context) {
    var oneToNineKeys = List.generate(9, (i) => "${i + 1}");
    var keys = [...oneToNineKeys, separator, "0", "ENTER"];
    var renderButtonFn =
        (key) => _KeypadButton(key, onTap: () => _onKeySelect(key));
    var buttons = keys.map(renderButtonFn).toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: GridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 1.8,
        children: buttons,
      ),
    );
  }

  _onKeySelect(String key) {
    var finalValue = value;
    if (key == separator) key = ".";

    if (key == "ENTER") {
      if (value == null) finalValue = "";
      onDone(finalValue);
      return;
    }

    var _tempValue = _normalizeAmount(value + key);
    if (CurrencyHelper.isValidAmountPattern(_tempValue)) finalValue += key;

    onValueChange(finalValue);
  }

  String _normalizeAmount(String value) {
    if (value == ".") return "0";
    return value;
  }
}

class _KeypadDisplay extends StatelessWidget {
  final String value;
  final String locale;
  final String separator;
  final String currencySymbol;
  final Function onClear;
  final Function onReset;
  const _KeypadDisplay(this.value,
      {this.locale,
      this.separator,
      this.currencySymbol,
      this.onClear,
      this.onReset});

  @override
  Widget build(BuildContext context) {
    Widget displayValue;
    if (value == "") {
      var placeholderText = 0.toStringAsFixed(AppConfig.maxDecimalsInAmount);
      var formattedText = CurrencyHelper.formatAmount(placeholderText, locale);
      displayValue = Amount(
        formattedText,
        format: false,
        type: AmountDisplayType.PLACEHOLDER,
        size: DisplaySize.LG,
      );
    } else {
      displayValue = Amount(
        value.replaceAll(".", separator),
        format: false,
        type: AmountDisplayType.INPUT,
        size: DisplaySize.LG,
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              currencySymbol,
              style: Style.label.lg.normal.secClr,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: Center(child: displayValue)),
          SizedBox(
            width: 50,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onLongPress: onReset,
              child: Icon(MIcons.delete_back_2_line, color: Clrs.label),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: onClear,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Clrs.labelActive.withOpacity(0.2)),
        ),
      ),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String keyname;
  final Function onTap;
  const _KeypadButton(this.keyname, {this.onTap});

  @override
  Widget build(BuildContext context) {
    var child;

    if (keyname == "ENTER") {
      child = Icon(MIcons.tick, color: Clrs.secondary, size: 30);
    } else {
      child = Text(keyname,
          style: Style.numeric.lg.clr(Clrs.primary.withOpacity(0.7)));
    }

    return Button(child: child, onPressed: onTap);
  }
}
