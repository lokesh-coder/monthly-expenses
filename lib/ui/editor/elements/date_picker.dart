import 'package:flutter/material.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/helpers/date_helper.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/ui/common/button.dart';
import 'package:provider/provider.dart';

class DatePicker extends StatelessWidget {
  final Function(DateTime) onSelect;
  final DateTime selected;

  const DatePicker({this.selected, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    final List weeks = DateHelper.getAllDaysInMonth(selected);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: _weeks(weeks, theme)..insert(0, _weekHeader(theme)),
      ),
    );
  }

  List<Widget> _weeks(List<List> weeks, AppTheme theme) {
    final _rows = <Row>[];
    weeks.forEach((week) {
      final _days = <Widget>[];
      week.forEach((day) => _days.add(_day(day, theme)));
      _rows.add(_week(_days));
    });
    return _rows;
  }

  Widget _week(week) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: week,
    );
  }

  Widget _day(dateObj, AppTheme theme) {
    if (dateObj == '') {
      // ignore: parameter_assignments
      dateObj = {'date': '', 'dateTime': null};
    }
    final isSelecteDate = selected.day.toString() == dateObj['date'].toString();
    final textClr = isSelecteDate ? Colors.white : theme.textSubHeading;
    final bgClr = isSelecteDate ? theme.brand : Colors.transparent;
    final hasShape = isSelecteDate ? true : false;

    return Expanded(
      child: Button(
        child: Text(
          dateObj['date'].toString(),
          style: Style.body.clr(textClr).md,
        ),
        hasShape: hasShape,
        color: bgClr,
        size: 50.0,
        onPressed: () => onSelect(dateObj['dateTime']),
      ),
    );
  }

  Widget _weekHeader(AppTheme theme) {
    final List _days = ['SUN', 'MON', 'TUE', 'WED', 'THUR', 'FRI', 'SAT'];

    return Row(
      children: _days.map((name) => _weekName(name, theme)).toList(),
    );
  }

  Widget _weekName(name, AppTheme theme) {
    final text = Text(name, style: Style.label.clr(theme.textHeading));

    final content = Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: text,
      ),
    );

    return Expanded(
      child: content,
    );
  }
}
