import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final IconButton action;
  final IconButton leading;
  final Text title;

  Header({Key key, this.title, this.leading, this.action}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: title,
      centerTitle: true,
      actions: <Widget>[action],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
