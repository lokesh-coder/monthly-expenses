import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class DeleteButton extends StatelessWidget {
  final Function onTap;
  const DeleteButton({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: <Widget>[
            Icon(Icons.delete, size: 27, color: Clrs.inputLabel),
            SizedBox(height: 10),
            _label(),
          ],
        ),
      ),
    );
  }

  Widget _label() {
    return Text(
      'DELETE',
      style: TextStyle(
        color: Clrs.inputLabel,
        fontWeight: FontWeight.w600,
        fontSize: 11,
      ),
    );
  }
}
