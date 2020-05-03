import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/ui/common/fade_transition.dart';
import 'package:monex/ui/screens/app_info.dart';
import 'package:monex/ui/screens/help.dart';
import 'package:share/share.dart';

class AppLinks extends StatelessWidget {
  const AppLinks();

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
        _getItemTile(Labels.appInfo, onTap: () {
          Navigator.push(context, FadeRoute(AppInfoScreen()));
        }),
        // _getItemTile(Labels.help, onTap: () {
        //   Navigator.push(context, FadeRoute(HelpScreen()));
        // }),
        _getItemTile(
          Labels.share,
          onTap: () => Share.share(Labels.shareMessage),
        )
      ],
    );
  }

  Widget _getItemTile(String name, {Function onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 35),
      title: Text(name, style: Style.label.normal.base),
      trailing: Icon(MIcons.arrow_drop_right_fill),
      onTap: onTap,
    );
  }
}
