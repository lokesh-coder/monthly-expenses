import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:monthlyexp/config/dimensions.dart';
import 'package:monthlyexp/config/labels.dart';
import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/config/themes.dart';
import 'package:monthlyexp/config/typography.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/services/service_locator.dart';
import 'package:monthlyexp/services/theme_changer.dart';
import 'package:monthlyexp/stores/payments/payments.store.dart';
import 'package:provider/provider.dart';

class FilterBar extends StatelessWidget {
  const FilterBar();

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context).theme;
    final PaymentsStore paymentsStore = sl<PaymentsStore>();
    return Container(
      height: Dimensions.filtersBarHeight,
      color: theme.bgPrimary,
      child: Observer(builder: (context) {
        final selectedFilter = paymentsStore.filterBy;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FilterItem(
              PaymentType.ALL,
              isActive: selectedFilter == PaymentType.ALL,
              onTap: _onTap,
              theme: theme,
            ),
            _FilterItem(
              PaymentType.CREDIT,
              isActive: selectedFilter == PaymentType.CREDIT,
              onTap: _onTap,
              theme: theme,
            ),
            _FilterItem(
              PaymentType.DEBIT,
              isActive: selectedFilter == PaymentType.DEBIT,
              onTap: _onTap,
              theme: theme,
            ),
          ],
        );
      }),
    );
  }

  void _onTap(type) {
    sl<PaymentsStore>().changeFilter(type);
  }
}

class _FilterItem extends StatelessWidget {
  final PaymentType type;
  final bool isActive;
  final Function onTap;
  final AppTheme theme;

  const _FilterItem(this.type, {this.onTap, this.isActive = false, this.theme});

  @override
  Widget build(BuildContext context) {
    final item = _filterItemsMap(theme)[type];
    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Colors.white.withOpacity(0.1),
        splashColor: Colors.white.withOpacity(0.1),
        onTap: () => onTap(type),
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                MIcons.lens_24px,
                size: 13,
                color: item['color'].withOpacity(isActive ? 1.0 : 0.4),
              ),
              SizedBox(width: 8),
              Text(
                item['name'],
                style: Style.body.light.sm
                    .clr(theme.textHeading.withOpacity(isActive ? 1.0 : 0.4)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map _filterItemsMap(AppTheme theme) {
    return {
      PaymentType.ALL: {
        'name': Labels.all.toUpperCase(),
        'color': theme.yellow,
      },
      PaymentType.DEBIT: {
        'name': Labels.debits.toUpperCase(),
        'color': theme.red,
      },
      PaymentType.CREDIT: {
        'name': Labels.credits.toUpperCase(),
        'color': theme.green,
      },
    };
  }
}
