import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class DatePickerHelper {
  void PickDate(
      BuildContext context, String format, TextEditingController controller) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1980, 3, 5),
        maxTime: DateTime.now(), onChanged: (date) {
      // print('change $date');
      Navigator.pop(context);
      // DateTime now = DateTime.now();
      // 'dd-MM-yyyy'
      String formattedDate = DateFormat(format).format(date);
      print(formattedDate);
      controller.text = formattedDate;
    }, onConfirm: (date) {
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  void PickDateandTime(
      BuildContext context, String format, TextEditingController controller) {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(1980, 3, 5),
        maxTime: DateTime.now(), onChanged: (date) {
      print('change $date');
      // Navigator.pop(context);
      // DateTime now = DateTime.now();
      // 'dd-MM-yyyy'
      String formattedDate = DateFormat(format).format(date);
      print(formattedDate);
      controller.text = formattedDate;
    }, onConfirm: (date) {
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
}
