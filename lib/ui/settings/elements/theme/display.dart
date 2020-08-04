import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/settings/elements/item_tile.dart';

class ThemeDisplay extends StatelessWidget {
  final Map dataCtx;

  const ThemeDisplay(this.dataCtx);

  @override
  Widget build(BuildContext context) {
    final SettingsStore store = sl<SettingsStore>();

    return Observer(builder: (context) {
      return SettingsItemTile(
        dataCtx: dataCtx,
        icon: MIcons.emotion_happy_line,
        title: Labels.changeTheme,
        displayText: store.isLightTheme ? 'Light' : 'Dark',
      );
    });
  }
}
