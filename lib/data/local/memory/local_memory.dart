import 'dart:async';
import 'package:monex/data/local/memory/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalMemory {
  final Future<SharedPreferences> memory;

  LocalMemory(this.memory);

// Months view ------------------------------------------------------------

  Future<void> changeMonthsViewRange(int range) {
    return memory
        .then((x) => x.setInt(LocalMemoryConfig.months_view_range, range));
  }

  Future<int> get monthsViewRange {
    return memory.then((x) => x.getInt(LocalMemoryConfig.months_view_range));
  }

// sort payments ------------------------------------------------------------

  Future<void> changeSortBy(int sortID) {
    return memory.then((x) => x.setInt(LocalMemoryConfig.sort_by, sortID));
  }

  Future<int> get sortBy {
    return memory.then((x) => x.getInt(LocalMemoryConfig.sort_by));
  }

// order payments ------------------------------------------------------------

  Future<void> changeOrderBy(int orderID) {
    return memory.then((x) => x.setInt(LocalMemoryConfig.order_by, orderID));
  }

  Future<int> get orderBy {
    return memory.then((x) => x.getInt(LocalMemoryConfig.order_by));
  }
}
