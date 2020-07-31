import 'dart:math';

import 'package:monthlyexp/data/local/object/files/categories.dart';
import 'package:monthlyexp/helpers/date_helper.dart';
import 'package:monthlyexp/models/payment.model.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';

class SeedData {
  List<Payment> get data {
    final List seeds = [];
    final int monthRange = sl<SettingsStore>().monthsViewRange;
    final List monthDates = DateHelper.getAllMonthsInRange(monthRange);
    for (var i = 0; i < monthDates.length; i++) {
      final dt = monthDates[i]['dateTime'];
      for (var j = 0; j < Random().nextInt(30); j++) {
        seeds.add(Payment(
          amount: _getRandomAmount(),
          categoryID: _getRandomCategory(),
          createdTime: _getRandomDate(dt),
          date: _getRandomDate(dt),
          isCredit: _getRandomType(),
          label: _getRandomLabel(),
          lastModifiedTime: _getRandomDate(dt),
          id: '$i$j',
        ));
      }
    }

    return seeds;
  }

  num _getRandomAmount() {
    final Random random = Random();
    return num.parse((random.nextDouble() * (Random().nextInt(99999)))
        .toStringAsFixed(Random().nextInt(3)));
  }

  String _getRandomLabel() {
    final rand = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789 -./';
    final buffer = StringBuffer();
    for (var i = 0; i < Random().nextInt(30) + 1; i++) {
      buffer.write(chars[rand.nextInt(chars.length)]);
    }
    return buffer.toString();
  }

  bool _getRandomType() => Random().nextBool();

  String _getRandomCategory() {
    final allcat = Catagories().all;
    final randomIndex = Random().nextInt(allcat.length);
    return allcat[randomIndex].id;
  }

  int _getRandomDate(DateTime month) {
    final start = month;
    final end = DateTime(start.year, start.month + 1, 0);

    return start
        .add(Duration(days: Random().nextInt(end.day)))
        .millisecondsSinceEpoch;
  }
}
