import 'package:flutter/material.dart';
import 'package:monthlyexp/config/colors.dart';
import 'package:monthlyexp/ui/common/app-shell.dart';
import 'package:monthlyexp/ui/common/loader.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Container(
        color: Clrs.primary,
        child: Center(child: Loader()),
      ),
    );
  }
}
