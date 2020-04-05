import 'package:jiffy/jiffy.dart';

class DateUtil {
  int getTotalDaysInMonth(DateTime dateTime) {
    Jiffy date = Jiffy(dateTime);
    return date.daysInMonth;
  }

  int getDayOfWeek(DateTime dateTime) {
    Jiffy date = Jiffy(dateTime);
    return date.day;
  }

  getAllDaysInMonth(DateTime dateTime) {
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
}
