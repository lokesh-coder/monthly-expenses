import 'package:monex/data/local/db/config.dart';
import 'package:monex/models/payment.model.dart';
import 'package:sembast/sembast.dart';
import 'package:uuid/uuid.dart';

class LocalDB {
  final Future<Database> db;

  LocalDB(this.db);

  final _table = intMapStoreFactory.store(LocalDBConfig.payents_table_name);

  dumpData(List data) async {
    for (var d = 0; d < data.length; d++) {
      await _table.add(await db, {
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
    await _table.add(await db, paymentJson);
    return paymentJson['id'];
  }

  Future updatePayment(Payment payment) async {
    final finder = Finder(filter: Filter.equals('id', payment.id));
    await _table.update(await db, payment.toJson(), finder: finder);
  }

  Future delete(Payment payment) async {
    final finder = Finder(filter: Filter.equals('id', payment.id));
    await _table.delete(await db, finder: finder);
  }

  Future dropDb() async {
    await _table.drop(await db);
  }

  Future<RecordSnapshot<int, Map<String, dynamic>>> getAPayment(
      String id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    return _table.findFirst(await db, finder: finder);
  }

  Future<List<Payment>> getAllPayments() async {
    final recordSnapshot = await _table.find(await db);
    return recordSnapshot.map((snapshot) {
      return Payment.fromJson(snapshot.value);
    }).toList();
  }
}
