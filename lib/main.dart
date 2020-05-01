import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/services/error_reporter.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/main_page.dart';
import 'package:monex/ui/screens/loading.dart';
import 'package:monex/ui/screens/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  handleErrors(MonexApp());
}

class MonexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsStore store = sl<SettingsStore>();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Clrs.primary,
      statusBarBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: Labels.appName,
      navigatorKey: Catcher.navigatorKey,
      theme: ThemeData(primaryColor: Clrs.primary, fontFamily: Font.base),
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      home: Observer(builder: (context) {
        Widget screen;

        if (store.isNewSetup == null) {
          screen = LoadingScreen();
        } else if (store.isNewSetup) {
          screen = WelcomeScreen();
        } else {
          screen = MainPage();
        }

        return screen;
      }),
    );
  }
}
