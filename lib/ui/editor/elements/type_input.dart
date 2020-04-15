import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/ui/editor/elements/icon_card.dart';

class TypeInput extends StatelessWidget {
  const TypeInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormStore formStore = sl<FormStore>();
    return Observer(
      builder: (context) {
        return IconCard(
          child: _icon(formStore),
          name: formStore.isCredit ? 'CREDIT' : 'DEBIT',
          onTap: () => formStore.changeType(!formStore.isCredit),
          storeKey: () => formStore.isCredit,
        );
      },
    );
  }

  Widget _icon(FormStore formStore) {
    return Icon(
      formStore.isCredit
          ? Icons.sentiment_satisfied
          : Icons.sentiment_dissatisfied,
      size: 30,
      color: formStore.isCredit ? Clrs.green : Clrs.red,
    );
  }
}
