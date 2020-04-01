import 'package:flutter/material.dart';

class SlideUpTransition extends StatelessWidget {
  final double offset;
  final Widget child;

  const SlideUpTransition({Key key, this.offset, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: offset),
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOutQuint,
      builder: (ctx, val, _) {
        return Transform.translate(offset: Offset(0, val), child: child);
      },
    );
  }
}
