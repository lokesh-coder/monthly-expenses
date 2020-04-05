import 'package:flutter/material.dart';
import 'package:monex/widgets/banner-board.dart';
import 'package:monex/widgets/containers/month-view.container.dart';
import 'package:monex/widgets/editor.dart';
import 'package:monex/widgets/modules/sandwich/model.dart';
import 'package:monex/widgets/modules/sandwich/sandwich.dart';
import 'package:monex/widgets/shared/app-shell.dart';
import 'package:monex/widgets/shared/header.dart';
import 'package:provider/provider.dart';

class MonthsPage extends StatelessWidget {
  const MonthsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShell(
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // Set the transparency here
          canvasColor: Colors
              .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
        ),
        child: Drawer(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: EdgeInsets.all(10),
              child: Text('dd'),
            ),
          ),
        ),
      ),
      header: Header(
        title:
            Text('monthly expences', style: TextStyle(color: Colors.white70)),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        action: IconButton(onPressed: () {}, icon: Icon(Icons.add)),
      ),
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
        translateOffset: 80.0,
        dynamicContent: 40.0,
        visibleContentHeight: 60.0,
        bottomChild: Editor(),
        middleChild: MonthViewContainer(),
        topChild: BannerBoard(0, [], PageController()),
      ),
    );
  }
}
