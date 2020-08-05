import 'package:flutter/material.dart';
import 'package:monthlyexp/config/app.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/helpers/date_helper.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:provider/provider.dart';

class MonthRangeEdit extends StatefulWidget {
  const MonthRangeEdit();

  @override
  _MonthRangeEditState createState() => _MonthRangeEditState();
}

class _MonthRangeEditState extends State<MonthRangeEdit> {
  double _value;
  final SettingsStore settingsStore = sl<SettingsStore>();

  @override
  void initState() {
    super.initState();
    _value = settingsStore.monthsViewRange.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    final int totalMonths = _value.round();
    return Column(
      children: <Widget>[
        Text(
          '$totalMonths Month${totalMonths > 1 ? 's' : ''}',
          style: Style.label.md.clr(theme.textSubHeading),
        ),
        SizedBox(height: 20),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: theme.violet,
            inactiveTrackColor: theme.textSubHeading,
            trackHeight: 3.0,
            thumbColor: theme.violet,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
            overlayColor: theme.violet.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
            activeTickMarkColor: theme.violet,
            inactiveTickMarkColor: theme.textSubHeading,
          ),
          child: Slider(
            min: AppConfig.minMonths.toDouble(),
            max: AppConfig.maxMonths.toDouble(),
            divisions: 11,
            value: _value,
            onChangeEnd: (value) {
              settingsStore.changeMonthsViewRange(value.toInt());
            },
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ),
        SizedBox(height: 10),
        Text(
          DateHelper.getMonthRangeDisplayText(_value.toInt()),
          style: Style.label.normal.sm.clr(theme.textSubHeading),
        ),
      ],
    );
  }
}
