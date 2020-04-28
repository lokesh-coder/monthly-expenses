import 'package:flutter/material.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/ui/common/hint.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final Widget leading;
  final String title;

  Header({Key key, this.title, this.leading}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title, style: Style.heading.md.bodyAltClr),
      centerTitle: true,
      actions: [
        Hint(
          Labels.closeScreen,
          child: IconButton(
            icon: Icon(MIcons.close_line, color: Colors.white54, size: 27),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        )
      ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
