import 'dart:async';

import 'package:monex/data/local/db/config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class LocalDBProvider {
  static final LocalDBProvider _singleton = LocalDBProvider._();

  static LocalDBProvider get instance => _singleton;

  Completer<Database> _dbOpenCompleter;

  LocalDBProvider._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      await _openDatabase();
    }
    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, LocalDBConfig.db_name);

    final database = await databaseFactoryIo.openDatabase(dbPath, version: 1);

    _dbOpenCompleter.complete(database);
  }
}
