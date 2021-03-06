// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PaymentsStore on PaymentsBase, Store {
  Computed<num> _$totalAmountOfActiveMonthComputed;

  @override
  num get totalAmountOfActiveMonth => (_$totalAmountOfActiveMonthComputed ??=
          Computed<num>(() => super.totalAmountOfActiveMonth))
      .value;
  Computed<Map<dynamic, dynamic>> _$inOutStatementComputed;

  @override
  Map<dynamic, dynamic> get inOutStatement => (_$inOutStatementComputed ??=
          Computed<Map<dynamic, dynamic>>(() => super.inOutStatement))
      .value;
  Computed<ObservableMap<String, List<Payment>>> _$paymentsByMonthComputed;

  @override
  ObservableMap<String, List<Payment>> get paymentsByMonth =>
      (_$paymentsByMonthComputed ??=
              Computed<ObservableMap<String, List<Payment>>>(
                  () => super.paymentsByMonth))
          .value;
  Computed<ObservableMap<String, List<Payment>>>
      _$paymentsByMonthWithoutFilterComputed;

  @override
  ObservableMap<String, List<Payment>> get paymentsByMonthWithoutFilter =>
      (_$paymentsByMonthWithoutFilterComputed ??=
              Computed<ObservableMap<String, List<Payment>>>(
                  () => super.paymentsByMonthWithoutFilter))
          .value;

  final _$paymentsAtom = Atom(name: 'PaymentsBase.payments');

  @override
  ObservableList<Payment> get payments {
    _$paymentsAtom.context.enforceReadPolicy(_$paymentsAtom);
    _$paymentsAtom.reportObserved();
    return super.payments;
  }

  @override
  set payments(ObservableList<Payment> value) {
    _$paymentsAtom.context.conditionallyRunInAction(() {
      super.payments = value;
      _$paymentsAtom.reportChanged();
    }, _$paymentsAtom, name: '${_$paymentsAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: 'PaymentsBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$activeAtom = Atom(name: 'PaymentsBase.active');

  @override
  String get active {
    _$activeAtom.context.enforceReadPolicy(_$activeAtom);
    _$activeAtom.reportObserved();
    return super.active;
  }

  @override
  set active(String value) {
    _$activeAtom.context.conditionallyRunInAction(() {
      super.active = value;
      _$activeAtom.reportChanged();
    }, _$activeAtom, name: '${_$activeAtom.name}_set');
  }

  final _$filterByAtom = Atom(name: 'PaymentsBase.filterBy');

  @override
  PaymentType get filterBy {
    _$filterByAtom.context.enforceReadPolicy(_$filterByAtom);
    _$filterByAtom.reportObserved();
    return super.filterBy;
  }

  @override
  set filterBy(PaymentType value) {
    _$filterByAtom.context.conditionallyRunInAction(() {
      super.filterBy = value;
      _$filterByAtom.reportChanged();
    }, _$filterByAtom, name: '${_$filterByAtom.name}_set');
  }

  final _$activeMonthAtom = Atom(name: 'PaymentsBase.activeMonth');

  @override
  DateTime get activeMonth {
    _$activeMonthAtom.context.enforceReadPolicy(_$activeMonthAtom);
    _$activeMonthAtom.reportObserved();
    return super.activeMonth;
  }

  @override
  set activeMonth(DateTime value) {
    _$activeMonthAtom.context.conditionallyRunInAction(() {
      super.activeMonth = value;
      _$activeMonthAtom.reportChanged();
    }, _$activeMonthAtom, name: '${_$activeMonthAtom.name}_set');
  }

  final _$fetchPaymentsAsyncAction = AsyncAction('fetchPayments');

  @override
  Future<dynamic> fetchPayments() {
    return _$fetchPaymentsAsyncAction.run(() => super.fetchPayments());
  }

  final _$insertPaymentAsyncAction = AsyncAction('insertPayment');

  @override
  Future<String> insertPayment(Payment payment) {
    return _$insertPaymentAsyncAction.run(() => super.insertPayment(payment));
  }

  final _$updatePaymentAsyncAction = AsyncAction('updatePayment');

  @override
  Future<dynamic> updatePayment(Payment payment) {
    return _$updatePaymentAsyncAction.run(() => super.updatePayment(payment));
  }

  final _$deletePaymentAsyncAction = AsyncAction('deletePayment');

  @override
  Future<dynamic> deletePayment(String paymentID) {
    return _$deletePaymentAsyncAction.run(() => super.deletePayment(paymentID));
  }

  final _$dropDbAsyncAction = AsyncAction('dropDb');

  @override
  Future<dynamic> dropDb() {
    return _$dropDbAsyncAction.run(() => super.dropDb());
  }

  final _$seedAsyncAction = AsyncAction('seed');

  @override
  Future<dynamic> seed() {
    return _$seedAsyncAction.run(() => super.seed());
  }

  final _$PaymentsBaseActionController = ActionController(name: 'PaymentsBase');

  @override
  void changeFilter(PaymentType filterValue) {
    final _$actionInfo = _$PaymentsBaseActionController.startAction();
    try {
      return super.changeFilter(filterValue);
    } finally {
      _$PaymentsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setActivePayment(String paymentID) {
    final _$actionInfo = _$PaymentsBaseActionController.startAction();
    try {
      return super.setActivePayment(paymentID);
    } finally {
      _$PaymentsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setActiveMonth(DateTime dt) {
    final _$actionInfo = _$PaymentsBaseActionController.startAction();
    try {
      return super.setActiveMonth(dt);
    } finally {
      _$PaymentsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'payments: ${payments.toString()},isLoading: ${isLoading.toString()},active: ${active.toString()},filterBy: ${filterBy.toString()},activeMonth: ${activeMonth.toString()},totalAmountOfActiveMonth: ${totalAmountOfActiveMonth.toString()},inOutStatement: ${inOutStatement.toString()},paymentsByMonth: ${paymentsByMonth.toString()},paymentsByMonthWithoutFilter: ${paymentsByMonthWithoutFilter.toString()}';
    return '{$string}';
  }
}
