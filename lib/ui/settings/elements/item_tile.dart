import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/config/typography.dart';

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
    var arrowIcon =
        dataCtx['isOpen'] ? MIcons.arrow_up_s_line : MIcons.arrow_down_s_line;

    return ListTile(
      onTap: dataCtx['toggle'],
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      leading: IconButton(
        onPressed: null,
        icon: Icon(icon, size: 26, color: Clrs.secondary),
      ),
      title: Text(title, style: Style.heading),
      subtitle: Text(displayText, style: Style.label.sm),
      trailing: Icon(arrowIcon, color: Clrs.label),
    );
  }
}
