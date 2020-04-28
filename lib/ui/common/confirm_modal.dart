import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/typography.dart';
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

  const ConfirmModal({this.builder});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        var control = ConfirmModalControl();
        control.open = () {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black26.withOpacity(0.2),
            transitionDuration: const Duration(milliseconds: 200),
            pageBuilder: (BuildContext x, Animation y, Animation z) {
              return Center(child: _ModalLayout(control));
            },
          );
        };

        return builder(context, control);
      },
    );
  }
}

class _ModalLayout extends StatelessWidget {
  final ConfirmModalControl control;
  final double borderRadius = 6.0;

  const _ModalLayout(this.control);

  @override
  Widget build(BuildContext context) {
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
          child: _ModalContent(control),
        ),
      ),
    );
  }
}

class _ModalContent extends StatelessWidget {
  final ConfirmModalControl control;
  const _ModalContent(this.control);

  @override
  Widget build(BuildContext context) {
    var btnStyle = Style.body.sm.clr(Clrs.text.withOpacity(0.5));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            control.title,
            textAlign: TextAlign.center,
            style: Style.body.bodyClr,
          ),
        ),
        Row(
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
                style: btnStyle.copyWith(color: Clrs.secondary),
              ),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(control.noLabel.toUpperCase(), style: btnStyle),
            )
          ],
        )
      ],
    );
  }
}
