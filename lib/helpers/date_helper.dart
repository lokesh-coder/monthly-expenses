import 'package:jiffy/jiffy.dart';

class DateHelper {
  static String dateWeekdayP = 'd E';
  static String monthDayP = 'LLL · E';
  static String dateP = 'd';

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
    return Jiffy(dt).format('LLL · E');
  }

  static String format(DateTime dt, String pattern) {
    return Jiffy(dt).format(pattern);
  }

  static String getDateOfMonth(DateTime dt) {
    return Jiffy(dt).format('d');
  }

  static List getAllMonthsInRange(int rangeCount) {
    DateTime currMonth = DateTime.now();
    List ranges = List((rangeCount * 2) + 1);

    ranges.asMap().forEach((index, r) {
      var month = (Jiffy(currMonth)
            ..subtract(months: rangeCount)
            ..add(months: index)
            ..startOf(Units.MONTH))
          .dateTime;

      ranges[index] = Map.from({
        "dateTime": month,
        "monthName": DateHelper.getMonthName(month),
        "year": DateHelper.getYear(month)
      });
    });
    return ranges;
  }

  static String getMonthName(DateTime dt) {
    return Jiffy(dt).format('MMMM');
  }

  static String getYear(DateTime dt) {
    return Jiffy(dt).format('y');
  }

  static String getMonthYear(DateTime dt) {
    return Jiffy(dt).format('MMMy');
  }

  static int dtToMs(DateTime dt) {
    return dt.millisecondsSinceEpoch;
  }

  static DateTime msToDt(int ms) {
    return DateTime.fromMillisecondsSinceEpoch(ms);
  }

  static int get toMs {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static getMonthRangeDisplayText(int count) {
    List ranges = DateHelper.getAllMonthsInRange(count);
    String start = '${ranges.first['monthName']} ${ranges.first['year']}';
    String end = '${ranges.last['monthName']} ${ranges.last['year']}';
    return '$start to $end';
  }
}
