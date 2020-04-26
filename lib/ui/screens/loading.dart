import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/ui/common/app-shell.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Container(
        color: Clrs.primary,
        child: Center(
            child: Text('Loading...', style: TextStyle(color: Colors.white))),
      ),
    );
  }
}
