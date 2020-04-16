import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/form/form.store.dart';

class IconCard extends StatefulWidget {
  final Widget child;
  final String name;
  final Function onTap;
  final storeKey;

  const IconCard({Key key, this.child, this.name, this.onTap, this.storeKey})
      : super(key: key);

  @override
  _IconCardState createState() => _IconCardState();
}

class _IconCardState extends State<IconCard> with TickerProviderStateMixin {
  FormStore formStore = sl<FormStore>();
  AnimationController motionController;
  Animation motionAnimation;
  double size = 1.0;
  ReactionDisposer disposer;

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

    disposer = reaction((_) => widget.storeKey(), (x) {
      motionController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: size,
              child: SizedBox(
                child: widget.child,
                height: 35,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.name,
              style: TextStyle(
                color: Clrs.inputLabel,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    disposer();
    motionController.dispose();
  }
}