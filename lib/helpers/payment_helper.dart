import "package:collection/collection.dart";
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/sort_strategies.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/models/payment.model.dart';
import 'package:monex/services/service_locator.dart';

class PaymentsHelper {
  static sort(List<Payment> payments, int sortID, int orderID) {
    Function keyFn = _getSortKeyFn(sortID);
    Function sortCb = _sortFromFnKey(keyFn, orderID);
    payments.sort(sortCb);
  }

  static List<Payment> filter(List<Payment> payments, PaymentType filterBy) {
    return payments.where(
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
    ).toList();
  }

  static Map<String, List<Payment>> groupByMonth(List<Payment> payments) {
    return groupBy(payments, (Payment p) {
      DateTime dt = DateTime.fromMillisecondsSinceEpoch(p.date);
      return DateHelper.getMonthYear(dt);
    });
  }

  static getPaymentFromID(List<Payment> payments, String paymentID) {
    return payments.firstWhere((p) {
      return p.id == paymentID;
    }, orElse: () => null);
  }

  static getInOutStatement(List<Payment> payments, PaymentType filterBy) {
    Map meta = {'credit': 0, 'debit': 0, 'activeType': filterBy};
    if (payments.length == 0) return meta;

    payments.forEach((p) {
      var type = p.isCredit ? 'credit' : 'debit';
      meta[type] = meta[type] + p.amount;
    });
    return meta;
  }

  static calcTotalAmount(List<Payment> payments) {
    if (payments.length == 0) return 0;
    return payments
        .map((x) => x.isCredit ? x.amount : -(x.amount))
        .reduce((v, e) => v + e);
  }

  static int Function(T, T) _sortFromFnKey<T>(Function o, int orderID) {
    if (orderID == OrderBy.ASC.index) {
      return (a, b) => o(a).compareTo(o(b));
    }
    return (a, b) => o(b).compareTo(o(a));
  }

  static _getSortKeyFn(id) {
    return sl<DataRepo>()
        .obj
        .get<SortStrategies>('sorting')
        .findSortStrategyById(id)
        .keyFn;
  }
}
