import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/helpers/layout_helper.dart';

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
    return Column(
      children: [
        Container(
          color: isContentVisible
              ? Clrs.label.withOpacity(0.2)
              : Colors.transparent,
          child: widget.headBuilder(context, dataContext),
        ),
        Divider(height: 0),
        Visibility(
          visible: isContentVisible,
          child: Container(
            width: LayoutHelper.screenWidth,
            color: Clrs.label.withOpacity(0.2),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: widget.bodyBuilder(context, dataContext),
          ),
        )
      ],
    );
  }
}
