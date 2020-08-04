import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/helpers/date_helper.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/models/payment.model.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/form/form.store.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:monthlyexp/stores/sandwiich/sandwich.store.dart';
import 'package:monthlyexp/ui/common/ribbon.dart';
import 'package:provider/provider.dart';

import 'elements/action_buttons.dart';
import 'elements/amount_input.dart';
import 'elements/category_input.dart';
import 'elements/date_input.dart';
import 'elements/label_input.dart';
import 'elements/type_input.dart';

final GlobalKey formKey = GlobalKey<FormState>();

class Editor extends StatefulWidget {
  const Editor();

  @override
  _EditorState createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  final SandwichStore sandwichStore = sl<SandwichStore>();
  final PaymentsStore paymentsStore = sl<PaymentsStore>();
  final FormStore formStore = sl<FormStore>();
  bool shouldLoad = false;

  ReactionDisposer disposeOne;
  ReactionDisposer disposeTwo;

  Payment payment;

  @override
  void initState() {
    super.initState();
    disposeOne = reaction((_) => sandwichStore.isOpen, (x) {
      if (!x) {
        return;
      }
      shouldLoad = x;
      formStore.initForm();
      setState(() {});
    });

    disposeTwo = reaction((_) => paymentsStore.activeMonth, (x) {
      formStore.changeDate(DateHelper.dtToMs(x));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    if (!shouldLoad) {
      return Container();
    }
    return GestureDetector(
      onTap: () => _closeKeyboard(context),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_formArea(), _actionArea(context, theme)],
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

  Widget _actionArea(context, theme) {
    return ActionButton(onSubmit: () => _save(theme));
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

  void _closeKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _save(AppTheme theme) {
    print('data ${formStore.data.toJson()}');

    final Payment payment = formStore.data;

    if (payment.amount == null || payment.label == null) {
      _showSnackbar(theme);
      return;
    }

    if (payment.id == null) {
      paymentsStore.insertPayment(payment);
    } else {
      paymentsStore.updatePayment(payment);
    }

    final type = payment.isCredit ? PaymentType.CREDIT : PaymentType.DEBIT;
    if (paymentsStore.filterBy != type) {
      paymentsStore.changeFilter(type);
    }

    paymentsStore.setActivePayment(null);
    sandwichStore.changeVisibility(false);
  }

  void _showSnackbar(AppTheme theme) {
    final snackBar = SnackBar(
      backgroundColor: theme.brand,
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
