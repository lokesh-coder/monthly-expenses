import 'package:mobx/mobx.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/models/DateUtil.dart';
import 'package:monex/source/models/payment.model.dart';
import 'package:monex/source/seed.dart';
import "package:collection/collection.dart";

part 'payments.store.g.dart';

class PaymentsStore = PaymentsBase with _$PaymentsStore;

abstract class PaymentsBase with Store {
  DataRepo repo;
  PaymentsBase(this.repo);

  @observable
  ObservableList<Payment> payments = ObservableList<Payment>();

  @observable
  bool isLoading = false;

  @observable
  String active;

  @observable
  DateTime activeMonth;

  @computed
  Map<String, List<Payment>> get paymentsByMonth {
    return Map.from(groupPaymentsByMonth());
  }

  @action
  setActivePayment(String paymentID) {
    active = paymentID;
  }

  @action
  setActiveMonth(DateTime dt) {
    activeMonth = dt;
  }

  @action
  fetchPayments() async {
    isLoading = true;
    var paymentsFromDB = await repo.db.getAllPayments();
    isLoading = false;
    payments = paymentsFromDB.asObservable();
  }

  @action
  insertPayment(Payment payment) async {
    String lastInsertedID = await repo.db.insertPayment(payment);
    fetchPayments();
    return lastInsertedID;
  }

  @action
  updatePayment(Payment payment) async {
    await repo.db.updatePayment(payment);
    fetchPayments();
  }

  @action
  deletePayment(String paymentID) async {
    await repo.db.delete(Payment(id: paymentID));
    fetchPayments();
  }

  @action
  dropDb() async {
    await repo.db.dropDb();
  }

  @action
  seed() async {
    await repo.db.dropDb();
    await repo.db.dumpData(SeedData().data);
    fetchPayments();
  }

  getPaymentsForMonth(DateTime dt) {
    String monthKey = DateUtil().getUniqueMonthFormat(dt);
    return paymentsByMonth[monthKey];
  }

  getPayment(String paymentID) {
    return payments.firstWhere((p) {
      return p.id == paymentID;
    }, orElse: () => null);
  }

  Map groupPaymentsByMonth() {
    return groupBy(payments, (Payment p) {
      return DateUtil()
          .getUniqueMonthFormat(DateTime.fromMillisecondsSinceEpoch(p.date));
    });
  }
}
