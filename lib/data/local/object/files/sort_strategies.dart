import 'package:flutter/material.dart';
import 'package:monex/models/enums.dart';
import 'package:monex/models/sort_strategy.dart';

class SortStrategies {
  List<SortStrategy> _strategies = [
    SortStrategy(
      id: 1,
      name: 'Alphabetical',
      desc: 'Display based on label name',
      icon: Icons.sort_by_alpha,
      keyFn: (x) => x.label,
      ascLabel: 'Label names are ordered by A to Z',
      descLabel: 'Label names are ordered by Z-A',
    ),
    SortStrategy(
      id: 2,
      name: 'Amount',
      desc: 'Order by Payment amount',
      icon: Icons.account_balance_wallet,
      keyFn: (x) => x.amount,
      ascLabel: 'Lowest to Highest amount',
      descLabel: 'Highest to Lowest amount',
    ),
    SortStrategy(
      id: 3,
      name: 'Payment date',
      desc: 'Based on the date of the payment',
      icon: Icons.event_note,
      keyFn: (x) => x.date,
      ascLabel: 'Form month starting to end',
      descLabel: 'From month end to starting',
    ),
    SortStrategy(
      id: 4,
      name: 'Recent changes',
      desc: 'last modified payment time',
      icon: Icons.schedule,
      keyFn: (x) => x.lastModifiedTime,
      ascLabel: 'Rarely edited first',
      descLabel: 'Recently edited first',
    ),
    SortStrategy(
      id: 5,
      name: 'Category',
      desc: 'Sort them by categories',
      icon: Icons.category,
      keyFn: (x) => x.categoryID,
      ascLabel: 'Most used category first ',
      descLabel: 'Rarely used category first',
    ),
  ];

  SortStrategy get defaultStrategy {
    return _strategies[0];
  }

  List<SortStrategy> get all {
    return _strategies;
  }

  SortStrategy findSortStrategyById(int strategyID) {
    return _strategies.firstWhere(
      (s) => s.id == strategyID,
      orElse: () => null,
    );
  }

  String getOrderLabel(int strategyID, int orderID) {
    var ss = findSortStrategyById(strategyID);
    if (orderID == OrderBy.ASC.index) {
      return ss.ascLabel;
    }
    return ss.descLabel;
  }
}
