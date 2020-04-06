import 'package:flutter/material.dart';
import 'package:monex/models/DateUtil.dart';
import 'package:monex/source/dao/payment.dao.dart';
import 'package:monex/source/models/payment.model.dart';
import 'package:monex/source/seed.dart';
import "package:collection/collection.dart";

class PaymentsModel with ChangeNotifier {
  List<Payment> payments = [];
  Map<String, List<Payment>> paymentsByMonth = {};
  bool isLoading = false;
  String active;
  DateTime activeMonth;

  setActivePayment(String paymentID) {
    active = paymentID;
    notifyListeners();
  }

  setActiveMonth(DateTime dt) {
    activeMonth = dt;
    notifyListeners();
  }

  fetchPayments() async {
    isLoading = true;
    List<Payment> paymentsFromDB = await PaymentDao().getAllPayments();
    isLoading = false;
    payments = paymentsFromDB;
    paymentsByMonth = Map.from(groupPaymentsByMonth());
    notifyListeners();
  }

  insertPayment(Payment payment) async {
    String lastInsertedID = await PaymentDao().insertPayment(payment);
    fetchPayments();
    return lastInsertedID;
  }

  updatePayment(Payment payment) async {
    await PaymentDao().updatePayment(payment);
    fetchPayments();
  }

  deletePayment(String paymentID) async {
    await PaymentDao().delete(Payment(id: paymentID));
    fetchPayments();
  }

  getPayments() {
    return payments;
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

  dropDb() async {
    await PaymentDao().dropDb();
  }

  seed() async {
    await PaymentDao().dropDb();
    await PaymentDao().dumpData(SeedData().data);
    fetchPayments();
  }
}
