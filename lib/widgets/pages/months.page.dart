import 'package:flutter/material.dart';
import 'package:monex/widgets/banner-board.dart';
import 'package:monex/widgets/containers/month-view.container.dart';
import 'package:monex/widgets/editor.dart';
import 'package:monex/widgets/modules/pager/pager.dart';
import 'package:monex/widgets/modules/sandwich/model.dart';
import 'package:monex/widgets/modules/sandwich/sandwich.dart';
import 'package:monex/widgets/shared/app-shell.dart';
import 'package:provider/provider.dart';

class MonthsPage extends StatelessWidget {
  const MonthsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShell(
      onBackBtnPress: () {
        var sandwich = Provider.of<SandwichModel>(context, listen: false);
        if (sandwich.isRevealed) {
          sandwich.slideDown();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Sandwich(
        safeHeight: MediaQuery.of(context).padding.top,
        translateOffset: 111.0,
        visibleContentHeight: 70.0,
        bottomChild: Editor(),
        middleChild: MonthViewContainer(),
        topChild: Pager(
          initialPage: 1,
          data: List.filled(10, 0),
          visibleItems: 1,
          builder: (index, data, ctrl) {
            return BannerBoard(index, data, ctrl);
          },
        ),
      ),
    );
  }
}
