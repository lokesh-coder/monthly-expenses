// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on FormBase, Store {
  Computed<dynamic> _$dataComputed;

  @override
  dynamic get data =>
      (_$dataComputed ??= Computed<dynamic>(() => super.data)).value;

  final _$idAtom = Atom(name: 'FormBase.id');

  @override
  String get id {
    _$idAtom.context.enforceReadPolicy(_$idAtom);
    _$idAtom.reportObserved();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.context.conditionallyRunInAction(() {
      super.id = value;
      _$idAtom.reportChanged();
    }, _$idAtom, name: '${_$idAtom.name}_set');
  }

  final _$amountAtom = Atom(name: 'FormBase.amount');

  @override
  num get amount {
    _$amountAtom.context.enforceReadPolicy(_$amountAtom);
    _$amountAtom.reportObserved();
    return super.amount;
  }

  @override
  set amount(num value) {
    _$amountAtom.context.conditionallyRunInAction(() {
      super.amount = value;
      _$amountAtom.reportChanged();
    }, _$amountAtom, name: '${_$amountAtom.name}_set');
  }

  final _$labelAtom = Atom(name: 'FormBase.label');

  @override
  String get label {
    _$labelAtom.context.enforceReadPolicy(_$labelAtom);
    _$labelAtom.reportObserved();
    return super.label;
  }

  @override
  set label(String value) {
    _$labelAtom.context.conditionallyRunInAction(() {
      super.label = value;
      _$labelAtom.reportChanged();
    }, _$labelAtom, name: '${_$labelAtom.name}_set');
  }

  final _$isCreditAtom = Atom(name: 'FormBase.isCredit');

  @override
  bool get isCredit {
    _$isCreditAtom.context.enforceReadPolicy(_$isCreditAtom);
    _$isCreditAtom.reportObserved();
    return super.isCredit;
  }

  @override
  set isCredit(bool value) {
    _$isCreditAtom.context.conditionallyRunInAction(() {
      super.isCredit = value;
      _$isCreditAtom.reportChanged();
    }, _$isCreditAtom, name: '${_$isCreditAtom.name}_set');
  }

  final _$categoryIDAtom = Atom(name: 'FormBase.categoryID');

  @override
  String get categoryID {
    _$categoryIDAtom.context.enforceReadPolicy(_$categoryIDAtom);
    _$categoryIDAtom.reportObserved();
    return super.categoryID;
  }

  @override
  set categoryID(String value) {
    _$categoryIDAtom.context.conditionallyRunInAction(() {
      super.categoryID = value;
      _$categoryIDAtom.reportChanged();
    }, _$categoryIDAtom, name: '${_$categoryIDAtom.name}_set');
  }

  final _$dateAtom = Atom(name: 'FormBase.date');

  @override
  int get date {
    _$dateAtom.context.enforceReadPolicy(_$dateAtom);
    _$dateAtom.reportObserved();
    return super.date;
  }

  @override
  set date(int value) {
    _$dateAtom.context.conditionallyRunInAction(() {
      super.date = value;
      _$dateAtom.reportChanged();
    }, _$dateAtom, name: '${_$dateAtom.name}_set');
  }

  final _$isNewAtom = Atom(name: 'FormBase.isNew');

  @override
  bool get isNew {
    _$isNewAtom.context.enforceReadPolicy(_$isNewAtom);
    _$isNewAtom.reportObserved();
    return super.isNew;
  }

  @override
  set isNew(bool value) {
    _$isNewAtom.context.conditionallyRunInAction(() {
      super.isNew = value;
      _$isNewAtom.reportChanged();
    }, _$isNewAtom, name: '${_$isNewAtom.name}_set');
  }

  final _$FormBaseActionController = ActionController(name: 'FormBase');

  @override
  void changeAmount(num value) {
    final _$actionInfo = _$FormBaseActionController.startAction();
    try {
      return super.changeAmount(value);
    } finally {
      _$FormBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLabel(String value) {
    final _$actionInfo = _$FormBaseActionController.startAction();
    try {
      return super.changeLabel(value);
    } finally {
      _$FormBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeType(bool value) {
    final _$actionInfo = _$FormBaseActionController.startAction();
    try {
      return super.changeType(value);
    } finally {
      _$FormBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCategoryID(String value) {
    final _$actionInfo = _$FormBaseActionController.startAction();
    try {
      return super.changeCategoryID(value);
    } finally {
      _$FormBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDate(int value) {
    final _$actionInfo = _$FormBaseActionController.startAction();
    try {
      return super.changeDate(value);
    } finally {
      _$FormBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$FormBaseActionController.startAction();
    try {
      return super.reset();
    } finally {
      _$FormBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic populate() {
    final _$actionInfo = _$FormBaseActionController.startAction();
    try {
      return super.populate();
    } finally {
      _$FormBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic initForm() {
    final _$actionInfo = _$FormBaseActionController.startAction();
    try {
      return super.initForm();
    } finally {
      _$FormBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'id: ${id.toString()},amount: ${amount.toString()},label: ${label.toString()},isCredit: ${isCredit.toString()},categoryID: ${categoryID.toString()},date: ${date.toString()},isNew: ${isNew.toString()},data: ${data.toString()}';
    return '{$string}';
  }
}
