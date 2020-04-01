import 'package:flutter/material.dart';
import 'package:monex/widgets/animations/slide-up.transition.dart';
import 'package:monex/widgets/modules/sandwich/model.dart';
import 'package:provider/provider.dart';

class Sandwich extends StatelessWidget {
  final Widget bottomChild;
  final Widget middleChild;
  final Widget topChild;
  final double translateOffset;
  final double safeHeight;
  final double visibleContentHeight;

  const Sandwich({
    Key key,
    this.bottomChild,
    this.middleChild,
    this.topChild,
    this.translateOffset,
    this.safeHeight,
    this.visibleContentHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('TOP ${MediaQuery.of(context).padding.top}');

    return ChangeNotifierProvider(
      create: (_) => SandwichModel(),
      child: Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: (translateOffset - safeHeight).abs(),
            ),
            child: bottomChild,
          ),
          Consumer<SandwichModel>(
            child: Container(
              color: Colors.white,
              child: middleChild,
              margin: EdgeInsets.only(
                top: translateOffset,
              ),
            ),
            builder: (context, sandwich, child) {
              double screenHeight = MediaQuery.of(context).size.height;
              double translateDistance =
                  screenHeight - (translateOffset + safeHeight);
              double offset = sandwich.isRevealed
                  ? -(translateDistance - visibleContentHeight)
                  : 0.0;
              return SlideUpTransition(
                offset: offset,
                child: child,
              );
            },
          ),
          SizedBox(
            height: translateOffset,
            child: Container(
              // color: Colors.pink,
              child: topChild,
            ),
          )
        ],
      ),
    );
  }
}
