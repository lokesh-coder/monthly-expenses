import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/ui/common/bottom_modal.dart';
import 'package:monex/ui/editor/elements/date_picker.dart';
import 'package:monex/ui/editor/elements/icon_card.dart';

class DateInput extends StatelessWidget {
  const DateInput();

  @override
  Widget build(BuildContext context) {
    var formStore = sl<FormStore>();
    return BottomModal(
      builder: (context, control) {
        return Observer(builder: (context) {
          return IconCard(
            child: _icon(formStore),
            name: _displayDateMonth(formStore.date),
            onTap: () => _picker(control, formStore),
            storeKey: () => formStore.date,
          );
        });
      },
    );
  }

  void _picker(BottomModalControl control, FormStore formStore) {
    var selectedDate = DateHelper.msToDt(formStore.date);
    var selectedMonth = DateHelper.getMonthName(selectedDate);
    var title = '${Labels.chooseDate}  ·  $selectedMonth';
    Widget picker = DatePicker(
      selected: selectedDate,
      onSelect: (dt) {
        var ms = DateHelper.dtToMs(dt);
        formStore.changeDate(ms);
        control.close();
      },
    );
    control.open(title, picker);
  }

  Widget _icon(FormStore formStore) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          MIcons.calendar_line_1,
          size: 30,
          color: Clrs.blue,
        ),
        Positioned(
          top: 10,
          child: Text(
            _displayDate(formStore.date),
            style: Style.body.sm.clr(Clrs.blue).light,
          ),
        )
      ],
    );
  }

  String _displayDateMonth(int ms) {
    DateTime dt = DateHelper.msToDt(ms);
    return DateHelper.format(dt, DateHelper.monthDayP).toUpperCase();
  }

  String _displayDate(int ms) {
    DateTime dt = DateHelper.msToDt(ms);
    return DateHelper.format(dt, DateHelper.dateP);
  }
}
