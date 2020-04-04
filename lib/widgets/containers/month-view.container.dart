import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/widgets/containers/payments-view.container.dart';
import 'package:monex/widgets/modules/pager/pager.dart';
import 'package:monex/widgets/month-control.dart';

class MonthViewContainer extends StatelessWidget {
  const MonthViewContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (ctx) {
          var data = [
            'January',
            'Febraury',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
          ];
          return Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Pager(
                  builder: (int index, dynamic data, PageController ctrl) {
                    return PaymentsViewContainer(
                        index: index, data: data, ctrl: ctrl);
                  },
                  data: data,
                  initialPage: 2,
                  visibleItems: 1,
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border(
                    bottom: BorderSide(color: MonexColors.inputBorder),
                    top: BorderSide(color: MonexColors.inputBorder),
                  ),
                ),
                child: Pager.master(
                  builder: (int index, dynamic data, PageController ctrl) {
                    return MonthControl(index, data, ctrl);
                  },
                  data: data,
                  initialPage: 2,
                  visibleItems: 4,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
