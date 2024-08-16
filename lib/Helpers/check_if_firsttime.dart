import 'package:app_name/Helpers/date_conversion.dart';

bool CheckIfFirstTime(int lasttime) {
  bool flag = false;

  int currenttimeinmill = Date_Conversions().getTimeinmill();
  int current_day_timeinmill = Date_Conversions().getTimeinmillforCurrentDay();

  if (lasttime > current_day_timeinmill && lasttime < currenttimeinmill) {
    // Its valid, else, not
    flag = true;
  }

  return flag;
}
