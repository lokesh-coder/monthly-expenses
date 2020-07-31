import 'package:get_it/get_it.dart';
import 'package:monthlyexp/data/data_repository.dart';
import 'package:monthlyexp/data/local/db/setup.dart';
import 'package:monthlyexp/data/local/memory/setup.dart';
import 'package:monthlyexp/stores/form/form.store.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:monthlyexp/stores/sandwiich/sandwich.store.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl
    ..registerSingleton<DataRepo>(
        DataRepository.init(LocalMemoryProvider(), LocalDBProvider.instance))
    ..registerSingleton<SettingsStore>(SettingsStore(sl<DataRepo>()))
    ..registerLazySingleton<SandwichStore>(() => SandwichStore())
    ..registerLazySingleton<PaymentsStore>(() => PaymentsStore(sl<DataRepo>()))
    ..registerLazySingleton<FormStore>(() => FormStore(sl<DataRepo>()));
}
