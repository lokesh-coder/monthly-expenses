// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on SettingsBase, Store {
  final _$monthsViewRangeAtom = Atom(name: 'SettingsBase.monthsViewRange');

  @override
  int get monthsViewRange {
    _$monthsViewRangeAtom.context.enforceReadPolicy(_$monthsViewRangeAtom);
    _$monthsViewRangeAtom.reportObserved();
    return super.monthsViewRange;
  }

  @override
  set monthsViewRange(int value) {
    _$monthsViewRangeAtom.context.conditionallyRunInAction(() {
      super.monthsViewRange = value;
      _$monthsViewRangeAtom.reportChanged();
    }, _$monthsViewRangeAtom, name: '${_$monthsViewRangeAtom.name}_set');
  }

  final _$sortByAtom = Atom(name: 'SettingsBase.sortBy');

  @override
  int get sortBy {
    _$sortByAtom.context.enforceReadPolicy(_$sortByAtom);
    _$sortByAtom.reportObserved();
    return super.sortBy;
  }

  @override
  set sortBy(int value) {
    _$sortByAtom.context.conditionallyRunInAction(() {
      super.sortBy = value;
      _$sortByAtom.reportChanged();
    }, _$sortByAtom, name: '${_$sortByAtom.name}_set');
  }

  final _$orderByAtom = Atom(name: 'SettingsBase.orderBy');

  @override
  int get orderBy {
    _$orderByAtom.context.enforceReadPolicy(_$orderByAtom);
    _$orderByAtom.reportObserved();
    return super.orderBy;
  }

  @override
  set orderBy(int value) {
    _$orderByAtom.context.conditionallyRunInAction(() {
      super.orderBy = value;
      _$orderByAtom.reportChanged();
    }, _$orderByAtom, name: '${_$orderByAtom.name}_set');
  }

  final _$SettingsBaseActionController = ActionController(name: 'SettingsBase');

  @override
  void changeMonthsViewRange(int range) {
    final _$actionInfo = _$SettingsBaseActionController.startAction();
    try {
      return super.changeMonthsViewRange(range);
    } finally {
      _$SettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSortBy(int id) {
    final _$actionInfo = _$SettingsBaseActionController.startAction();
    try {
      return super.changeSortBy(id);
    } finally {
      _$SettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeOrderBy(int id) {
    final _$actionInfo = _$SettingsBaseActionController.startAction();
    try {
      return super.changeOrderBy(id);
    } finally {
      _$SettingsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'monthsViewRange: ${monthsViewRange.toString()},sortBy: ${sortBy.toString()},orderBy: ${orderBy.toString()}';
    return '{$string}';
  }
}
