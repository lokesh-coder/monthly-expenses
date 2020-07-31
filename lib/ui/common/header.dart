import 'package:flutter/material.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/ui/common/hint.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final Widget leading;
  final String title;

  Header({this.title, this.leading});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title, style: Style.heading.md.bodyAltClr),
      centerTitle: true,
      elevation: 0,
      actions: [
        Hint(
          Labels.closeScreen,
          child: IconButton(
            icon: Icon(MIcons.close_line, color: Colors.white54, size: 27),
            onPressed: () => Navigator.of(context).pop(),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
