import 'package:mobx/mobx.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/models/payment.model.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';

part 'form.store.g.dart';

class FormStore = FormBase with _$FormStore;

abstract class FormBase with Store {
  PaymentsStore paymentsStore = sl<PaymentsStore>();
  SandwichStore sandwichStore = sl<SandwichStore>();

  @observable
  String id;

  @observable
  num amount;

  @observable
  String label;

  @observable
  bool isCredit = true;

  @observable
  String categoryID;

  @observable
  int date;

  @observable
  bool isNew = true;

  @action
  void changeAmount(num value) {
    amount = value;
  }

  @action
  void changeLabel(String value) {
    label = value;
  }

  @action
  void changeType(bool value) {
    isCredit = value;
  }

  @action
  void changeCategoryID(String value) {
    categoryID = value;
  }

  @action
  void changeDate(int value) {
    date = value;
  }

  @action
  void reset() {
    var isDebit = paymentsStore.filterBy == PaymentType.DEBIT;
    var date = paymentsStore.activeMonth == null
        ? DateHelper.toMs
        : DateHelper.dtToMs(paymentsStore.activeMonth);

    amount = null;
    label = null;
    categoryID = null;
    isCredit = !isDebit;
    date = date;
    isNew = true;
  }

  @action
  populate() {
    Payment payment = paymentsStore.getPayment(paymentsStore.active);

    id = payment.id;
    amount = payment.amount;
    label = payment.label;
    categoryID = payment.categoryID;
    isCredit = payment.isCredit;
    date = payment.date;
    isNew = false;
  }

  @action
  initForm() {
    if (sandwichStore.isOpen && paymentsStore.active != null) {
      populate();
    } else {
      reset();
    }
  }

  @computed
  get data {
    Payment payment = new Payment();
    payment.lastModifiedTime = DateHelper.toMs;
    if (isNew) payment.createdTime = payment.lastModifiedTime;

    payment.id = id;
    payment.amount = amount;
    payment.label = label;
    payment.categoryID = categoryID;
    payment.isCredit = isCredit;
    payment.date = date;

    return payment;
  }
}
