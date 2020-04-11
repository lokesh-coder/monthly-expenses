import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/models/enums.dart';

class BaseInput extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final String placeholder;
  final dynamic value;
  final InputType inputType;
  final Function onTap;
  final Function onSaved;
  final Function validator;

  const BaseInput({
    Key key,
    this.label = '',
    this.placeholder = '',
    this.isPrimary = false,
    this.inputType = InputType.NONE,
    this.onTap,
    this.onSaved,
    this.value,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_textField(), _label()],
        ),
      ),
    );
  }

  Widget _textField() {
    var _inputStyle = TextStyle(
      color: Clrs.inputValue,
      fontSize: isPrimary ? 30 : 20,
      fontWeight: isPrimary ? FontWeight.w800 : FontWeight.w400,
    );

    var _inputDecoration = InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 10),
      border: InputBorder.none,
      hintText: placeholder,
      hintStyle: TextStyle(color: Clrs.inputPlaceholder),
    );

    return AbsorbPointer(
      absorbing: inputType == InputType.NONE ? true : false,
      child: TextFormField(
        key: UniqueKey(),
        initialValue: value,
        style: _inputStyle,
        keyboardType: _getKeyboardType(),
        validator: validator,
        onSaved: onSaved,
        decoration: _inputDecoration,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _label() {
    var _textStyle = TextStyle(
      letterSpacing: -1,
      color: Clrs.inputLabel,
      fontWeight: FontWeight.w600,
    );

    return Visibility(
      visible: !isPrimary,
      child: Text(label.toUpperCase(), style: _textStyle),
    );
  }

  _getKeyboardType() {
    if (inputType == InputType.CURRENCY) {
      return TextInputType.numberWithOptions(
        signed: false,
      );
    }
  }
}
