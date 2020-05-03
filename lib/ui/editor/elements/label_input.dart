import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
import 'package:monex/config/typography.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/ui/common/bottom_modal.dart';
import 'package:monex/ui/common/button.dart';
import 'package:monex/ui/common/hint.dart';

class LabelInput extends StatelessWidget {
  const LabelInput();

  @override
  Widget build(BuildContext context) {
    final FormStore formStore = sl<FormStore>();

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
                style: Style.label.normal.sm,
              );
            }),
          ),
        );
      },
    );
  }

  void _textField(BottomModalControl control, FormStore formStore) {
    var content = formStore.label;
    final tf = Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Clrs.label.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.text,
              enableSuggestions: false,
              autocorrect: false,
              initialValue: formStore.label,
              autofocus: true,
              maxLength: 30,
              enableInteractiveSelection: true,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 1,
              buildCounter: (BuildContext context,
                      {int currentLength, int maxLength, bool isFocused}) =>
                  null,
              decoration: InputDecoration.collapsed(hintText: null),
              style: Style.body.md,
              onChanged: (x) {
                content = x.trim();
              },
              onFieldSubmitted: (x) {
                content = x.trim();
                if (content.isNotEmpty) {
                  formStore.changeLabel(x);
                }
                control.close();
              },
            ),
          ),
          Hint(
            Labels.addLabel,
            child: Button(
              onPressed: () {
                if (content.isNotEmpty) {
                  formStore.changeLabel(content);
                }
                control.close();
              },
              child: Icon(MIcons.tick),
              color: Clrs.primary,
              radius: 20.0,
              size: 35.0,
            ),
          )
        ],
      ),
    );
    control.open(Labels.addAShortName, tf);
  }
}
