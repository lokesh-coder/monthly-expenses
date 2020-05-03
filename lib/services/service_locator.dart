import 'package:get_it/get_it.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/db/setup.dart';
import 'package:monex/data/local/memory/setup.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/stores/settings/settings.store.dart';

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
