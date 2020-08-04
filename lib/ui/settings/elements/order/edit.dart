import 'package:flutter/material.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/data/data_repository.dart';
import 'package:monthlyexp/data/local/object/files/sort_strategies.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/settings/settings.store.dart';
import 'package:monthlyexp/ui/common/check.dart';
import 'package:provider/provider.dart';

class OrderEdit extends StatefulWidget {
  const OrderEdit();

  @override
  _OrderEditState createState() => _OrderEditState();
}

class _OrderEditState extends State<OrderEdit> {
  int _value;
  final SettingsStore settingsStore = sl<SettingsStore>();

  @override
  void initState() {
    super.initState();
    _value = settingsStore.orderBy;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return Column(
      children: _getItems(theme),
    );
  }

  Widget _getItem(Map data, AppTheme theme) {
    return ListTile(
      title: Text(data['name'],
          style: Style.label.base.light.clr(theme.textHeading)),
      subtitle: Text(data['desc'],
          style: Style.label.sm.light.clr(theme.textSubHeading)),
      leading: Container(
        height: double.infinity,
        child: Icon(
          data['icon'],
          color: theme.textSubHeading,
        ),
      ),
      trailing: data['id'] == _value ? Check() : SizedBox.shrink(),
      onTap: () {
        settingsStore.changeOrderBy(data['id']);
        setState(() {
          _value = data['id'];
        });
      },
    );
  }

  List _getItems(AppTheme theme) {
    final strategy = sl<DataRepo>()
        .obj
        .get<SortStrategies>('sorting')
        .findSortStrategyById(settingsStore.sortBy);

    final List<Map> data = [
      {
        'id': OrderBy.ASC.index,
        'name': Labels.ascending,
        'desc': strategy.ascLabel,
        'icon': MIcons.sort_asc
      },
      {
        'id': OrderBy.DESC.index,
        'name': Labels.descending,
        'desc': strategy.descLabel,
        'icon': MIcons.sort_desc
      },
    ];
    return data.map((data) => _getItem(data, theme)).toList();
  }
}
