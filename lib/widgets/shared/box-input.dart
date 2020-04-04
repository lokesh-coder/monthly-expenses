import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

enum InputType { CURRENCY, TEXT, NONE }

class BoxInput extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final String placeholder;
  final InputType inputType;
  final bool hasRightBorder;
  final Function onClick;

  const BoxInput({
    Key key,
    this.label,
    this.placeholder = '',
    this.isPrimary = false,
    this.inputType = InputType.NONE,
    this.hasRightBorder = false,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
              color: MonexColors.inputBorder,
            ),
            right: hasRightBorder
                ? BorderSide(
                    color: MonexColors.inputBorder,
                  )
                : BorderSide.none),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            readOnly: inputType == InputType.NONE ? true : false,
            style: TextStyle(
              color: MonexColors.inputValue,
              fontSize: isPrimary ? 30 : 20,
              fontWeight: isPrimary ? FontWeight.w800 : FontWeight.w400,
            ),
            keyboardAppearance: Brightness.dark,
            keyboardType: _getKeyboardType(),
            onTap: onClick,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: InputBorder.none,
              hintText: placeholder,
              hintStyle: TextStyle(color: MonexColors.inputPlaceholder),
            ),
          ),
          Visibility(
            visible: !isPrimary,
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                letterSpacing: -1,
                color: MonexColors.inputLabel,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  _getKeyboardType() {
    if (inputType == InputType.CURRENCY) {
      return TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      );
    }
  }
}
