import "package:mobx/mobx.dart";
import "package:monex/data/data_repository.dart";
import "package:monex/data/local/db/seed.dart";
import "package:monex/helpers/date_helper.dart";
import "package:monex/helpers/payment_helper.dart";
import "package:monex/models/enums.dart";
import "package:monex/models/payment.model.dart";
import "package:monex/services/service_locator.dart";
import "package:monex/stores/settings/settings.store.dart";

part "payments.store.g.dart";

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
    var monthlyPayments = getPaymentsForMonth(activeMonth);
    return PaymentsHelper.calcTotalAmount(monthlyPayments);
  }

  @computed
  Map get inOutStatement {
    var monthlyPayments = getPaymentsForMonth(activeMonth, false);
    return PaymentsHelper.getInOutStatement(monthlyPayments, filterBy);
  }

  @action
  void changeFilter(filterValue) {
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
    fetchPayments();
  }

  @action
  seed() async {
    await repo.db.dropDb();
    await repo.db.dumpData(SeedData().data);
    fetchPayments();
  }

  List<Payment> getPaymentsForMonth(DateTime dt, [bool withFilter = true]) {
    String monthKey = DateHelper.getMonthYear(dt);
    var monthlyPayments =
        withFilter ? paymentsByMonth : paymentsByMonthWithoutFilter;
    if (monthlyPayments[monthKey] == null) return [];
    return monthlyPayments[monthKey];
  }

  Payment getPayment(String paymentID) {
    return PaymentsHelper.getPaymentFromID(payments, paymentID);
  }

  Map<String, List<Payment>> groupPaymentsByMonth([bool withFilter = true]) {
    var allPayments = withFilter ? filterPaymentByType(payments) : payments;
    return PaymentsHelper.groupByMonth(allPayments);
  }

  ObservableList<Payment> filterPaymentByType(
    ObservableList<Payment> payments,
  ) {
    var p = PaymentsHelper.filter(payments, filterBy);

    var sortID = sl<SettingsStore>().sortBy;
    var orderID = sl<SettingsStore>().orderBy;
    if (sortID != null) PaymentsHelper.sort(p, sortID, orderID);

    return p.asObservable();
  }
}
