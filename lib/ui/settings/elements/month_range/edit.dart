import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';

class MonthRangeEdit extends StatefulWidget {
  const MonthRangeEdit({Key key}) : super(key: key);

  @override
  _MonthRangeEditState createState() => _MonthRangeEditState();
}

class _MonthRangeEditState extends State<MonthRangeEdit> {
  double _value;
  var settingsStore = sl<SettingsStore>();

  @override
  void initState() {
    super.initState();
    _value = settingsStore.monthsViewRange.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '${(_value.round()).toString()} Month(s)',
          style: TextStyle(
            color: Clrs.inputValue,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Clrs.secondary,
            inactiveTrackColor: Clrs.label,
            trackHeight: 3.0,
            thumbColor: Clrs.secondary,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
            overlayColor: Clrs.secondary.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
            activeTickMarkColor: Clrs.secondary,
            inactiveTickMarkColor: Clrs.label,
          ),
          child: Slider(
            min: 1,
            max: 12,
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
        SizedBox(
          height: 10,
        ),
        Text(
          DateHelper.getMonthRangeDisplayText(_value.toInt()),
          style: TextStyle(
            color: Clrs.labelActive,
          ),
        ),
      ],
    );
  }
}
