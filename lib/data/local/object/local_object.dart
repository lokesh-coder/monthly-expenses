import 'package:monex/data/local/object/files/categories.dart';

import 'files/sort_strategies.dart';

class LocalObject {
  final Map _objects = {};

  LocalObject() {
    _init();
  }

  void register(String key, Object value) {
    _objects[key] = value;
  }

  T get<T>(String key) => _objects[key];

  void _init() {
    register('categories', Catagories());
    register('sorting', SortStrategies());
  }
}
