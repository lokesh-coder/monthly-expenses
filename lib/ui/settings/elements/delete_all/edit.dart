import 'package:flutter/material.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:provider/provider.dart';

class DeleteAllEdit extends StatelessWidget {
  const DeleteAllEdit();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: MaterialButton(
        elevation: 0,
        textColor: theme.violet,
        padding: EdgeInsets.all(10),
        color: theme.violet,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: theme.violet, width: 2),
        ),
        onPressed: () => sl<PaymentsStore>().dropDb(),
        child: Text(Labels.deleteForever, style: Style.body.clr(Colors.white)),
      ),
    );
  }
}
