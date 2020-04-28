import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/helpers/date_helper.dart';

class DatePicker extends StatelessWidget {
  final Function(DateTime) onSelect;
  final DateTime selected;

  const DatePicker({Key key, this.selected, this.onSelect}) : super(key: key);

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
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelect(dateObj['dateTime']),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: isSelecteDate ? Clrs.primary : Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(vertical: 9),
          margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Center(
            child: Text(
              dateObj["date"].toString(),
              style: TextStyle(
                height: 1.2,
                fontSize: 18,
                color: isSelecteDate ? Colors.white : Clrs.inputValue,
              ),
            ),
          ),
        ),
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
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Clrs.inputLabel,
      ),
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
