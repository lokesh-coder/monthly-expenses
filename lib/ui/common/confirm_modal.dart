import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/helpers/layout_helper.dart';

class ConfirmModalControl {
  Function() open;
  Function onYes;

  String title;
  String yesLabel;
  String noLabel;
  IconData icon;

  ConfirmModalControl({this.title, this.yesLabel, this.noLabel, this.icon});
}

class ConfirmModal extends StatelessWidget {
  final Function(BuildContext, ConfirmModalControl) builder;

  const ConfirmModal({
    Key key,
    this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var control = ConfirmModalControl();
        control.open = () {
          FocusScope.of(context).requestFocus(new FocusNode());

          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black26.withOpacity(0.2),
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (
              BuildContext buildContext,
              Animation animation,
              Animation secondaryAnimation,
            ) {
              return Center(
                child: _modal(context, control),
              );
            },
          );
        };

        return builder(context, control);
      },
    );
  }

  Widget _modal(BuildContext context, ConfirmModalControl control) {
    double borderRadius = 6.0;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: LayoutHelper.screenWidth / 1.5,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: [
            BoxShadow(
              color: Clrs.dark.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: _content(context, control),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, ConfirmModalControl control) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[_message(control), _actionBtns(context, control)],
    );
  }

  _message(ConfirmModalControl control) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        control.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Clrs.dark,
        ),
      ),
    );
  }

  _actionBtns(BuildContext context, ConfirmModalControl control) {
    var btnStyle = TextStyle(
      color: Clrs.label,
      letterSpacing: -0.5,
      fontWeight: FontWeight.w700,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlatButton(
          color: Colors.transparent,
          onPressed: () {
            control.onYes();
            Navigator.of(context).pop();
          },
          child: Text(
            control.yesLabel.toUpperCase(),
            style: btnStyle.copyWith(color: Color(0xffC694A9)),
          ),
        ),
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(control.noLabel.toUpperCase(), style: btnStyle),
        )
      ],
    );
  }
}
