import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/main_page.dart';
import 'package:monex/ui/screens/loading.dart';
import 'package:monex/ui/screens/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsStore store = sl<SettingsStore>();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Clrs.primary,
      statusBarBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: Labels.appName,
      theme: ThemeData(
        primaryColor: Clrs.primary,
        fontFamily: 'Circular',
      ),
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      home: Observer(builder: (context) {
        Widget displayPage;

        if (store.isNewSetup == null) {
          displayPage = LoadingScreen();
        } else if (store.isNewSetup) {
          displayPage = WelcomeScreen();
        } else {
          displayPage = MainPage();
        }
        return displayPage;
      }),
    );
  }
}
