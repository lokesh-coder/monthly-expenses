import 'package:mobx/mobx.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/db/seed.dart';
import "package:collection/collection.dart";
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/models/payment.model.dart';

part 'payments.store.g.dart';

enum PaymentType { DEBIT, CREDIT, ALL }

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
  PaymentType filterBy = PaymentType.ALL;

  @observable
  DateTime activeMonth;

  @computed
  get totalAmountOfActiveMonth {
    List<Payment> monthlyPayments = getPaymentsForMonth(activeMonth);
    if (monthlyPayments.length == 0) return 0.0;
    return monthlyPayments
        .map((x) => x.isCredit ? x.amount : -(x.amount))
        .reduce((v, e) => v + e);
  }

  @action
  void changeFilter(filterValue) {
    filterBy = filterValue;
  }

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

  List<Payment> getPaymentsForMonth(DateTime dt) {
    String monthKey = DateHelper.getUniqueMonthFormat(dt);
    if (paymentsByMonth[monthKey] == null) return [];
    return paymentsByMonth[monthKey];
  }

  getPayment(String paymentID) {
    return payments.firstWhere((p) {
      return p.id == paymentID;
    }, orElse: () => null);
  }

  Map groupPaymentsByMonth() {
    var filteredPayments = filterPaymentByType(payments);
    return groupBy(filteredPayments, (Payment p) {
      DateTime dt = DateTime.fromMillisecondsSinceEpoch(p.date);
      return DateHelper.getUniqueMonthFormat(dt);
    });
  }

  ObservableList<Payment> filterPaymentByType(
      ObservableList<Payment> payments) {
    return payments
        .where(
          (p) {
            if (filterBy == PaymentType.ALL) {
              return true;
            }
            if (filterBy == PaymentType.CREDIT) {
              return p.isCredit == true;
            }
            if (filterBy == PaymentType.DEBIT) {
              return p.isCredit == false;
            }

            return false;
          },
        )
        .toList()
        .asObservable();
  }
}
