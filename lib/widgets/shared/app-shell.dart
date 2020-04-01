import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final Widget header;

  const AppShell({Key key, this.child, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('TOP5 ${MediaQuery.of(context).padding.top}');
    return Scaffold(
      appBar: header,
      body: header != null ? child : SafeArea(child: child),
    );
  }
}
