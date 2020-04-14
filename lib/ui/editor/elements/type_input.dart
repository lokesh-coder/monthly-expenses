import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/ui/editor/elements/icon_card.dart';

class TypeInput extends StatefulWidget {
  const TypeInput({Key key}) : super(key: key);

  @override
  _TypeInputState createState() => _TypeInputState();
}

class _TypeInputState extends State<TypeInput> with TickerProviderStateMixin {
  FormStore formStore = sl<FormStore>();
  AnimationController motionController;
  Animation motionAnimation;
  double size = 1.0;

  @override
  void initState() {
    super.initState();
    motionController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
      lowerBound: 1,
      upperBound: 2,
    );

    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.fastLinearToSlowEaseIn,
    );

    motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          motionController.reverse();
        }
      });
    });

    motionController.addListener(() {
      setState(() {
        size = motionController.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return IconCard(
          child: Transform.scale(scale: size, child: _icon()),
          name: formStore.isCredit ? 'CREDIT' : 'DEBIT',
          onTap: () {
            motionController.forward();
            formStore.changeType(!formStore.isCredit);
          },
        );
      },
    );
  }

  Widget _icon() {
    return Icon(
      formStore.isCredit
          ? Icons.sentiment_satisfied
          : Icons.sentiment_dissatisfied,
      size: 30,
      color: formStore.isCredit ? Clrs.green : Clrs.red,
    );
  }
}
