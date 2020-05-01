import 'package:monex/data/local/object/files/categories.dart';
import 'package:monex/helpers/date_helper.dart';
import 'package:monex/models/payment.model.dart';
import 'package:monex/services/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'dart:math';

class SeedData {
  get data {
    var seeds = [];
    var monthRange = sl<SettingsStore>().monthsViewRange;
    var monthDates = DateHelper.getAllMonthsInRange(monthRange);
    for (var i = 0; i < monthDates.length; i++) {
      var dt = monthDates[i]['dateTime'];
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

    // print(seeds);
    return seeds;
  }

  _getRandomAmount() {
    Random random = new Random();
    return num.parse((random.nextDouble() * (new Random().nextInt(99999)))
        .toStringAsFixed(new Random().nextInt(3)));
  }

  _getRandomLabel() {
    var rand = new Random();
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789 -./";
    String result = "";
    for (var i = 0; i < Random().nextInt(30) + 1; i++) {
      result += chars[rand.nextInt(chars.length)];
    }
    return result;
  }

  _getRandomType() {
    return Random().nextBool();
  }

  _getRandomCategory() {
    var allcat = Catagories().all;
    var randomIndex = new Random().nextInt(allcat.length);
    return allcat[randomIndex].id;
  }

  _getRandomDate(DateTime month) {
    var start = month;
    var end = DateTime(start.year, start.month + 1, 0);

    return start
        .add(Duration(days: Random().nextInt(end.day)))
        .millisecondsSinceEpoch;
  }
}
