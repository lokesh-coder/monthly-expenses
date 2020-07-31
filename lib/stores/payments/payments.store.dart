import 'package:mobx/mobx.dart';
import 'package:monthlyexp/data/data_repository.dart';
import 'package:monthlyexp/data/local/db/seed.dart';
import 'package:monthlyexp/helpers/date_helper.dart';
import 'package:monthlyexp/helpers/payment_helper.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/models/payment.model.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';

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
  PaymentType filterBy = PaymentType.ALL;

  @observable
  DateTime activeMonth;

  @computed
  num get totalAmountOfActiveMonth {
    final monthlyPayments = getPaymentsForMonth(activeMonth);
    return PaymentsHelper.calcTotalAmount(monthlyPayments);
  }

  @computed
  Map get inOutStatement {
    final monthlyPayments = getPaymentsForMonth(activeMonth, false);
    return PaymentsHelper.getInOutStatement(monthlyPayments, filterBy);
  }

  @action
  void changeFilter(PaymentType filterValue) {
    filterBy = filterValue;
  }

  @computed
  ObservableMap<String, List<Payment>> get paymentsByMonth {
    return groupPaymentsByMonth().asObservable();
  }

  @computed
  ObservableMap<String, List<Payment>> get paymentsByMonthWithoutFilter {
    return groupPaymentsByMonth(false).asObservable();
  }

  @action
  void setActivePayment(String paymentID) {
    active = paymentID;
  }

  @action
  void setActiveMonth(DateTime dt) {
    activeMonth = dt;
  }

  @action
  Future fetchPayments() async {
    isLoading = true;
    final paymentsFromDB = await repo.db.getAllPayments();
    isLoading = false;
    payments = paymentsFromDB.asObservable();
  }

  @action
  Future<String> insertPayment(Payment payment) async {
    final String lastInsertedID = await repo.db.insertPayment(payment);
    await fetchPayments();
    return lastInsertedID;
  }

  @action
  Future updatePayment(Payment payment) async {
    await repo.db.updatePayment(payment);
    await fetchPayments();
  }

  @action
  Future deletePayment(String paymentID) async {
    await repo.db.delete(Payment(id: paymentID));
    await fetchPayments();
  }

  @action
  Future dropDb() async {
    await repo.db.dropDb();
    await fetchPayments();
  }

  @action
  Future seed() async {
    await repo.db.dropDb();
    await repo.db.dumpData(SeedData().data);
    await fetchPayments();
  }

  List<Payment> getPaymentsForMonth(DateTime dt, [bool withFilter = true]) {
    final String monthKey = DateHelper.getMonthYear(dt);
    final monthlyPayments =
        withFilter ? paymentsByMonth : paymentsByMonthWithoutFilter;
    if (monthlyPayments[monthKey] == null) {
      return [];
    }
    return monthlyPayments[monthKey];
  }

  Payment getPayment(String paymentID) {
    return PaymentsHelper.getPaymentFromID(payments, paymentID);
  }

  Map<String, List<Payment>> groupPaymentsByMonth([bool withFilter = true]) {
    final allPayments = withFilter ? filterPaymentByType(payments) : payments;
    return PaymentsHelper.groupByMonth(allPayments);
  }

  ObservableList<Payment> filterPaymentByType(
    ObservableList<Payment> payments,
  ) {
    final p = PaymentsHelper.filter(payments, filterBy);

    final sortID = sl<SettingsStore>().sortBy;
    final orderID = sl<SettingsStore>().orderBy;
    if (sortID != null) {
      PaymentsHelper.sort(p, sortID, orderID);
    }

    return p.asObservable();
  }
}
