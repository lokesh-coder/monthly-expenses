import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final Widget header;
  final Future<bool> Function() onBackBtnPress;

  const AppShell({Key key, this.child, this.header, this.onBackBtnPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackBtnPress == null ? _onBackBtnPress : onBackBtnPress,
      child: Scaffold(
        appBar: header,
        body: header != null ? child : SafeArea(child: child),
      ),
    );
  }

  Future<bool> _onBackBtnPress() {
    return Future.value(true);
  }
}
