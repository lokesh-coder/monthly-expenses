import 'package:monex/data/local/db/local_db.dart';
import 'package:monex/data/local/db/setup.dart';
import 'package:monex/data/local/memory/local_memory.dart';
import 'package:monex/data/local/memory/setup.dart';
import 'package:monex/data/local/object/local_object.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DataRepo {
  LocalMemory memory;
  LocalDB db;
  LocalObject obj;
}

class DataRepository implements DataRepo {
  LocalMemory memory;
  LocalDB db;
  LocalObject obj;

  DataRepository.init(
    LocalMemoryProvider localMemoryProvider,
    LocalDBProvider localDBProvider,
  ) {
    Future<SharedPreferences> prefs = localMemoryProvider.init();
    this.memory = LocalMemory(prefs);

    Future<Database> db = localDBProvider.database;
    this.db = LocalDB(db);

    this.obj = LocalObject();
  }
}