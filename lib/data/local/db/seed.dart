import 'package:monex/models/payment.model.dart';

class SeedData {
  final List<Payment> data = [
    Payment(
      amount: 24500,
      categoryID: 'GENERAL',
      createdTime: DateTime.now().millisecondsSinceEpoch,
      date: DateTime.now().millisecondsSinceEpoch,
      isCredit: true,
      label: 'testing',
      lastModifiedTime: null,
      id: null,
    )
  ];
}
