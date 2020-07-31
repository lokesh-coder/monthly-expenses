import 'package:flutter/material.dart';
import 'package:monthlyexp/config/colors.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/data/data_repository.dart';
import 'package:monthlyexp/data/local/object/files/sort_strategies.dart';
import 'package:monthlyexp/models/sort_strategy.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/common/check.dart';

class SortEdit extends StatefulWidget {
  const SortEdit();

  @override
  _SortEditState createState() => _SortEditState();
}

class _SortEditState extends State<SortEdit> {
  int _value;
  final SettingsStore settingsStore = sl<SettingsStore>();

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
      title: Text(strategy.name, style: Style.label.base.clr(Clrs.labelAlt)),
      subtitle: Text(strategy.desc, style: Style.label.sm),
      leading: Container(
        height: double.infinity,
        child: Icon(
          strategy.icon,
          color: Clrs.inputValue.withOpacity(0.5),
        ),
      ),
      trailing: strategy.id == _value ? Check() : SizedBox.shrink(),
      onTap: () {
        settingsStore.changeSortBy(strategy.id);
        setState(() {
          _value = strategy.id;
        });
      },
    );
  }

  List<Widget> _getSortStrategies() {
    final strategies = sl<DataRepo>().obj.get<SortStrategies>('sorting').all;
    return strategies.map(_getItem).toList();
  }
}
