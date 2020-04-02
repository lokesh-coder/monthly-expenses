import 'package:monex/source/models/payment.model.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

import '../db.setup.dart';

class PaymentDao {
  static const String folderName = "Payments";
  final _table = intMapStoreFactory.store(folderName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  dumpData(List data) async {
    for (var d = 0; d < data.length; d++) {
      await _table.add(await _db, {
        "id": Uuid().v1(),
        "label": data[d].label,
        "createdTime": data[d].createdTime,
        "lastModifiedTime": data[d].lastModifiedTime,
        "date": data[d].date,
        "isCredit": data[d].isCredit,
        "amount": data[d].amount,
        "categoryID": data[d].categoryID,
      });
    }
  }

  Future insertPayment(Payment payment) async {
    Map paymentJson = payment.toJson();
    paymentJson['id'] = Uuid().v1();
    paymentJson['createdTime'] = DateTime.now().millisecondsSinceEpoch;
    await _table.add(await _db, paymentJson);
    return paymentJson['id'];
  }

  Future updatePayment(Payment payment) async {
    final finder = Finder(filter: Filter.equals('id', payment.id));
    await _table.update(await _db, payment.toJson(), finder: finder);
  }

  Future delete(Payment payment) async {
    final finder = Finder(filter: Filter.equals('id', payment.id));
    await _table.delete(await _db, finder: finder);
  }

  Future dropDb() async {
    await _table.drop(await _db);
  }

  Future<RecordSnapshot<int, Map<String, dynamic>>> getAPayment(
      String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    return _table.findFirst(await _db, finder: finder);
  }

  Future<List<Payment>> getAllPayments() async {
    final recordSnapshot = await _table.find(await _db);
    return recordSnapshot.map((snapshot) {
      return Payment.fromJson(snapshot.value);
    }).toList();
  }
}
