import "package:shared_preferences/shared_preferences.dart";

class LocalMemoryProvider {
  Future<SharedPreferences> init() {
    return SharedPreferences.getInstance();
  }
}
