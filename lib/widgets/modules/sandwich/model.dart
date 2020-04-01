import 'package:flutter/foundation.dart';

class SandwichModel with ChangeNotifier {
  bool _isRevealed = false;
  double _yDistance = 0;

  bool get isRevealed => _isRevealed;
  double get yDistance => _yDistance;

  void slideUp() {
    _isRevealed = true;
    notifyListeners();
  }

  void slideDown() {
    _isRevealed = false;
    notifyListeners();
  }

  void setYDistance(double value) {
    _yDistance = value;
    notifyListeners();
  }
}
