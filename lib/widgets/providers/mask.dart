import 'package:flutter/widgets.dart';

class MaskProvider extends InheritedWidget {
  final Widget child;
  final bool isRevealed;
  final Function open;
  final Function close;
  MaskProvider({Key key, this.child, this.isRevealed, this.open, this.close})
      : super(key: key, child: child);

  static MaskProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MaskProvider>();
  }

  @override
  bool updateShouldNotify(MaskProvider oldWidget) {
    return isRevealed != oldWidget.isRevealed;
  }
}
