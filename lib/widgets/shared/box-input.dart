import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

enum InputType { CURRENCY, TEXT, NONE }

class BoxInput extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final String placeholder;
  final dynamic initialValue;
  final InputType inputType;
  final bool hasRightBorder;
  final Function onClick;
  final Function onSaved;
  final Function onChanged;
  final Function validator;

  BoxInput({
    Key key,
    this.label,
    this.placeholder = '',
    this.isPrimary = false,
    this.inputType = InputType.NONE,
    this.hasRightBorder = false,
    this.onClick,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.validator,
  }) : super(key: key);

  @override
  _BoxInputState createState() => _BoxInputState();
}

class _BoxInputState extends State<BoxInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
    _controller.addListener(() {
      _controller.text = widget.initialValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: MonexColors.inputBorder,
          ),
          right: widget.hasRightBorder
              ? BorderSide(
                  color: MonexColors.inputBorder,
                )
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _controller,
            readOnly: widget.inputType == InputType.NONE ? true : false,
            style: TextStyle(
              color: MonexColors.inputValue,
              fontSize: widget.isPrimary ? 30 : 20,
              fontWeight: widget.isPrimary ? FontWeight.w800 : FontWeight.w400,
            ),
            keyboardAppearance: Brightness.dark,
            keyboardType: _getKeyboardType(),
            onTap: widget.onClick,
            onEditingComplete: () {
              print('editing complete');
            },
            onChanged: (v) {
              print('it git changed to $v');
            },
            validator: widget.validator,
            onSaved: widget.onSaved,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
              border: InputBorder.none,
              hintText: widget.placeholder,
              hintStyle: TextStyle(color: MonexColors.inputPlaceholder),
            ),
          ),
          Visibility(
            visible: !widget.isPrimary,
            child: Text(
              widget.label.toUpperCase(),
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
    if (widget.inputType == InputType.CURRENCY) {
      return TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
