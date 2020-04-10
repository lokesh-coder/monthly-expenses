import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/helpers/layout_helper.dart';
import 'package:monex/models/payment.model.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';

import 'elements/action_button.dart';
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
  bool isNew = true;
  Payment payment;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        payment = _data();
        return AnimatedOpacity(
          duration: Duration(milliseconds: 400),
          opacity: sandwichStore.isOpen ? 1 : 0,
          child: GestureDetector(
            onTap: () => _closeKeyboard(context),
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [_formArea(), _actionArea(context)],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _formArea() {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        primary: true,
        child: _form(),
      ),
    );
  }

  _actionArea(context) {
    if (LayoutHelper.isKeyboardOpen) return SizedBox.shrink();
    return ActionButton(
      label: 'save',
      onClose: () {
        sl<SandwichStore>().changeVisibility(false);
      },
      onSubmit: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          _save();
        }
      },
    );
  }

  Widget _form() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _withBtns(_amountInput(), _typeInput()),
          _line(),
          _labelInput(),
          _line(),
          _row([_categoryInput(), _dateInput()]),
          _line()
        ],
      ),
    );
  }

  Widget _amountInput() {
    return AmountInput(
      value: payment.amount,
      onSaved: (x) {
        payment.amount = x;
      },
    );
  }

  Widget _typeInput() {
    return TypeInput(
      value: payment.isCredit,
      onTap: (x) {
        payment.isCredit = x;
      },
    );
  }

  Widget _labelInput() {
    return LabelInput(
      value: payment.label,
      onSaved: (x) {
        payment.label = x;
      },
    );
  }

  Widget _categoryInput() {
    return CategoryInput(
      value: payment.categoryID,
      onSaved: (x) {
        payment.categoryID = x;
      },
    );
  }

  Widget _dateInput() {
    return DateInput(
      value: payment.date,
      onSaved: (x) {
        payment.date = x;
      },
    );
  }

  Widget _row(List<Widget> children) {
    return Row(
      children: children.map((child) => Expanded(child: child)).toList(),
    );
  }

  Widget _withBtns(Widget input, Widget btnOne,
      [Widget btnTwo = const SizedBox.shrink()]) {
    return Row(children: [Expanded(child: input), btnOne, btnTwo]);
  }

  _line() {
    return Divider(
      color: MonexColors.inputBorder,
      height: 1,
      thickness: 1,
    );
  }

  _closeKeyboard(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  int _defaultDate() {
    return paymentsStore.activeMonth == null
        ? DateHelper.toMs
        : DateHelper.dtToMs(paymentsStore.activeMonth);
  }

  _data() {
    if (paymentsStore.active == null) {
      isNew = true;
      return Payment(
        amount: null,
        categoryID: null,
        createdTime: null,
        date: _defaultDate(),
        isCredit: true,
        label: null,
      );
    }

    isNew = false;
    payment = paymentsStore.getPayment(paymentsStore.active);
    return payment;
  }

  _save() {
    payment.lastModifiedTime = DateHelper.toMs;
    if (isNew) payment.createdTime = payment.lastModifiedTime;
    print('+++ ${payment.toJson()}');

    if (payment.id == null) {
      paymentsStore.insertPayment(payment);
    } else {
      paymentsStore.updatePayment(payment);
    }

    paymentsStore.setActivePayment(null);
    sl<SandwichStore>().changeVisibility(false);
  }
}
