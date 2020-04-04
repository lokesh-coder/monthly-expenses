import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class FormIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const FormIconButton({
    Key key,
    this.icon,
    this.label,
    this.color = MonexColors.inputLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: MonexColors.inputLabel,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
