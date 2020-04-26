import 'package:flutter/material.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/ui/common/app-shell.dart';
import 'package:monex/ui/common/header.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShell(
      header: Header(
        title: Labels.appInfo,
        action: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        leading: Container(),
      ),
      child: Container(
        child: Text('im info'),
      ),
    );
  }
}
