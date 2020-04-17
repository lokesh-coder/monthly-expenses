import 'package:flutter/material.dart';
import 'package:monex/models/sort_strategy.dart';

class SortStrategies {
  List<SortStrategy> _strategies = [
    SortStrategy(
      id: 1,
      name: 'Alphabetical',
      desc: 'Display based on label name',
      icon: Icons.sort_by_alpha,
    ),
    SortStrategy(
      id: 2,
      name: 'Amount',
      desc: 'Order by Payment amount',
      icon: Icons.account_balance_wallet,
    ),
    SortStrategy(
      id: 3,
      name: 'Payment date',
      desc: 'Based on the date of the payment',
      icon: Icons.event_note,
    ),
    SortStrategy(
      id: 4,
      name: 'Recent changes',
      desc: 'last modified payment time',
      icon: Icons.schedule,
    ),
    SortStrategy(
      id: 5,
      name: 'Category',
      desc: 'Sort them by categories',
      icon: Icons.category,
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
}
