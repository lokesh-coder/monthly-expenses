import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/sandwiich/sandwich.store.dart';

class SlideTransform extends StatefulWidget {
  final double contentHeight;
  final double marginTop;
  final Widget child;

  const SlideTransform({this.contentHeight, this.marginTop, this.child});

  @override
  _SlideTransformState createState() => _SlideTransformState();
}

class _SlideTransformState extends State<SlideTransform>
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
    animation =
        Tween(begin: widget.marginTop, end: widget.contentHeight).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutQuint,
      ),
    )..addListener(() {
            final double offset =
                (animation.value / widget.contentHeight).abs();
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
