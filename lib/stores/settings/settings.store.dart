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

  @observable
  int sortBy;

  @action
  void changeMonthsViewRange(int range) {
    monthsViewRange = range;
    repo.memory.changeMonthsViewRange(range);
  }

  @action
  void changeSortBy(int id) {
    sortBy = id;
    repo.memory.changeSortBy(id);
  }

  init() async {
    var range = await repo.memory.monthsViewRange;
    if (range != null) monthsViewRange = range;

    var sortByValue = await repo.memory.sortBy;
    if (sortByValue != null)
      sortBy = sortByValue;
    else
      sortBy = this.repo.obj.get('sorting').defaultStrategy.id;
  }
}
