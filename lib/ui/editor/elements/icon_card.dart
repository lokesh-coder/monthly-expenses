import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class IconCard extends StatelessWidget {
  final Widget child;
  final String name;
  final Function onTap;

  const IconCard({Key key, this.child, this.name, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: child,
              height: 35,
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                color: Clrs.inputLabel,
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
