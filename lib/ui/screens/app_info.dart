import "package:flutter/material.dart";
import "package:monex/config/colors.dart";
import "package:monex/config/typography.dart";
import "package:package_info/package_info.dart";
import "package:monex/config/labels.dart";
import "package:monex/ui/common/app-shell.dart";
import "package:monex/ui/common/header.dart";

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
    return AppShell(
      header: Header(
        title: Labels.appInfo,
        leading: Container(),
      ),
      child: Container(
        child: ListView(
          children: _getData(info),
        ),
      ),
    );
  }

  List<Widget> _getData(PackageInfo info) {
    if (info == null) return [];
    List<Map> items = [
      {"Name": info.appName},
      {"Version": info.version},
      {"Build number": info.buildNumber},
      {"Package name": info.packageName},
    ];
    List<Widget> tiles = [];
    items.forEach((item) {
      tiles.add(_getItem(item.keys.first, item.values.first));
    });
    return tiles;
  }

  Widget _getItem(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Clrs.border.withOpacity(0.7))),
      ),
      child: ListTile(
        title: Text(title, style: Style.heading),
        trailing: Text(value, style: Style.label.sm.normal),
      ),
    );
  }
}
