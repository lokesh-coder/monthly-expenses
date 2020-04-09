// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sandwich.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SandwichStore on SandwichBase, Store {
  final _$isOpenAtom = Atom(name: 'SandwichBase.isOpen');

  @override
  bool get isOpen {
    _$isOpenAtom.context.enforceReadPolicy(_$isOpenAtom);
    _$isOpenAtom.reportObserved();
    return super.isOpen;
  }

  @override
  set isOpen(bool value) {
    _$isOpenAtom.context.conditionallyRunInAction(() {
      super.isOpen = value;
      _$isOpenAtom.reportChanged();
    }, _$isOpenAtom, name: '${_$isOpenAtom.name}_set');
  }

  final _$topOffsetAtom = Atom(name: 'SandwichBase.topOffset');

  @override
  double get topOffset {
    _$topOffsetAtom.context.enforceReadPolicy(_$topOffsetAtom);
    _$topOffsetAtom.reportObserved();
    return super.topOffset;
  }

  @override
  set topOffset(double value) {
    _$topOffsetAtom.context.conditionallyRunInAction(() {
      super.topOffset = value;
      _$topOffsetAtom.reportChanged();
    }, _$topOffsetAtom, name: '${_$topOffsetAtom.name}_set');
  }

  final _$SandwichBaseActionController = ActionController(name: 'SandwichBase');

  @override
  void changeVisibility(bool value) {
    final _$actionInfo = _$SandwichBaseActionController.startAction();
    try {
      return super.changeVisibility(value);
    } finally {
      _$SandwichBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeOffset(double value) {
    final _$actionInfo = _$SandwichBaseActionController.startAction();
    try {
      return super.changeOffset(value);
    } finally {
      _$SandwichBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isOpen: ${isOpen.toString()},topOffset: ${topOffset.toString()}';
    return '{$string}';
  }
}
