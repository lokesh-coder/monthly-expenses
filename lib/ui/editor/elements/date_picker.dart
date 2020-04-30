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
    List weeks = DateHelper.getAllDaysInMonth(selected);

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
    var _rows = <Row>[];
    weeks.forEach((week) {
      var _days = <Widget>[];
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
    if (dateObj == "") {
      dateObj = {"date": "", "dateTime": null};
    }
    var isSelecteDate = selected.day.toString() == dateObj["date"].toString();
    var textClr = isSelecteDate ? Colors.white : Clrs.inputValue;
    var bgClr = isSelecteDate ? Clrs.primary : Colors.transparent;

    return Expanded(
      child: Button(
        child: Text(
          dateObj["date"].toString(),
          style: Style.body.clr(textClr).md,
        ),
        color: bgClr,
        size: 50.0,
        onPressed: () => onSelect(dateObj['dateTime']),
      ),
    );
  }

  Widget _weekHeader() {
    List _days = ['SUN', 'MON', 'TUE', 'WED', 'THUR', 'FRI', 'SAT'];

    return Row(
      children: _days.map((d) => _weekName(d)).toList(),
    );
  }

  Widget _weekName(name) {
    var text = Text(
      name,
      style: Style.label,
    );

    var content = Center(
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
