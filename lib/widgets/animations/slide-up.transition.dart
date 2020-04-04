import 'package:flutter/material.dart';
import 'package:monex/widgets/modules/sandwich/model.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: widget.contentHeight).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOutQuint,
      ),
    )..addListener(() {
        Provider.of<SandwichModel>(context, listen: false)
            .setYDistance((animation.value / widget.contentHeight).abs());
        setState(() {});
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var isRevealed =
        Provider.of<SandwichModel>(context, listen: true).isRevealed;
    if (isRevealed) {
      controller.forward();
    } else {
      controller.reverse();
    }
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
  }
}
