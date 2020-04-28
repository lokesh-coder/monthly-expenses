import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/common/app-shell.dart';
import 'package:monex/ui/common/fade_transition.dart';
import 'package:monex/ui/settings/elements/currency/page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var store = sl<SettingsStore>();
  @override
  void initState() {
    super.initState();

    reaction((_) => store.currency, (_) {
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
              children: <Widget>[
                Text(
                  'Hey, Welcome!',
                  style: Style.body.light.lg.clr(Clrs.light),
                ),
                SizedBox(height: 5),
                Text(
                  'Please choose your preffered currency.',
                  textAlign: TextAlign.center,
                  style: Style.body.bodyAltClr,
                ),
                SizedBox(height: 60),
                FlatButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadeRoute(CurrencyPage()),
                    );
                  },
                  color: Color(0xffcf6a87),
                  child: Text(
                    'Choose currency'.toUpperCase(),
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
}
