import "package:flutter/material.dart";
import "package:mobx/mobx.dart";
import "package:monex/config/colors.dart";
import "package:monex/config/labels.dart";
import "package:monex/config/typography.dart";
import "package:monex/services/service_locator.dart";
import "package:monex/stores/settings/settings.store.dart";
import "package:monex/ui/common/app-shell.dart";
import "package:monex/ui/common/fade_transition.dart";
import "package:monex/ui/screens/currency.dart";

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen();

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var store = sl<SettingsStore>();
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
    return AppShell(
      child: SafeArea(
        child: Container(
          color: Clrs.primary,
          padding: EdgeInsets.all(40),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Labels.welcome,
                  style: Style.body.light.lg.clr(Clrs.light),
                ),
                SizedBox(height: 5),
                Text(
                  Labels.chooseCurrencyLong,
                  textAlign: TextAlign.center,
                  style: Style.body.bodyAltClr,
                ),
                SizedBox(height: 60),
                FlatButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.push(context, FadeRoute(CurrencyScreen()));
                  },
                  color: Clrs.compliment,
                  child: Text(
                    Labels.chooseCurrency.toUpperCase(),
                    style: Style.body.sm.clr(Colors.white70),
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
