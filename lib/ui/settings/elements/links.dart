import 'package:flutter/material.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/ui/common/fade_transition.dart';
import 'package:monthlyexp/ui/screens/app_info.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class AppLinks extends StatelessWidget {
  const AppLinks();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: theme.bgSecondary,
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Text(
            Labels.aboutApp.toUpperCase(),
            style: Style.label.sm.clr(theme.textSubHeading),
          ),
        ),
        _getItemTile(Labels.appInfo, theme, onTap: () {
          Navigator.push(context, FadeRoute(AppInfoScreen()));
        }),
        // _getItemTile(Labels.help, onTap: () {
        //   Navigator.push(context, FadeRoute(HelpScreen()));
        // }),
        _getItemTile(
          Labels.share,
          theme,
          onTap: () => Share.share(Labels.shareMessage),
        )
      ],
    );
  }

  Widget _getItemTile(String name, AppTheme theme, {Function onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 35),
      title: Text(name, style: Style.label.normal.base.clr(theme.textHeading)),
      trailing: Icon(MIcons.arrow_drop_right_fill,
          color: theme.textSubHeading.withOpacity(0.3)),
      onTap: onTap,
    );
  }
}
