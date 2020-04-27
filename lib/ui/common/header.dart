import 'package:flutter/material.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final Widget leading;
  final String title;

  Header({Key key, this.title, this.leading}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title, style: TextStyle(color: Colors.white70)),
      centerTitle: true,
      actions: [
        Tooltip(
          message: Labels.closeScreen,
          child: IconButton(
            icon: Icon(MIcons.close_line),
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
