import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class Expander extends StatefulWidget {
  final Widget Function(BuildContext, Map) bodyBuilder;
  final Widget Function(BuildContext, Map) headBuilder;

  const Expander({Key key, this.headBuilder, this.bodyBuilder})
      : super(key: key);

  @override
  _ExpanderState createState() => _ExpanderState();
}

class _ExpanderState extends State<Expander> {
  bool isContentVisible = false;

  toggle() {
    setState(() {
      isContentVisible = !isContentVisible;
    });
  }

  get dataContext {
    return {"toggle": toggle, "isOpen": isContentVisible};
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
        Divider(
          height: 0,
        ),
        Visibility(
          visible: isContentVisible,
          child: Container(
            color: Clrs.label.withOpacity(0.2),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: widget.bodyBuilder(context, dataContext),
          ),
        )
      ],
    );
  }
}
