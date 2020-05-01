import "package:flutter/material.dart";
import "package:monex/config/colors.dart";
import "package:monex/ui/common/app-shell.dart";
import "package:monex/ui/common/loader.dart";

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
