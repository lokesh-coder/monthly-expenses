import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';

class SlideUpTransition extends StatefulWidget {
  final double contentHeight;
  final Widget child;

  const SlideUpTransition({Key key, this.contentHeight, this.child})
      : super(key: key);

  @override
  _SlideUpTransitionState createState() => _SlideUpTransitionState();
}

class _SlideUpTransitionState extends State<SlideUpTransition>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  ReactionDisposer storeDispose;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: widget.contentHeight).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutQuint,
      ),
    )..addListener(() {
        double offset = (animation.value / widget.contentHeight).abs();
        sl<SandwichStore>().changeOffset(offset);
        setState(() {});
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reaction((_) => sl<SandwichStore>().isOpen, (isOpen) {
      if (isOpen) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: animation.value,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    storeDispose();
  }
}
