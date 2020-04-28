import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/m_icons.dart';

class SettingsItemTile extends StatelessWidget {
  final Function onTap;
  final IconData arrowIcon;
  final IconData icon;
  final String title;
  final String displayText;
  final bool isOpen;
  final Map dataCtx;

  const SettingsItemTile({
    Key key,
    this.onTap,
    this.icon,
    this.arrowIcon,
    this.title,
    this.displayText,
    this.isOpen,
    this.dataCtx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: dataCtx['toggle'],
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      leading: IconButton(
        onPressed: null,
        icon: Icon(
          icon,
          size: 26,
          color: Clrs.secondary,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Clrs.dark,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        displayText,
        style: TextStyle(
          fontSize: 14,
          color: Clrs.labelActive,
        ),
      ),
      trailing: Icon(
        dataCtx['isOpen'] ? MIcons.arrow_down_s_line : MIcons.arrow_up_s_line,
        color: Clrs.label,
      ),
    );
  }
}
