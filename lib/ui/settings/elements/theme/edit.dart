import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:provider/provider.dart';

class ThemeEdit extends StatelessWidget {
  const ThemeEdit();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    final SettingsStore store = sl<SettingsStore>();
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: MaterialButton(
        elevation: 0,
        textColor: theme.violet,
        padding: EdgeInsets.all(10),
        color: theme.violet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: theme.violet, width: 2),
        ),
        onPressed: () => sl<SettingsStore>().toggleTheme(),
        child: Observer(builder: (context) {
          return Text(
            'Switch to ${store.isLightTheme ? 'Dark' : 'Light'}',
            style: Style.body.clr(Colors.white),
          );
        }),
      ),
    );
  }
}
