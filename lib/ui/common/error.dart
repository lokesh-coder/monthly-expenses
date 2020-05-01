import "package:flutter/material.dart";
import "package:monex/config/colors.dart";
import "package:monex/config/labels.dart";
import "package:monex/config/m_icons.dart";
import "package:monex/config/typography.dart";

class Err extends StatelessWidget {
  const Err({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(MIcons.bug_line, color: Clrs.red, size: 19),
          SizedBox(width: 10),
          Text(Labels.error, style: Style.body),
        ],
      ),
    );
  }
}
