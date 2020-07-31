import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/colors.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/error_reporter.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/common/error.dart';
import 'package:monthlyexp/ui/main_page.dart';
import 'package:monthlyexp/ui/screens/loading.dart';
import 'package:monthlyexp/ui/screens/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  handleErrors(MonthlyexpApp());
}

class MonthlyexpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsStore store = sl<SettingsStore>();

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
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails details) => Err();
        return widget;
      },
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
