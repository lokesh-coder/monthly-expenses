import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final Function onSubmit;
  final Function onClose;
  final double btnHeight = 60;

  const ActionButton({Key key, this.label, this.onSubmit, this.onClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MonexColors.primary,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[_primary(), _secondary()],
      ),
    );
  }

  Widget _primary() {
    var text = Text(
      label.toUpperCase(),
      style:
          TextStyle(fontSize: 15, letterSpacing: -0.5, color: Colors.white70),
    );

    return Expanded(
      child: Container(
        height: btnHeight,
        child: FlatButton(
          color: MonexColors.primary,
          padding: EdgeInsets.all(20),
          child: text,
          onPressed: onSubmit,
        ),
      ),
    );
  }

  Widget _secondary() {
    var icon = Icon(Icons.keyboard_arrow_down, size: 35);

    return Container(
      height: btnHeight,
      child: FlatButton(
        color: Colors.black26,
        textColor: Colors.white54,
        onPressed: onClose,
        child: icon,
      ),
    );
  }
}
