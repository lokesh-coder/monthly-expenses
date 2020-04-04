import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/models/DateUtil.dart';

class DueDayPicker extends StatelessWidget {
  const DueDayPicker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List weeks = DateUtil().getAllDaysInMonth(DateTime.now());

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: _getWeekWidgets(weeks)..insert(0, _getWeekNamesWidget()),
      ),
    );
  }

  List<Row> _getWeekWidgets(List<List> weeks) {
    List<Row> _rows = [];
    weeks.forEach((week) {
      List<Widget> _days = [];
      week.forEach((day) => _days.add(_getDayWidget(day)));
      _rows.add(_getWeekWidget(_days));
    });
    return _rows;
  }

  Row _getWeekWidget(week) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: week,
    );
  }

  Widget _getDayWidget(date) {
    return Expanded(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            date.toString(),
            style: TextStyle(fontSize: 18, color: MonexColors.inputValue),
          ),
        ),
      ),
    );
  }

  Widget _getWeekNamesWidget() {
    List _days = ['SUN', 'MON', 'TUE', 'WED', 'THUR', 'FRI', 'SAT'];

    return Row(
      children: _days.map((d) => _getWeekNameWidget(d)).toList(),
    );
  }

  Widget _getWeekNameWidget(name) {
    return Expanded(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            name,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: MonexColors.inputLabel),
          ),
        ),
      ),
    );
  }
}
