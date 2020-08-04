import 'package:flutter/material.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/data/data_repository.dart';
import 'package:monthlyexp/data/local/object/files/sort_strategies.dart';
import 'package:monthlyexp/models/sort_strategy.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/common/check.dart';
import 'package:provider/provider.dart';

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
    final theme = Provider.of<ThemeChanger>(context).theme;
    return ListTile(
      title: Text(strategy.name,
          style: Style.label.base.light.clr(theme.textHeading)),
      subtitle: Text(strategy.desc,
          style: Style.label.sm.light.clr(theme.textSubHeading)),
      leading: Container(
        height: double.infinity,
        child: Icon(
          strategy.icon,
          color: theme.textSubHeading,
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
