import 'package:monex/data/local/memory/local_memory.dart';
import 'package:monex/data/local/memory/setup.dart';

abstract class DataRepo {
  LocalMemory memory;
}

class DataRepository implements DataRepo {
  LocalMemory memory;

  DataRepository.init(LocalMemoryProvider localMemoryProvider) {
    var prefs = localMemoryProvider.init();
    this.memory = LocalMemory(prefs);
  }
}
