import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/form/form.store.dart';
import 'package:monthlyexp/ui/editor/elements/icon_card.dart';
import 'package:provider/provider.dart';

class TypeInput extends StatelessWidget {
  const TypeInput();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    final FormStore formStore = sl<FormStore>();
    return Observer(
      builder: (context) {
        return IconCard(
          child: _icon(formStore, theme),
          name: formStore.isCredit ? 'CREDIT' : 'DEBIT',
          onTap: () => formStore.changeType(!formStore.isCredit),
          storeKey: () => formStore.isCredit,
        );
      },
    );
  }

  Widget _icon(FormStore formStore, AppTheme theme) {
    return Icon(
      formStore.isCredit ? MIcons.smile : MIcons.sad,
      size: 30,
      color: formStore.isCredit ? theme.green : theme.red,
    );
  }
}
