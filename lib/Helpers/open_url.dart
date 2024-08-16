import 'package:app_name/Helpers/global_snackbar_get.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenHelper {
  static Future<void> open_url(String url) async {
    print("Url to open" + url.toString());
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // can't launch url, there is some error
      GlobalSnackBarGet().showGetError("Error", "No links found.");
      throw "Could not launch $url";
    }
  }
}
