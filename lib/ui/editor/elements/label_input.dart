import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/ui/common/bottom_modal.dart';

class LabelInput extends StatelessWidget {
  const LabelInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormStore formStore = sl<FormStore>();

    return BottomModal(
      builder: (context, control) {
        return GestureDetector(
          onTap: () {
            _textField(control, formStore);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Clrs.label.withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Observer(builder: (context) {
              return Text(
                  formStore.label == null
                      ? 'add short name'
                      : formStore.label.toString(),
                  style: TextStyle(color: Clrs.labelActive));
            }),
          ),
        );
      },
    );
  }

  _textField(BottomModalControl control, FormStore formStore) {
    var tf = TextFormField(
      initialValue: formStore.label,
      autofocus: true,
      onFieldSubmitted: (x) {
        formStore.changeLabel(x);
        control.close();
      },
    );
    control.open('label', tf);
  }
}
