import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/sort_strategies.dart';
import 'package:monex/models/sort_strategy.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';

class SortEdit extends StatefulWidget {
  const SortEdit({Key key}) : super(key: key);

  @override
  _SortEditState createState() => _SortEditState();
}

class _SortEditState extends State<SortEdit> {
  int _value;
  var settingsStore = sl<SettingsStore>();

  @override
  void initState() {
    super.initState();
    _value = settingsStore.sortBy;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getSortStrategies(),
    );
  }

  Widget _getItem(SortStrategy strategy) {
    return ListTile(
      title: Text(
        strategy.name,
        style: TextStyle(
          color: Clrs.inputValue,
        ),
      ),
      subtitle: Text(
        strategy.desc,
        style: TextStyle(
          color: Clrs.labelActive,
        ),
      ),
      leading: Icon(
        strategy.icon,
        color: Clrs.inputValue.withOpacity(0.5),
      ),
      trailing: strategy.id == _value ? Icon(Icons.check) : SizedBox.shrink(),
      onTap: () {
        settingsStore.changeSortBy(strategy.id);
        setState(() {
          _value = strategy.id;
        });
      },
    );
  }

  _getSortStrategies() {
    var strategies = sl<DataRepo>().obj.get<SortStrategies>('sorting').all;
    return strategies.map((s) => _getItem(s)).toList();
  }
}
