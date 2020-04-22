import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class Check extends StatelessWidget {
  final Function onTap;
  const Check({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: 26,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: null,
          backgroundColor: Clrs.primary,
          child: Icon(Icons.check, size: 33),
          elevation: 0,
          onPressed: null,
        ),
      ),
    );
  }
}
