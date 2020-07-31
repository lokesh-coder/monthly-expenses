import 'package:monthlyexp/config/m_icons.dart';
import 'package:monthlyexp/models/enums.dart';
import 'package:monthlyexp/models/sort_strategy.dart';

class SortStrategies {
  final List<SortStrategy> _strategies = [
    SortStrategy(
      id: 1,
      name: 'Alphabetical',
      desc: 'Display based on label name',
      icon: MIcons.character_recognition_line,
      keyFn: (x) => x.label,
      ascLabel: 'Label names are ordered by A to Z',
      descLabel: 'Label names are ordered by Z-A',
    ),
    SortStrategy(
      id: 2,
      name: 'Amount',
      desc: 'Order by Payment amount',
      icon: MIcons.wallet_3_line,
      keyFn: (x) => x.amount,
      ascLabel: 'Lowest to Highest amount',
      descLabel: 'Highest to Lowest amount',
    ),
    SortStrategy(
      id: 3,
      name: 'Payment date',
      desc: 'Based on the date of the payment',
      icon: MIcons.calendar_line,
      keyFn: (x) => x.date,
      ascLabel: 'Form month starting to end',
      descLabel: 'From month end to starting',
    ),
    SortStrategy(
      id: 4,
      name: 'Recent changes',
      desc: 'last modified payment time',
      icon: MIcons.time_line,
      keyFn: (x) => x.lastModifiedTime,
      ascLabel: 'Rarely edited first',
      descLabel: 'Recently edited first',
    ),
    SortStrategy(
      id: 5,
      name: 'Category',
      desc: 'Sort them by categories',
      icon: MIcons.apps_line,
      keyFn: (x) => x.categoryID,
      ascLabel: 'Most used category first ',
      descLabel: 'Rarely used category first',
    ),
  ];

  SortStrategy get defaultStrategy => _strategies[0];

  List<SortStrategy> get all => _strategies;

  SortStrategy findSortStrategyById(int strategyID) => _strategies.firstWhere(
        (s) => s.id == strategyID,
        orElse: () => null,
      );

  String getOrderLabel(int strategyID, int orderID) {
    final ss = findSortStrategyById(strategyID);
    if (orderID == OrderBy.ASC.index) {
      return ss.ascLabel;
    }
    return ss.descLabel;
  }
}
