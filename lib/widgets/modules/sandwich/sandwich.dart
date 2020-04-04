import 'package:flutter/material.dart';
import 'package:monex/widgets/animations/slide-up.transition.dart';

class Sandwich extends StatelessWidget {
  final Widget bottomChild;
  final Widget middleChild;
  final Widget topChild;
  final double translateOffset;
  final double safeHeight;
  final double dynamicContent;
  final double visibleContentHeight;

  const Sandwich({
    Key key,
    this.bottomChild,
    this.middleChild,
    this.topChild,
    this.translateOffset,
    this.safeHeight,
    this.dynamicContent,
    this.visibleContentHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('CALLL');
    return Stack(
      // fit: StackFit.expand,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: (translateOffset + visibleContentHeight).abs(),
          ),
          child: bottomChild,
        ),
        Builder(builder: (context) {
          double screenHeight = MediaQuery.of(context).size.height;
          double appbarHeight = kToolbarHeight;
          double translateDistance =
              screenHeight - (translateOffset + safeHeight + appbarHeight);
          double contentHeight = -(translateDistance - visibleContentHeight);
          return SlideUpTransition(
            contentHeight: contentHeight,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height -
                      kToolbarHeight -
                      safeHeight,
                ),
                child: Container(
                  color: Colors.white,
                  child: middleChild,
                  margin: EdgeInsets.only(
                    top: translateOffset + dynamicContent,
                  ),
                ),
              ),
            ),
          );
        }),
        SizedBox(
          height: translateOffset + dynamicContent,
          child: Container(
            // color: Colors.pink,
            child: topChild,
          ),
        )
      ],
    );
  }
}
