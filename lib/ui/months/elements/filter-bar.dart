import "package:flutter/material.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:monex/config/colors.dart";
import "package:monex/config/dimensions.dart";
import "package:monex/config/labels.dart";
import "package:monex/config/m_icons.dart";
import "package:monex/config/typography.dart";
import "package:monex/models/enums.dart";
import "package:monex/services/service_locator.dart";
import "package:monex/stores/payments/payments.store.dart";

class FilterBar extends StatelessWidget {
  const FilterBar();

  @override
  Widget build(BuildContext context) {
    var paymentsStore = sl<PaymentsStore>();
    return Container(
      height: Dimensions.filtersBarHeight,
      color: Clrs.primary,
      child: Observer(builder: (context) {
        var selectedFilter = paymentsStore.filterBy;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FilterItem(
              PaymentType.ALL,
              isActive: selectedFilter == PaymentType.ALL,
              onTap: _onTap,
            ),
            _FilterItem(
              PaymentType.CREDIT,
              isActive: selectedFilter == PaymentType.CREDIT,
              onTap: _onTap,
            ),
            _FilterItem(
              PaymentType.DEBIT,
              isActive: selectedFilter == PaymentType.DEBIT,
              onTap: _onTap,
            ),
          ],
        );
      }),
    );
  }

  _onTap(type) {
    sl<PaymentsStore>().changeFilter(type);
  }
}

class _FilterItem extends StatelessWidget {
  final PaymentType type;
  final bool isActive;
  final Function onTap;

  const _FilterItem(this.type, {this.onTap, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    var item = _filterItemsMap()[type];
    return GestureDetector(
      onTap: () => onTap(type),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(
              MIcons.lens_24px,
              size: 13,
              color: item["color"].withOpacity(isActive ? 1.0 : 0.4),
            ),
            SizedBox(width: 8),
            Text(
              item["name"],
              style: Style.body.light.sm
                  .clr(Clrs.bodyAlt.withOpacity(isActive ? 1.0 : 0.4)),
            ),
          ],
        ),
      ),
    );
  }

  Map _filterItemsMap() {
    return {
      PaymentType.ALL: {
        "name": Labels.all.toUpperCase(),
        "color": Clrs.yellow,
      },
      PaymentType.DEBIT: {
        "name": Labels.debit.toUpperCase(),
        "color": Clrs.red,
      },
      PaymentType.CREDIT: {
        "name": Labels.credit.toUpperCase(),
        "color": Clrs.green,
      },
    };
  }
}
