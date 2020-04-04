import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/widgets/CategoryPicker.dart';
import 'package:monex/widgets/DueDayPicker.dart';
import 'package:monex/widgets/shared/PickableBottomSheet.dart';
import 'package:monex/widgets/shared/box-input.dart';
import 'package:monex/widgets/shared/button.dart';
import 'package:monex/widgets/shared/form-icon-button.dart';
import 'package:provider/provider.dart';

import 'modules/sandwich/model.dart';

class PaymentForm extends StatelessWidget {
  const PaymentForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SandwichModel sandwichModel =
        Provider.of<SandwichModel>(context, listen: false);

    return Form(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      BoxInput(
                        label: 'hello',
                        placeholder: '00.0',
                        isPrimary: true,
                        inputType: InputType.CURRENCY,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FormIconButton(
                            label: 'Credit',
                            color: MonexColors.green,
                            icon: Icons.face,
                          ),
                          FormIconButton(
                            label: 'Delete',
                            icon: Icons.delete,
                          )
                        ],
                      )
                    ],
                  ),
                  BoxInput(
                    label: 'Label',
                    placeholder: 'type short name..',
                    inputType: InputType.TEXT,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: PickableBottomSheet(builder: (context, sheet) {
                          return BoxInput(
                            label: 'Category',
                            placeholder: 'choose one',
                            hasRightBorder: true,
                            onClick: () {
                              sheet.open('this is title', CategoryPicker());
                            },
                          );
                        }),
                      ),
                      Expanded(
                        flex: 1,
                        child: PickableBottomSheet(builder: (context, sheet) {
                          return BoxInput(
                            label: 'Payment date',
                            placeholder: 'today',
                            onClick: () {
                              // print('you vlicked date..');
                              sheet.open('pick a day', DueDayPicker());
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Button(
                  label: 'add entry',
                  onPressed: () {},
                ),
              ),
              Container(
                color: MonexColors.primary.withOpacity(0.8),
                height: 58,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white54,
                    size: 32,
                  ),
                  // color: MonexColors.primary,
                  onPressed: () {
                    sandwichModel.slideDown();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
