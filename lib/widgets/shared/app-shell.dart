import 'package:flutter/material.dart';
import 'package:monex/helpers/layout_helper.dart';

final GlobalKey scaffoldKey = new GlobalKey<ScaffoldState>();

class AppShell extends StatelessWidget {
  final Widget child;
  final Widget header;
  final Widget drawer;
  final Future<bool> Function() onBackBtnPress;

  const AppShell(
      {Key key, this.child, this.header, this.drawer, this.onBackBtnPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackBtnPress == null ? _onBackBtnPress : onBackBtnPress,
      child: Scaffold(
        key: scaffoldKey,
        drawer: drawer,
        appBar: header,
        body: child,
      ),
    );
  }

  Future<bool> _onBackBtnPress() {
    return Future.value(true);
  }
}
