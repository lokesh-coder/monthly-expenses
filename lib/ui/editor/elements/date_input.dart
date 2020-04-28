import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/ui/common/bottom_modal.dart';
import 'package:monex/ui/editor/elements/date_picker.dart';
import 'package:monex/ui/editor/elements/icon_card.dart';

class DateInput extends StatelessWidget {
  const DateInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formStore = sl<FormStore>();
    return BottomModal(
      builder: (context, control) {
        return Observer(builder: (context) {
          return IconCard(
            child: _icon(formStore),
            name: _displayDateMonth(formStore.date).toUpperCase(),
            onTap: () => _picker(control, formStore),
            storeKey: () => formStore.date,
          );
        });
      },
    );
  }

  void _picker(BottomModalControl control, FormStore formStore) {
    var selectedDate = DateHelper.msToDt(formStore.date);
    Widget picker = DatePicker(
      onSelect: (dt) {
        var ms = DateHelper.dtToMs(dt);
        formStore.changeDate(ms);

        control.close();
      },
      selected: selectedDate,
    );
    control.open(
        '${Labels.chooseDate}  ·  ${DateHelper.getMonthName(selectedDate)}',
        picker);
  }

  _icon(FormStore formStore) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Icon(
          MIcons.calendar_line_1,
          size: 30,
          color: Clrs.blue,
        ),
        Positioned(
          top: 10,
          child: Text(
            _displayDate(formStore.date),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Clrs.blue,
            ),
          ),
        )
      ],
    );
  }

  String _displayDateMonth(int ms) {
    DateTime dt = DateHelper.msToDt(ms);
    return DateHelper.getFormattedDayOfMonth(dt);
  }

  String _displayDate(int ms) {
    DateTime dt = DateHelper.msToDt(ms);
    return DateHelper.getDateOfMonth(dt);
  }
}
