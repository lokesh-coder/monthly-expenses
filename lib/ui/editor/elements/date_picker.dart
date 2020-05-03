import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/ui/common/button.dart';

class DatePicker extends StatelessWidget {
  final Function(DateTime) onSelect;
  final DateTime selected;

  const DatePicker({this.selected, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final List weeks = DateHelper.getAllDaysInMonth(selected);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: _weeks(weeks)..insert(0, _weekHeader()),
      ),
    );
  }

  List<Widget> _weeks(List<List> weeks) {
    final _rows = <Row>[];
    weeks.forEach((week) {
      final _days = <Widget>[];
      week.forEach((day) => _days.add(_day(day)));
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

  Widget _day(dateObj) {
    if (dateObj == '') {
      // ignore: parameter_assignments
      dateObj = {'date': '', 'dateTime': null};
    }
    final isSelecteDate = selected.day.toString() == dateObj['date'].toString();
    final textClr = isSelecteDate ? Colors.white : Clrs.inputValue;
    final bgClr = isSelecteDate ? Clrs.primary : Colors.transparent;
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

  Widget _weekHeader() {
    final List _days = ['SUN', 'MON', 'TUE', 'WED', 'THUR', 'FRI', 'SAT'];

    return Row(
      children: _days.map(_weekName).toList(),
    );
  }

  Widget _weekName(name) {
    final text = Text(name, style: Style.label);

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
