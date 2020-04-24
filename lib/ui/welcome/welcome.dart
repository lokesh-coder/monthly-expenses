import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/common/app-shell.dart';
import 'package:monex/ui/common/fade_transition.dart';
import 'package:monex/ui/settings/elements/currency/page.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
                  style: TextStyle(
                    color: Clrs.light,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Please choose your preffered currency.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Clrs.label,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 60),
                FlatButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.push(
                      context,
                      FadeRoute(page: CurrencyPage()),
                    );
                  },
                  color: Color(0xffcf6a87),
                  child: Text(
                    'Choose currency'.toUpperCase(),
                    style: TextStyle(
                      color: Color(0xfff7f1e3).withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
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
