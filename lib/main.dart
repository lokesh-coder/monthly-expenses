import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/widgets/pages/months.page.dart';

void main() {
  runApp(MyApp());
  setupServiceLocator();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Clrs.primary,
      statusBarBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Monex',
      theme: ThemeData(
        primaryColor: Clrs.primary,
        fontFamily: 'Circular',
      ),
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      home: MonthsPage(),
    );
  }
}
