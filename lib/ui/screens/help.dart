import 'package:flutter/material.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/ui/common/app-shell.dart';
import 'package:monex/ui/common/header.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShell(
      header: Header(
        title: Labels.help,
        action: IconButton(
          icon: Icon(MIcons.close_line),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        leading: Container(),
      ),
      child: Container(
        child: Text('im help'),
      ),
    );
  }
}
