import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class ToggleIconFormField extends FormField<bool> {
  ToggleIconFormField(
      {Widget title,
      @required BuildContext context,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autovalidate = false,
      @required List truthyData,
      @required List falsyData})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<bool> state) {
              var data = state.value ? truthyData : falsyData;

              return Container(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () => state.didChange(!state.value),
                  child: Column(
                    children: [
                      Icon(
                        data[0],
                        color: data[2],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data[1].toUpperCase(),
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
            });
}
