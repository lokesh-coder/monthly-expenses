import 'package:get_it/get_it.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/memory/setup.dart';
import 'package:monex/stores/settings/settings.store.dart';

final sl = GetIt.instance;

setupServiceLocator() {
  sl.registerSingleton<DataRepo>(DataRepository.init(LocalMemoryProvider()));
  sl.registerSingleton<SettingsStore>(SettingsStore(sl<DataRepo>()));
}
