import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class Database extends GetxController {
  final data = GetStorage();

  void writeBrokerLogedIn(String brokername, int timeinmill) {
    data.write('broker', brokername);
    data.write('updatedon', timeinmill);
  }

  void removeBrokerLogedIn() {
    data.remove('broker');
    data.remove('updatedon');
  }

  String getBrokerName() {
    return data.read("broker") ?? "none";
  }

  int getUpdatedOn() {
    return data.read("updatedon") ?? 0;
  }

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  bool checkAdViewCount() {
    // Get the current time in milliseconds
    // Read the last updated time from storage
    // Read the total count from storage
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    int lastUpdatedTimeInMillis = data.read('lastupdated') ?? 0;
    int count = data.read('totalcount') ?? 0;

    // Calculate the time difference in minutes
    int timeDifferenceInMinutes =
        (currentTimeInMillis - lastUpdatedTimeInMillis) ~/ (1000 * 60);

    // If 5 minutes have passed, reset the count and update the last updated time
    if (timeDifferenceInMinutes >= 5) {
      count = 0;
      data.write('firstupdated', currentTimeInMillis);
    }

    // Show the ad only if the count is less than 5
    if (count < 5) {
      // Increment the count
      // Update the last updated time
      // Update the total count
      count++;
      data.write('lastupdated', currentTimeInMillis);
      data.write('totalcount', count);

      // Return true to indicate that the ad should be shown
      print("Show ad");
      return true;
    } else {
      // Return false to indicate that the ad should not be shown
      print("Dont show ad");
      return false;
    }
  }
}
