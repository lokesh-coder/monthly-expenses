import 'package:mobx/mobx.dart';

part 'sandwich.store.g.dart';

class SandwichStore = SandwichBase with _$SandwichStore;

abstract class SandwichBase with Store {
  @observable
  bool isOpen = false;

  @observable
  double topOffset = 0.0;

  @action
  void changeVisibility(bool value) {
    isOpen = value;
  }

  @action
  void changeOffset(double value) {
    topOffset = value;
  }
}
