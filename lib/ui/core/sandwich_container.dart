import 'package:flutter/material.dart';
import 'package:monthlyexp/config/dimensions.dart';
import 'package:monthlyexp/helpers/layout_helper.dart';
import 'package:monthlyexp/ui/core/slide_transform.dart';

class SandwichContainer extends StatelessWidget {
  final Widget bottomChild;
  final Widget middleChild;
  final Widget topChild;

  final double bannerBarH = Dimensions.bannerBarHeight;
  final double monthsBarH = Dimensions.monthsBarHeight;
  final double filtersBarH = Dimensions.filtersBarHeight;

  SandwichContainer({
    this.bottomChild,
    this.middleChild,
    this.topChild,
  });

  double get statusBarH => LayoutHelper.statusBarHeight;
  double get screenH => LayoutHelper.screenHeight;
  double get appbarH => LayoutHelper.appBarHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_bottomChild(), _middleChild(), _topChild()],
    );
  }

  Widget _bottomChild() {
    return Container(
      margin: EdgeInsets.only(top: (bannerBarH + monthsBarH).abs()),
      child: bottomChild,
    );
  }

  Widget _middleChild() {
    return Builder(
      builder: (context) {
        final double topToBannerH = bannerBarH + statusBarH + appbarH;
        final double slidableH = screenH - topToBannerH;
        final double contentHeight = -(slidableH - monthsBarH - statusBarH);

        return SlideTransform(
          contentHeight: contentHeight,
          marginTop: statusBarH,
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxHeight: screenH - appbarH - statusBarH),
            child: Container(
              color: Colors.white,
              child: middleChild,
              margin:
                  EdgeInsets.only(top: bannerBarH + filtersBarH - statusBarH),
            ),
          ),
        );
      },
    );
  }

  Widget _topChild() {
    return Container(
      margin: EdgeInsets.only(top: statusBarH),
      child: SizedBox(
        height: bannerBarH + filtersBarH,
        child: Container(child: topChild),
      ),
    );
  }
}
