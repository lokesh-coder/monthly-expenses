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
  bool isNewSetup;

  @observable
  int monthsViewRange = 1;

  @observable
  int sortBy;

  @observable
  int orderBy = 1;

  @observable
  String currency = '0=0';

  @action
  void setupDone() {
    isNewSetup = false;
    repo.memory.setupDone();
  }

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

  @action
  void changeOrderBy(int id) {
    orderBy = id;
    repo.memory.changeOrderBy(id);
  }

  @action
  void changeCurrency(String locale, String currencyCode) {
    currency = '$locale=$currencyCode';
    repo.memory.changeCurrency(currency);
  }

  init() async {
    var isNewSetupValue = await repo.memory.isNewSetup;
    isNewSetup = isNewSetupValue ?? true;

    var range = await repo.memory.monthsViewRange;
    if (range != null) monthsViewRange = range;

    var orderByValue = await repo.memory.orderBy;
    if (orderByValue != null) orderBy = orderByValue;

    var currencyValue = await repo.memory.currency;
    if (currencyValue != null) currency = currencyValue;

    var sortByValue = await repo.memory.sortBy;
    if (sortByValue != null) {
      sortBy = sortByValue;
    } else {
      sortBy = this.repo.obj.get('sorting').defaultStrategy.id;
    }
  }
}
