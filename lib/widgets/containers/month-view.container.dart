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
            'one',
            'two',
            'three',
            'four',
            'five',
            'six',
            'seven',
            'eight',
            'nine',
            'ten'
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
                height: 70,
                color: Color(0xffECEBF4),
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
