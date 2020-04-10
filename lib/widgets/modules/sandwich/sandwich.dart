import 'package:flutter/material.dart';
import 'package:monex/helpers/layout_helper.dart';
import 'package:monex/widgets/animations/slide-up.transition.dart';

class Sandwich extends StatelessWidget {
  final Widget bottomChild;
  final Widget middleChild;
  final Widget topChild;
  final double translateOffset;
  final double dynamicContent;
  final double visibleContentHeight;

  const Sandwich({
    Key key,
    this.bottomChild,
    this.middleChild,
    this.topChild,
    this.translateOffset,
    this.dynamicContent,
    this.visibleContentHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            top: (translateOffset + visibleContentHeight).abs(),
          ),
          child: bottomChild,
        ),
        Builder(builder: (context) {
          double safeHeight = LayoutHelper.statusBarHeight;
          double screenHeight = LayoutHelper.screenHeight;
          double appbarHeight = kToolbarHeight;
          double translateDistance =
              screenHeight - (translateOffset + safeHeight + appbarHeight);
          double contentHeight = -(translateDistance - visibleContentHeight);
          return SlideUpTransition(
            contentHeight: contentHeight,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight:
                      screenHeight - LayoutHelper.appBarHeight - safeHeight,
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
