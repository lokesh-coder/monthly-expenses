import 'package:flutter/material.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/ui/common/app-shell.dart';
import 'package:monthlyexp/ui/common/header.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen();

  @override
  Widget build(BuildContext context) {
    return AppShell(
      header: Header(title: Labels.help, leading: Container()),
      child: Container(
        child: Text('im help'),
      ),
    );
  }
}
