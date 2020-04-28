import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/ui/common/fade_transition.dart';
import 'package:monex/ui/screens/app_info.dart';
import 'package:monex/ui/screens/help.dart';

class AppLinks extends StatelessWidget {
  const AppLinks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: Clrs.labelActive.withOpacity(0.05),
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Text(
            Labels.aboutApp.toUpperCase(),
            style: Style.label.sm,
          ),
        ),
        _getItemTile(context, Labels.appInfo, () => AppInfoScreen()),
        _getItemTile(context, Labels.help, () => HelpScreen())
      ],
    );
  }

  _getItemTile(context, name, page) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 35),
      title: Text(name, style: Style.label.normal.base),
      trailing: Icon(MIcons.arrow_drop_right_fill),
      onTap: () {
        Navigator.push(
          context,
          FadeRoute(page()),
        );
      },
    );
  }
}
