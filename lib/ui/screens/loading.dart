import 'package:flutter/material.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/ui/common/app-shell.dart';
import 'package:monthlyexp/ui/common/loader.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return AppShell(
      child: Container(
        color: theme.brand,
        child: Center(child: Loader()),
      ),
    );
  }
}
