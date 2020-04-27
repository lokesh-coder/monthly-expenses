import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/config/m_icons.dart';
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
    var content = formStore.label;
    var tf = Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Clrs.label.withOpacity(0.1),
        border: Border.all(color: Clrs.primary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: TextFormField(
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
              style: TextStyle(
                color: Clrs.labelActive,
                fontSize: 17,
              ),
              onChanged: (x) {
                content = x;
              },
              onFieldSubmitted: (x) {
                content = x;
                formStore.changeLabel(x);
                control.close();
              },
            ),
          ),
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Clrs.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Tooltip(
              message: Labels.addLabel,
              child: IconButton(
                onPressed: () {
                  formStore.changeLabel(content);
                  control.close();
                },
                padding: EdgeInsets.all(0),
                icon: Icon(
                  MIcons.check_line,
                ),
                color: Clrs.light,
              ),
            ),
          )
        ],
      ),
    );
    control.open(Labels.addAShortName, tf);
  }
}
