import 'package:flutter/material.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:package_info/package_info.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/ui/common/app-shell.dart';
import 'package:monthlyexp/ui/common/header.dart';
import 'package:provider/provider.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen();

  @override
  _AppInfoScreenState createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  PackageInfo info;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        info = packageInfo;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return AppShell(
      header: Header(
        title: Labels.appInfo,
        leading: Container(),
      ),
      child: Container(
        child: ListView(
          children: _getData(info, theme),
        ),
      ),
    );
  }

  List<Widget> _getData(PackageInfo info, AppTheme theme) {
    if (info == null) {
      return [];
    }
    final List<Map> items = [
      {'Name': info.appName},
      {'Version': info.version},
      {'Build number': info.buildNumber},
      {'Package name': info.packageName},
    ];
    final List<Widget> tiles = [];
    items.forEach((item) {
      tiles.add(_getItem(item.keys.first, item.values.first, theme));
    });
    return tiles;
  }

  Widget _getItem(String title, String value, AppTheme theme) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: theme.textSubHeading.withOpacity(0.3))),
      ),
      child: ListTile(
        title: Text(title, style: Style.heading.clr(theme.textHeading)),
        trailing:
            Text(value, style: Style.label.sm.normal.clr(theme.textSubHeading)),
      ),
    );
  }
}
