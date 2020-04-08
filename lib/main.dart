import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/source/models/payments.model.dart';
import 'package:monex/widgets/modules/pager/model.dart';
import 'package:monex/widgets/modules/sandwich/model.dart';
import 'package:monex/widgets/pages/months.page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  setupServiceLocator();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: MonexColors.primary,
      statusBarBrightness: Brightness.dark,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PagerModel()),
        ChangeNotifierProvider(create: (_) => SandwichModel()),
        ChangeNotifierProvider(create: (_) => PaymentsModel()),
      ],
      child: MaterialApp(
        title: 'Monex',
        theme: ThemeData(
          primaryColor: MonexColors.primary,
          fontFamily: 'Circular',
        ),
        debugShowCheckedModeBanner: false,
        // debugShowMaterialGrid: true,
        home: MonthsPage(),
      ),
    );
  }
}
