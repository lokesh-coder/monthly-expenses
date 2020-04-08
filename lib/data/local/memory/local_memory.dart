import 'dart:async';
import 'package:monex/data/local/memory/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalMemory {
  final Future<SharedPreferences> memory;

  LocalMemory(this.memory);

// Months view ------------------------------------------------------------

  Future<void> changeMonthsViewRange(int range) {
    return memory
        .then((x) => x.setInt(LocalMemoryKeys.months_view_range, range));
  }

  Future<int> get monthsViewRange {
    return memory.then((x) => x.getInt(LocalMemoryKeys.months_view_range));
  }
}
