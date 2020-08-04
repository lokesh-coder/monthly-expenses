import 'package:flutter/material.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:provider/provider.dart';

class SettingsItemTile extends StatelessWidget {
  final Function onTap;
  final IconData arrowIcon;
  final IconData icon;
  final String title;
  final String displayText;
  final bool isOpen;
  final Map dataCtx;

  const SettingsItemTile({
    this.onTap,
    this.icon,
    this.arrowIcon,
    this.title,
    this.displayText,
    this.isOpen,
    this.dataCtx,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    final arrowIcon =
        dataCtx['isOpen'] ? MIcons.arrow_up_s_line : MIcons.arrow_down_s_line;

    return ListTile(
      onTap: dataCtx['toggle'],
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      leading: IconButton(
        onPressed: null,
        icon: Icon(icon, size: 26, color: theme.violet),
      ),
      title: Text(title, style: Style.heading.light.clr(theme.textHeading)),
      subtitle: Text(displayText,
          style: Style.label.sm.light.clr(theme.textSubHeading)),
      trailing: Icon(arrowIcon, color: theme.textSubHeading),
    );
  }
}
