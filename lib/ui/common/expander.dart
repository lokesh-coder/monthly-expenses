import 'package:flutter/material.dart';
import 'package:monthlyexp/helpers/layout_helper.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:provider/provider.dart';

class Expander extends StatefulWidget {
  final Widget Function(BuildContext, Map) bodyBuilder;
  final Widget Function(BuildContext, Map) headBuilder;

  const Expander({this.headBuilder, this.bodyBuilder});

  @override
  _ExpanderState createState() => _ExpanderState();
}

class _ExpanderState extends State<Expander> {
  bool isContentVisible = false;

  void toggle() {
    setState(() {
      isContentVisible = !isContentVisible;
    });
  }

  Map get dataContext {
    return {'toggle': toggle, 'isOpen': isContentVisible};
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return Column(
      children: [
        Container(
          color: isContentVisible ? theme.bgPrimary : Colors.transparent,
          child: widget.headBuilder(context, dataContext),
        ),
        Divider(height: 0),
        Visibility(
          visible: isContentVisible,
          child: Container(
            width: LayoutHelper.screenWidth,
            color: theme.bgSecondary,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: widget.bodyBuilder(context, dataContext),
          ),
        )
      ],
    );
  }
}
