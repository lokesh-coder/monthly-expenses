import 'package:get_it/get_it.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/db/setup.dart';
import 'package:monex/data/local/memory/setup.dart';
import 'package:monex/stores/form/form.store.dart';
import 'package:monex/stores/payments/payments.store.dart';
import 'package:monex/stores/sandwiich/sandwich.store.dart';
import 'package:monex/stores/settings/settings.store.dart';

final sl = GetIt.instance;

setupServiceLocator() {
  sl.registerSingleton<DataRepo>(
      DataRepository.init(LocalMemoryProvider(), LocalDBProvider.instance));
  sl.registerSingleton<SettingsStore>(SettingsStore(sl<DataRepo>()));
  sl.registerLazySingleton<SandwichStore>(() => SandwichStore());
  sl.registerLazySingleton<PaymentsStore>(() => PaymentsStore(sl<DataRepo>()));
  sl.registerLazySingleton<FormStore>(() => FormStore(sl<DataRepo>()));
}
