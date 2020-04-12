import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';

class TypeInput extends StatefulWidget {
  final bool value;
  final Function(bool) onTap;
  const TypeInput({
    Key key,
    this.value,
    this.onTap,
  }) : super(key: key);

  @override
  _TypeInputState createState() => _TypeInputState();
}

class _TypeInputState extends State<TypeInput> with TickerProviderStateMixin {
  AnimationController motionController;
  Animation motionAnimation;
  double size = 1.0;
  bool currVal;

  @override
  void initState() {
    super.initState();
    currVal = widget.value;
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
  didUpdateWidget(x) {
    super.didUpdateWidget(x);
    setState(() {
      currVal = widget.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currVal = !currVal;
        });
        motionController.forward();
        widget.onTap(currVal);
      },
      child: Container(
        width: 80,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(scale: size, child: _icon()),
            SizedBox(height: 10),
            _label(),
          ],
        ),
      ),
    );
  }

  Widget _label() {
    return Text(
      currVal ? 'CREDIT' : 'DEBIT',
      style: TextStyle(
        color: Clrs.inputLabel,
        fontWeight: FontWeight.w600,
        fontSize: 11,
      ),
    );
  }

  Widget _icon() {
    return Icon(
      currVal ? Icons.sentiment_satisfied : Icons.sentiment_dissatisfied,
      size: 27,
      color: currVal ? Clrs.green : Clrs.red,
    );
  }
}
