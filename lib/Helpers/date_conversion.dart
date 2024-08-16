import 'package:intl/intl.dart';
import 'package:app_name/Helpers/constants.dart';

class Date_Conversions {
  DateTime? convert_stringto_date(String format, String date_str) {
    // ("yyyy-MM-dd hh:mm:ss")
    // print("Checking " + date_str + " with " + format);
    try {
      DateTime tempDate = DateFormat(format).parse(date_str);
      // print("Sucesffully converted the date");
      // print(tempDate);
      return tempDate;
    } catch (e) {
      print("conversion error");
      return null;
    }
  }

  int getTimeinmillforCurrentDay() {
    final now = DateTime.now();
    final startOfDay = DateTime(
        now.year, now.month, now.day); // Set time to midnight (00:00 am)
    final startOfDayMill = startOfDay.millisecondsSinceEpoch;
    return startOfDayMill;
  }

  String? convert_date_tostring(String format, DateTime datetime) {
    // "yyyy-MM-dd hh:mm:ss"

    try {
      String date_str = DateFormat(format).format(datetime);
      return date_str;
    } catch (e) {
      print("conversion error");
      return null;
    }
  }

  String? convert_date_toweekday(DateTime datetime) {
    // "yyyy-MM-dd hh:mm:ss"

    try {
      String dayOfWeek = DateFormat('EEEE').format(datetime);
      return dayOfWeek;
    } catch (e) {
      print("conversion error");
      return null;
    }
  }

  String fixnull(String value) {
    // If null, make it ""

    if (value.toString() == "null" || value.toString() == "NULL") {
      return "";
    } else {
      return value;
    }
  }

  int calculate_diff(DateTime dob) {
    final date2 = DateTime.now();
    final difference = date2.difference(dob).inDays;
    return difference;
  }

  String calculate_age(String? dob) {
    DateTime? birthday =
        Date_Conversions().convert_stringto_date(Constants.DATE_format, dob!);
    int age = (Date_Conversions().calculate_diff(birthday!) / 365).floor();
    return age.toString();
  }

  String getCurrentDate(String format) {
    DateTime currdate = DateTime.now();
    String currdate_str = convert_date_tostring(format, currdate).toString();
    return currdate_str;
  }

  int getTimeinmill() {
    final curr_mill = DateTime.now().millisecondsSinceEpoch;
    return curr_mill;
  }

  int getTimeinmill_Currentday() {
    // Get the current DateTime
    DateTime currentDateTime = DateTime.now();

    // Set the hour and minute to 12:00 PM
    DateTime modifiedDateTime = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      0, // hour
      0, // minute
    );

    // Convert the modified DateTime to milliseconds since epoch
    final curr_mill = modifiedDateTime.millisecondsSinceEpoch;
    return curr_mill;
  }

  DateTime convertMillisToDate(int millis) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    return dateTime;
  }

  int getTimeinmillfromDate(DateTime inputdate) {
    final curr_mill = inputdate.millisecondsSinceEpoch;
    return curr_mill;
  }

  String calculateTimeAgo(DateTime? pastTime) {
    DateTime now = DateTime.now();

    if (pastTime != null) {
      Duration difference = now.difference(pastTime);

      if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays == 1 ? 'day ago' : 'days ago'}';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour ago' : 'hours ago'}';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute ago' : 'minutes ago'}';
      } else {
        return 'Just now';
      }
    }
    return "now";
  }
}
