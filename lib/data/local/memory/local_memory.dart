import 'dart:async';
import 'package:monex/data/local/memory/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalMemory {
  final Future<SharedPreferences> memory;

  LocalMemory(this.memory);

// Months view ------------------------------------------------------------

  Future<void> changeMonthsViewRange(int range) =>
      memory.then((x) => x.setInt(LocalMemoryConfig.months_view_range, range));

  Future<int> get monthsViewRange =>
      memory.then((x) => x.getInt(LocalMemoryConfig.months_view_range));

// sort payments ------------------------------------------------------------

  Future<void> changeSortBy(int sortID) =>
      memory.then((x) => x.setInt(LocalMemoryConfig.sort_by, sortID));

  Future<int> get sortBy =>
      memory.then((x) => x.getInt(LocalMemoryConfig.sort_by));

// order payments ------------------------------------------------------------

  Future<void> changeOrderBy(int orderID) =>
      memory.then((x) => x.setInt(LocalMemoryConfig.order_by, orderID));

  Future<int> get orderBy =>
      memory.then((x) => x.getInt(LocalMemoryConfig.order_by));

// currency ------------------------------------------------------------

  Future<void> changeCurrency(String currency) =>
      memory.then((x) => x.setString(LocalMemoryConfig.currency, currency));

  Future<String> get currency =>
      memory.then((x) => x.getString(LocalMemoryConfig.currency));

// is fresh app ------------------------------------------------------------

  Future<void> setupDone() =>
      memory.then((x) => x.setBool(LocalMemoryConfig.is_new_setup, false));

  Future<bool> get isNewSetup =>
      memory.then((x) => x.getBool(LocalMemoryConfig.is_new_setup));
}
