import 'package:flutter/material.dart';
import 'package:monex/source/dao/payment.dao.dart';
import 'package:monex/source/models/payment.model.dart';
import 'package:monex/source/seed.dart';

class PaymentsModel with ChangeNotifier {
  List<Payment> payments = [];
  bool isLoading = false;

  fetchPayments() async {
    isLoading = true;
    List<Payment> paymentsFromDB = await PaymentDao().getAllPayments();
    isLoading = false;
    payments = paymentsFromDB;
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

  seed() async {
    await PaymentDao().dropDb();
    await PaymentDao().dumpData(SeedData().data);
    fetchPayments();
  }
}
