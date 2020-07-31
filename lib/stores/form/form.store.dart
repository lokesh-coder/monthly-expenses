import 'package:mobx/mobx.dart';
import 'package:monthlyexp/data/data_repository.dart';
import 'package:monthlyexp/data/local/object/files/categories.dart';
import 'package:monthlyexp/helpers/date_helper.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/models/payment.model.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:monthlyexp/stores/sandwiich/sandwich.store.dart';

part 'form.store.g.dart';

class FormStore = FormBase with _$FormStore;

abstract class FormBase with Store {
  DataRepo repo;
  FormBase(this.repo);

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
    final isDebit = paymentsStore.filterBy == PaymentType.DEBIT;
    final dateInMs = paymentsStore.activeMonth == null
        ? DateHelper.toMs
        : DateHelper.dtToMs(paymentsStore.activeMonth);

    amount = null;
    label = null;
    categoryID = repo.obj.get<Catagories>('categories').defaultCategory.id;
    isCredit = !isDebit;
    date = dateInMs;
    isNew = true;
    id = null;
  }

  @action
  void populate() {
    final Payment payment = paymentsStore.getPayment(paymentsStore.active);

    id = payment.id;
    amount = payment.amount;
    label = payment.label;
    categoryID = payment.categoryID;
    isCredit = payment.isCredit;
    date = payment.date;
    isNew = false;
  }

  @action
  void initForm() {
    if (sandwichStore.isOpen && paymentsStore.active != null) {
      populate();
    } else {
      reset();
    }
  }

  @computed
  Payment get data {
    final Payment payment = Payment()..lastModifiedTime = DateHelper.toMs;
    if (isNew) {
      payment.createdTime = payment.lastModifiedTime;
    }

    payment
      ..id = id
      ..amount = amount
      ..label = label
      ..categoryID = categoryID
      ..isCredit = isCredit
      ..date = date;

    return payment;
  }
}
