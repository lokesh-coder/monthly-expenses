import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final IconButton action;
  final Widget leading;
  final String title;

  Header({Key key, this.title, this.leading, this.action}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title, style: TextStyle(color: Colors.white70)),
      centerTitle: true,
      actions: <Widget>[action],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
