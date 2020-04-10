import 'package:flutter/material.dart';
import 'package:monex/widgets/shared/app-shell.dart';

class LayoutHelper {
  static bool get isKeyboardOpen {
    return MediaQuery.of(scaffoldKey.currentContext).viewInsets.bottom > 0;
  }

  static double get screenWidth {
    return MediaQuery.of(scaffoldKey.currentContext).size.width;
  }

  static double get screenHeight {
    return MediaQuery.of(scaffoldKey.currentContext).size.height;
  }

  static double get statusBarHeight {
    return MediaQuery.of(scaffoldKey.currentContext).padding.top;
  }

  static double get appBarHeight {
    return kToolbarHeight;
  }
}
