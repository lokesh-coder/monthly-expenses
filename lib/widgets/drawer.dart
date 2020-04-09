import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monex/service_locator/service_locator.dart';
import 'package:monex/stores/settings/settings.store.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: EdgeInsets.all(10),
          child: Observer(builder: (context) {
            return Column(
              children: <Widget>[
                Text(
                    'View period ${sl<SettingsStore>().monthsViewRange.toDouble()}'),
                Slider(
                  min: 1,
                  max: 12,
                  divisions: 12,
                  value: sl<SettingsStore>().monthsViewRange.toDouble(),
                  onChanged: (value) {
                    sl<SettingsStore>().changeMonthsViewRange(value.toInt());
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
