import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final Widget header;
  final Widget drawer;
  final Future<bool> Function() onBackBtnPress;
  final Key scaffoldKey;

  const AppShell(
      {Key key,
      this.child,
      this.header,
      this.drawer,
      this.onBackBtnPress,
      this.scaffoldKey})
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
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Future<bool> _onBackBtnPress() {
    return Future.value(true);
  }
}
