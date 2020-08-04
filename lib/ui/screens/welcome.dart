import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/common/app-shell.dart';
import 'package:monthlyexp/ui/common/fade_transition.dart';
import 'package:monthlyexp/ui/screens/currency.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen();

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final SettingsStore store = sl<SettingsStore>();
  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    disposer = reaction((_) => store.currency, (_) {
      store.setupDone();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return AppShell(
      child: SafeArea(
        child: Container(
          color: theme.bg,
          padding: EdgeInsets.all(40),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Labels.welcome,
                  style: Style.body.light.lg.clr(theme.textHeading),
                ),
                SizedBox(height: 5),
                Text(
                  Labels.chooseCurrencyLong,
                  textAlign: TextAlign.center,
                  style: Style.body.clr(theme.textSubHeading),
                ),
                SizedBox(height: 60),
                FlatButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.push(context, FadeRoute(CurrencyScreen()));
                  },
                  color: theme.brand,
                  child: Text(
                    Labels.chooseCurrency.toUpperCase(),
                    style: Style.body.sm.clr(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    disposer();
  }
}
