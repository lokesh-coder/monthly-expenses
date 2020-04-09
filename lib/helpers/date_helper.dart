import 'package:jiffy/jiffy.dart';

class DateHelper {
  static int getTotalDaysInMonth(DateTime dateTime) {
    Jiffy date = Jiffy(dateTime);
    return date.daysInMonth;
  }

  static int getDayOfWeek(DateTime dateTime) {
    Jiffy date = Jiffy(dateTime);
    return date.day;
  }

  static List getAllDaysInMonth(DateTime dateTime) {
    Jiffy date = Jiffy(dateTime);
    List<Map> weeks = List();
    int daysInMonth = getTotalDaysInMonth(dateTime);
    Jiffy monthStartDate = date..startOf(Units.MONTH);

    for (var i = 0; i < daysInMonth; i++) {
      var d = Jiffy(monthStartDate)..add(days: i);

      if (d.day == 1 || weeks.length == 0) {
        weeks.add(
          Map.from({
            1: '',
            2: '',
            3: '',
            4: '',
            5: '',
            6: '',
            7: '',
          }),
        );
      }
      weeks[weeks.length - 1][d.day] = {"date": d.date, "dateTime": d.dateTime};
    }

    return weeks.map((x) => x.values).map((x) => x.toList()).toList();
  }

  static String getFormattedDayOfMonth(DateTime dt) {
    return Jiffy(dt).format('do MMM');
  }

  static List getMonthRange(int rangeCount) {
    DateTime currMonth = DateTime.now();
    List ranges = List((rangeCount * 2) + 1);

    ranges.asMap().forEach((index, r) {
      var month = (Jiffy(currMonth)
            ..subtract(months: rangeCount)
            ..add(months: index)
            ..startOf(Units.MONTH))
          .dateTime;

      ranges[index] = Map.from(
          {"dateTime": month, "monthName": DateHelper.getMonthName(month)});
    });
    return ranges;
  }

  static String getMonthName(DateTime dt) {
    return Jiffy(dt).format('MMMM');
  }

  static String getYear(DateTime dt) {
    return Jiffy(dt).format('y');
  }

  static String getUniqueMonthFormat(DateTime dt) {
    return Jiffy(dt).format('MMMy');
  }
}
