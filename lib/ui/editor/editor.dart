import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/models/payment.model.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/ui/common/ribbon.dart';

import 'elements/action_buttons.dart';
import 'elements/type_input.dart';
import 'elements/amount_input.dart';
import 'elements/date_input.dart';
import 'elements/label_input.dart';
import 'elements/category_input.dart';

final formKey = GlobalKey<FormState>();

class Editor extends StatefulWidget {
  const Editor({Key key}) : super(key: key);

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  var sandwichStore = sl<SandwichStore>();
  var paymentsStore = sl<PaymentsStore>();
  var formStore = sl<FormStore>();
  bool shouldLoad = false;

  ReactionDisposer disposeOne;
  ReactionDisposer disposeTwo;

  Payment payment;

  @override
  void initState() {
    super.initState();
    disposeOne = reaction((_) => sandwichStore.isOpen, (x) {
      if (x) {
        shouldLoad = x;
        formStore.initForm();
        setState(() {});
      }
    });

    disposeTwo = reaction((_) => paymentsStore.activeMonth, (x) {
      formStore.changeDate(DateHelper.dtToMs(x));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!shouldLoad) return Container();
    return GestureDetector(
      onTap: () => _closeKeyboard(context),
      child: Container(
        color: Clrs.light.withOpacity(0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_formArea(), _actionArea(context)],
        ),
      ),
    );
  }

  Widget _formArea() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(child: _form()),
      ),
    );
  }

  _actionArea(context) {
    return ActionButton(onSubmit: _save);
  }

  Widget _form() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AmountInput(),
          SizedBox(height: 10),
          LabelInput(),
          SizedBox(height: 50),
          _row([TypeInput(), CategoryInput(), DateInput()])
        ],
      ),
    );
  }

  Widget _row(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: children.map((child) => Expanded(child: child)).toList(),
      ),
    );
  }

  _closeKeyboard(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  _save() {
    print('data ${formStore.data.toJson()}');

    Payment payment = formStore.data;

    if (payment.amount == null || payment.label == null) {
      _showSnackbar();
      return;
    }

    if (payment.id == null) {
      paymentsStore.insertPayment(payment);
    } else {
      paymentsStore.updatePayment(payment);
    }

    paymentsStore.setActivePayment(null);
    sandwichStore.changeVisibility(false);
  }

  _showSnackbar() {
    final snackBar = SnackBar(
      backgroundColor: Clrs.secondary,
      content: Ribbon(Labels.formError),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
    disposeOne();
    disposeTwo();
  }
}
