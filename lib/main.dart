import 'package:catcher/catcher_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/error_reporter.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/common/error.dart';
import 'package:monthlyexp/ui/main_page.dart';
import 'package:monthlyexp/ui/screens/loading.dart';
import 'package:monthlyexp/ui/screens/welcome.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeChanger>(
        create: (_) => ThemeChanger(LightTheme()),
      ),
    ],
    child: handleErrors(MonthlyexpApp()),
  ));
}

class MonthlyexpApp extends StatefulWidget {
  @override
  _MonthlyexpAppState createState() => _MonthlyexpAppState();
}

class _MonthlyexpAppState extends State<MonthlyexpApp> {
  SettingsStore store = sl<SettingsStore>();
  ReactionDisposer disposeReaction;
  @override
  void initState() {
    super.initState();
    disposeReaction = reaction((_) => store.isLightTheme, (isLightTheme) {
      print('changed to $isLightTheme');
      final th = isLightTheme ? LightTheme() : DarkTheme();
      Provider.of<ThemeChanger>(context, listen: false).setTheme(th);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: theme.bgPrimary,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: theme.bgPrimary,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: Labels.appName,
      navigatorKey: Catcher.navigatorKey,
      theme: ThemeData(
        primaryColor: theme.bgPrimary,
        fontFamily: Font.base,
        scaffoldBackgroundColor: theme.bg,
      ),
      debugShowCheckedModeBanner: false,
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
