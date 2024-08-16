// ignore_for_file: constant_identifier_names

class Constants {
  static const String MAX_IMAGE_SIZE_MESSAGE = "Image should be less than 1MB";
  static const double MAX_IMAGE_SIZE = 5 * 1024 * 1024;

  static const String MAX_PDF_SIZE_MESSAGE = "PDF should be less than 12MB";
  static const double MAX_PDF_SIZE = 48 * 1024 * 1024;

  static const String DATE_format = "dd/MM/yyyy";
  static const String DATE_format_storing = "yyyy/MM/";
  static const String TIME_format = "hh:mm:ss a";
  static const String TIME_format_tradejournal = 'dd/MM/yyyy hh:mm a';
  static const String TIME_format_chatimage = 'dd_MM_yyyy_hh_mm_a';

  static const String REWARD_ADID_IOS = 'ca-app-pub-3444444444/333333';
  static const String REWARD_ADID_ANDROID = 'ca-app-pub-3344444444/333333';

  static const double ADVIEW_BAL = 5000;

  static const double INITAL_BAL_LIVE = 30000.0;
}
