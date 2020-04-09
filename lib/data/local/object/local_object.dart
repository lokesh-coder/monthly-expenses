import 'package:monex/data/local/object/files/categories.dart';

class LocalObject {
  Map _objects = {};

  LocalObject() {
    _init();
  }

  register(key, value) {
    _objects[key] = value;
  }

  T get<T>(key) {
    return _objects[key];
  }

  _init() {
    register('categories', Catagories());
  }
}
