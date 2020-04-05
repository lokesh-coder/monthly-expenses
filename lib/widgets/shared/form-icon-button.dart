import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class FormIconButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Function onClick;
  const FormIconButton({
    Key key,
    this.icon,
    this.label,
    this.onClick,
    this.color = MonexColors.inputLabel,
  }) : super(key: key);

  @override
  _FormIconButtonState createState() => _FormIconButtonState();
}

class _FormIconButtonState extends State<FormIconButton> {
  double size = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: widget.onClick,
        onTapDown: (x) {
          setState(() {
            size = 2.0;
          });
        },
        onTapUp: (x) {
          setState(() {
            size = 1.0;
          });
        },
        child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeOutBack,
            tween: Tween(begin: 1.0, end: size),
            builder: (context, value, child) {
              return Column(
                children: [
                  Transform.scale(
                    scale: value,
                    child: Icon(
                      widget.icon,
                      color: widget.color,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.label.toUpperCase(),
                    style: TextStyle(
                      color: MonexColors.inputLabel,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
