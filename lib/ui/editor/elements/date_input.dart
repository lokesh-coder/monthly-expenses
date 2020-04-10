import 'package:flutter/material.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/ui/common/bottom_modal.dart';
import 'package:monex/ui/editor/elements/base_input.dart';
import 'package:monex/ui/editor/elements/date_picker.dart';

class DateInput extends StatefulWidget {
  final Function(int) onSaved;
  final Function validator;
  final int value;

  const DateInput({Key key, this.value, this.onSaved, this.validator})
      : super(key: key);

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  int currVal;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currVal = widget.value ?? DateHelper.dtToMs(DateTime.now());
    return BottomModal(
      builder: (context, control) {
        return BaseInput(
          placeholder: 'pick a date',
          validator: (String x) => null,
          value: _displayDate(currVal),
          inputType: InputType.NONE,
          label: 'Date',
          onSaved: (x) => widget.onSaved(currVal),
          onTap: () => _picker(control),
        );
      },
    );
  }

  void _picker(BottomModalControl control) {
    Widget picker = DatePicker(
      onSelect: (dt) {
        setState(() {
          currVal = DateHelper.dtToMs(dt);
        });

        control.close();
      },
      selected: DateHelper.msToDt(currVal),
    );
    control.open('dateicer', picker);
  }

  String _displayDate(int ms) {
    DateTime dt = ms == null ? DateTime.now() : DateHelper.msToDt(ms);
    return DateHelper.getFormattedDayOfMonth(dt);
  }
}
