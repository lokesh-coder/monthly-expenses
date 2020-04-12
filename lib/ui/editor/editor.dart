import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/helpers/layout_helper.dart';
import 'package:monex/models/payment.model.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/ui/common/confirm_modal.dart';
import 'package:monex/ui/editor/elements/delete_button.dart';

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
  var formStore = sl<FormStore>();

  ReactionDisposer disposeOne;
  ReactionDisposer disposeTwo;

  Payment payment;

  @override
  void initState() {
    super.initState();
    disposeOne = reaction((_) => sandwichStore.isOpen, (x) {
      formStore.initForm();
    });

    disposeTwo = reaction((_) => paymentsStore.activeMonth, (x) {
      formStore.changeDate(DateHelper.dtToMs(x));
    });
  }

  @override
  Widget build(BuildContext context) {
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
        sandwichStore.changeVisibility(false);
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
          _withBtns(_amountInput(), _typeInput(), _deleteBtn()),
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
    return Observer(builder: (context) {
      return AmountInput(
        value: formStore.amount,
        onSaved: (x) {
          formStore.changeAmount(x);
        },
      );
    });
  }

  Widget _typeInput() {
    return Observer(builder: (context) {
      return TypeInput(
        value: formStore.isCredit,
        onTap: (x) {
          formStore.changeType(x);
        },
      );
    });
  }

  Widget _deleteBtn() {
    return Observer(builder: (context) {
      return Visibility(
        visible: !formStore.isNew,
        child: ConfirmModal(
          builder: (context, control) {
            return DeleteButton(
              onTap: () => _delete(control),
            );
          },
        ),
      );
    });
  }

  Widget _labelInput() {
    return Observer(builder: (context) {
      return LabelInput(
        value: formStore.label,
        onSaved: (x) {
          formStore.changeLabel(x);
        },
      );
    });
  }

  Widget _categoryInput() {
    return Observer(builder: (context) {
      return CategoryInput(
        value: formStore.categoryID,
        isCredit: formStore.isCredit,
        onSaved: (x) {
          formStore.changeCategoryID(x);
        },
      );
    });
  }

  Widget _dateInput() {
    return Observer(builder: (context) {
      return DateInput(
        value: formStore.date,
        onSaved: (x) {
          formStore.changeDate(x);
        },
      );
    });
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
      color: Clrs.inputBorder,
      height: 1,
      thickness: 1,
    );
  }

  _closeKeyboard(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  _save() {
    print('data ${formStore.data.toJson()}');

    Payment payment = formStore.data;

    if (payment.id == null) {
      paymentsStore.insertPayment(payment);
    } else {
      paymentsStore.updatePayment(payment);
    }

    paymentsStore.setActivePayment(null);
    sandwichStore.changeVisibility(false);
  }

  void _delete(ConfirmModalControl control) {
    control.title = 'Are you sure?';
    control.yesLabel = 'Delete';
    control.noLabel = 'cancel';
    control.icon = Icons.delete;
    control.onYes = () {
      sandwichStore.changeVisibility(false);
      paymentsStore.deletePayment(payment.id);
      paymentsStore.setActivePayment(null);
    };
    control.open();
  }

  @override
  void dispose() {
    super.dispose();
    disposeOne();
    disposeTwo();
  }
}
