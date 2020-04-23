import 'package:flutter/material.dart';
import 'package:monex/config/colors.dart';
import 'package:monex/config/labels.dart';
import 'package:monex/data/data_repository.dart';
import 'package:monex/data/local/object/files/sort_strategies.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';
import 'package:monex/ui/common/check.dart';

class OrderEdit extends StatefulWidget {
  const OrderEdit({Key key}) : super(key: key);

  @override
  _OrderEditState createState() => _OrderEditState();
}

class _OrderEditState extends State<OrderEdit> {
  int _value;
  var settingsStore = sl<SettingsStore>();

  @override
  void initState() {
    super.initState();
    _value = settingsStore.orderBy;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _getItems(),
    );
  }

  Widget _getItem(Map data) {
    return ListTile(
      title: Text(
        data['name'],
        style: TextStyle(
          color: Clrs.inputValue,
        ),
      ),
      subtitle: Text(
        data['desc'],
        style: TextStyle(
          color: Clrs.labelActive,
        ),
      ),
      leading: Icon(
        data['icon'],
        color: Clrs.inputValue.withOpacity(0.5),
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

  _getItems() {
    var strategy = sl<DataRepo>()
        .obj
        .get<SortStrategies>('sorting')
        .findSortStrategyById(settingsStore.sortBy);
    List<Map> data = [
      {
        'id': OrderBy.ASC.index,
        'name': Labels.ascending,
        'desc': strategy.ascLabel,
        'icon': Icons.arrow_upward
      },
      {
        'id': OrderBy.DESC.index,
        'name': Labels.descending,
        'desc': strategy.descLabel,
        'icon': Icons.arrow_downward
      },
    ];
    return data.map((o) => _getItem(o)).toList();
  }
}
