import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/models/DateUtil.dart';
import 'package:monex/source/models/payment.model.dart';
import 'package:monex/widgets/shared/CategoryInput.dart';
import 'package:monex/widgets/shared/DayInput.dart';
import 'package:monex/widgets/shared/PickableBottomSheet.dart';
import 'package:monex/widgets/shared/ToggleIconFormField.dart';
import 'package:monex/widgets/shared/box-input.dart';
import 'package:monex/widgets/shared/button.dart';
import 'package:monex/widgets/shared/form-icon-button.dart';
import 'package:provider/provider.dart';
import 'modules/sandwich/model.dart';

final formKey = GlobalKey<FormState>();

class PaymentForm extends StatefulWidget {
  const PaymentForm({Key key}) : super(key: key);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  var payment = Payment(
    amount: 0.0,
    categoryID: 'BILLS',
    createdTime: null,
    date: DateTime(2020).millisecondsSinceEpoch,
    isCredit: true,
    label: 'hoya',
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  _amountField(context),
                  _labelField(),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 1, child: _categoryField()),
                      Expanded(flex: 1, child: _dateField()),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: _saveBtn(),
              ),
              _closeBtn(context),
            ],
          )
        ],
      ),
    );
  }

  _amountField(context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        BoxInput(
          label: '',
          placeholder: '00.0',
          isPrimary: true,
          inputType: InputType.CURRENCY,
          initialValue: payment.amount.toString(),
          onSaved: (amount) {
            payment.amount = double.parse(amount);
          },
        ),
        Container(
          color: Colors.transparent,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _toggleBtn(context),
              FormIconButton(label: 'Delete', icon: Icons.delete)
            ],
          ),
        )
      ],
    );
  }

  _labelField() {
    return BoxInput(
      label: 'Label',
      placeholder: 'type short name..',
      inputType: InputType.TEXT,
      initialValue: payment.label,
      onSaved: (label) {
        payment.label = label;
      },
    );
  }

  _categoryField() {
    return PickableBottomSheet(
      builder: (context, sheet) {
        return BoxInput(
          label: 'Category',
          placeholder: 'choose one',
          initialValue: payment.categoryID,
          hasRightBorder: true,
          onClick: () {
            sheet.open(
              'this is title',
              CategoryInputFormField(
                context: context,
                initialValue: payment.categoryID,
                onSelect: (cid) {
                  sheet.close();
                  setState(() {
                    payment.categoryID = cid;
                  });
                },
              ),
            );
          },
        );
      },
    );
  }

  _dateField() {
    return PickableBottomSheet(
      builder: (context, sheet) {
        return BoxInput(
          label: 'Payment date',
          placeholder: 'today',
          initialValue: DateUtil().showFormattedDayOfMonth(
              DateTime.fromMillisecondsSinceEpoch(payment.date)),
          onClick: () {
            sheet.open(
              'pick a day',
              DayInputFormField(
                context: context,
                initialValue: DateTime.fromMillisecondsSinceEpoch(payment.date),
                onSelect: (dt) {
                  setState(() {
                    payment.date = dt.millisecondsSinceEpoch;
                  });
                  sheet.close();
                },
              ),
            );
          },
        );
      },
    );
  }

  _toggleBtn(context) {
    return ToggleIconFormField(
      context: context,
      truthyData: [Icons.sentiment_satisfied, 'Credit', MonexColors.green],
      falsyData: [Icons.sentiment_dissatisfied, 'Debit', MonexColors.red],
      initialValue: payment.isCredit,
      onSaved: (val) {
        payment.isCredit = val;
      },
    );
  }

  _closeBtn(context) {
    return Container(
      color: MonexColors.primary.withOpacity(0.8),
      height: 58,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white54,
          size: 32,
        ),
        onPressed: () {
          var model = Provider.of<SandwichModel>(context, listen: false);
          model.slideDown();
        },
      ),
    );
  }

  Button _saveBtn() {
    return Button(
      label: 'add entry',
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(payment.toJson());
        }
      },
    );
  }
}
