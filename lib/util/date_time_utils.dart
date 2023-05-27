import 'package:date_format/date_format.dart';

class DateTimeUtils {
  static String secondsSinceEpochToDateTimeString(int seconds,
      {String dataTimeSeparator = ' '}) {
    return formatDate(DateTime.fromMillisecondsSinceEpoch(seconds * 1000),
        [yyyy, '-', mm, '-', dd, dataTimeSeparator, HH, ':', nn, ':', ss]);
  }

  static String dateTimeToString(DateTime dateTime,
      {String dataTimeSeparator = ' '}) {
    return formatDate(dateTime,
        [yyyy, '-', mm, '-', dd, dataTimeSeparator, HH, ':', nn, ':', ss]);
  }

  static String datetimeToDateString(DateTime date) {
    return formatDate(date, [yyyy, '-', mm, '-', dd]);
  }

  /**
   *
   */
  static DateTime reduceMonth(DateTime now, int monthToReduce) {
    if (monthToReduce <= 0) {
      return now;
    }
    var year = now.year;
    var month = now.month;
    var day = now.day;

    int targetYear = year;
    if (monthToReduce > 12) {
      targetYear = year - (monthToReduce ~/ 12);
    }
    int targetMonth;
    int reduceMonth = monthToReduce % 12;
    if (reduceMonth >= month) {
      targetMonth = month + 12 - reduceMonth;
      targetYear--;
    } else {
      targetMonth = month - reduceMonth;
    }
    var monthOfDay = getMonthDay(targetYear, targetMonth);
    DateTime startTime;
    if (monthOfDay < day) {
      startTime = DateTime(targetYear, targetMonth, monthOfDay);
    } else {
      startTime = DateTime(targetYear, targetMonth, day);
    }
    return startTime;
  }

  ///获取上个月的日期
  static DateTime getLastMonth() {
    DateTime startTime;
    DateTime now = DateTime.now();
    var year = now.year;
    var month = now.month;
    var day = now.day;
    //上个月份天数
    var lastYearMonthDay = getMonthDay(year, month - 1);
    if (lastYearMonthDay < day) {
      startTime = DateTime(year, month - 1, lastYearMonthDay);
    } else {
      startTime = DateTime(year, month - 1, day);
    }
    return startTime;
  }

  /// 获取近半年的日期
  static DateTime getLastHalfYear() {
    DateTime startTime;
    DateTime now = DateTime.now();
    var year = now.year;
    var month = now.month;
    var day = now.day;
    //当前月份天数
    var nowMonthDay = getMonthDay(year, month);

    if (month - 6 <= 0) {
      var lastMonthDay = getMonthDay(year - 1, 12 - (6 - month));

      ///上个月的总天数少于当前日的情况
      if (lastMonthDay < day) {
        startTime = DateTime(year - 1, 12 - (6 - month), lastMonthDay);
      } else {
        startTime = DateTime(year - 1, 12 - (6 - month), day);
      }
    } else {
      var lastMonthDay = getMonthDay(year, month - 6);
      if (lastMonthDay < day) {
        ///二月份的特殊情况
        if (day < nowMonthDay) {
          startTime =
              DateTime(year, month - 6, lastMonthDay - (nowMonthDay - day));
        } else {
          startTime = DateTime(year, month - 6, lastMonthDay);
        }
      } else {
        startTime = DateTime(year, month - 6, day);
      }
    }
    return startTime;
  }

  ///获取近一年的日期
  static DateTime getLastYearDate() {
    DateTime startTime;
    DateTime now = DateTime.now();
    var year = now.year;
    var month = now.month;
    var day = now.day;
    //去年月份天数
    var lastYearMonthDay = getMonthDay(year - 1, month);
    if (lastYearMonthDay < day) {
      startTime = DateTime(year - 1, month, lastYearMonthDay);
    } else {
      startTime = DateTime(year - 1, month, day);
    }
    return startTime;
  }

  ///获取某年某月的总天数
  static int getMonthDay(int year, int month) {
    var nowMonthDay = 30;
    if (month == 12) {
      nowMonthDay = DateTime(year + 1, month, 1)
          .difference(DateTime(year, month, 1))
          .inDays;
    } else {
      nowMonthDay = DateTime(year, month + 1, 1)
          .difference(DateTime(year, month, 1))
          .inDays;
    }
    return nowMonthDay;
  }
}
