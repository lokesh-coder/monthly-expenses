import 'package:flutter/material.dart';
import 'package:monthlyexp/config/app.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/helpers/currency_helper.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/common/amount.dart';
import 'package:monthlyexp/ui/common/button.dart';
import 'package:provider/provider.dart';

class AmountNumpad extends StatefulWidget {
  final Function onSelect;
  final Function close;
  final String selected;

  const AmountNumpad({this.selected, this.close, this.onSelect});

  @override
  _AmountNumpadState createState() => _AmountNumpadState();
}

class _AmountNumpadState extends State<AmountNumpad> {
  final SettingsStore store = sl<SettingsStore>();
  String value, locale, separator, currencySymbol;

  @override
  void initState() {
    super.initState();
    value = widget.selected == 'null' ? '' : widget.selected;
    locale = store.currency.split('=')[0];
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

  void _onClear() {
    if (value.isEmpty) {
      return;
    }
    value = value.substring(0, value.length - 1);
    setState(() {});
  }

  void _onReset() {
    value = '';
    setState(() {});
  }

  void _onDone(newValue) {
    widget.onSelect(num.parse(newValue));
  }

  void _onValueChange(newValue) {
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
    final oneToNineKeys = List.generate(9, (i) => '${i + 1}');
    final keys = [...oneToNineKeys, separator, '0', 'ENTER'];
    Widget renderButtonFn(key) =>
        _KeypadButton(key, onTap: () => _onKeySelect(key));
    final buttons = keys.map(renderButtonFn).toList();

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

  void _onKeySelect(String key) {
    var finalValue = value;
    if (key == separator) {
      // ignore: parameter_assignments
      key = '.';
    }

    if (key == 'ENTER') {
      if (value == null) {
        finalValue = '';
      }
      onDone(finalValue);
      return;
    }

    final _tempValue = _normalizeAmount(value + key);
    if (CurrencyHelper.isValidAmountPattern(_tempValue)) {
      finalValue += key;
    }

    onValueChange(finalValue);
  }

  String _normalizeAmount(String value) {
    if (value == '.') {
      return '0';
    }
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
    final theme = Provider.of<ThemeChanger>(context).theme;
    Widget displayValue;
    if (value == '') {
      final placeholderText = 0.toStringAsFixed(AppConfig.maxDecimalsInAmount);
      final formattedText =
          CurrencyHelper.formatAmount(placeholderText, locale);
      displayValue = Amount(
        formattedText,
        format: false,
        type: AmountDisplayType.PLACEHOLDER,
        size: DisplaySize.LG,
      );
    } else {
      displayValue = Amount(
        value.replaceAll('.', separator),
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
              style: Style.label.lg.normal.clr(theme.brand),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: Center(child: displayValue)),
          SizedBox(
            width: 50,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onLongPress: onReset,
              child:
                  Icon(MIcons.delete_back_2_line, color: theme.textSubHeading),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: onClear,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: theme.bgPrimary,
        border: Border(
          bottom: BorderSide(color: theme.textSubHeading.withOpacity(0.2)),
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
    final theme = Provider.of<ThemeChanger>(context).theme;
    Widget child;

    if (keyname == 'ENTER') {
      child = Icon(MIcons.tick, color: theme.brand, size: 30);
    } else {
      child = Text(keyname, style: Style.numeric.lg.clr(theme.textHeading));
    }

    return Button(child: child, onPressed: onTap);
  }
}
