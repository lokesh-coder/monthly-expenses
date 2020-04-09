import 'package:mobx/mobx.dart';
import 'package:monex/data/data_repository.dart';

part 'settings.store.g.dart';

class SettingsStore = SettingsBase with _$SettingsStore;

abstract class SettingsBase with Store {
  DataRepo repo;
  SettingsBase(this.repo) {
    init();
  }

  @observable
  int monthsViewRange = 1;

  @action
  void changeMonthsViewRange(int range) {
    monthsViewRange = range;
    repo.memory.changeMonthsViewRange(range);
  }

  init() async {
    var range = await repo.memory.monthsViewRange;
    if (range != null) monthsViewRange = range;
  }
}
