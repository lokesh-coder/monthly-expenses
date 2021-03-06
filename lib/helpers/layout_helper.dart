import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LayoutHelper {
  static GlobalKey<ScaffoldState> mainPageKey = GlobalKey<ScaffoldState>();

  static bool get isKeyboardOpen {
    return MediaQuery.of(LayoutHelper.mainPageKey.currentContext)
            .viewInsets
            .bottom >
        0;
  }

  static double get screenWidth {
    final BuildContext ctx = LayoutHelper.mainPageKey.currentContext;
    return MediaQuery.of(ctx).size.width;
  }

  static double get screenHeight {
    final ctx = LayoutHelper.mainPageKey.currentContext;
    return MediaQuery.of(ctx).size.height;
  }

  static double get statusBarHeight {
    final BuildContext ctx = LayoutHelper.mainPageKey.currentContext;
    return MediaQuery.of(ctx).padding.top;
  }

  static double get appBarHeight {
    // return kToolbarHeight;
    return 0;
  }

  static bool get isReleaseMode => kReleaseMode;
}
