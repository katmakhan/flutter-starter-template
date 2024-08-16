import 'package:app_name/DB_Services/database_write.dart';
import 'package:app_name/DataModels/dm_reg_users.dart';
import 'package:app_name/DataModels/dm_testimonials.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app_name/Helpers/global_snackbar_get.dart';

class DatabaseReadService {
  FirebaseDatabase db = FirebaseDatabase.instance;
  //Get Gallery
  Future<List<dm_testimonials>?> getTestimonials() async {
    final ref = db.ref();
    DataSnapshot snapshot =
        await ref.child('testimonials').orderByChild("timeinmill").get();

    List<dm_testimonials> testimoniallist = [];
    if (snapshot.exists) {
      var datalist = snapshot.value as Map<dynamic, dynamic>;
      datalist.forEach((key, value) {
        // print("Data is: $value");
        dm_testimonials testi = dm_testimonials();
        testi = dm_testimonials.fromJson(value);
        testi.tskey = key;
        testimoniallist.add(testi);
      });
    } else {
      print('No testimonials found');
    }
    return testimoniallist;
  }

  //Get Adminlist
  Future<bool> getAdminList(suid) async {
    final ref = db.ref();
    bool isadmin = false;
    DataSnapshot snapshot = await ref.child('admins').child(suid).get();

    if (snapshot.exists) {
      isadmin = true;
    }
    return isadmin;
  }

  //Get User Details
  Future<bool?> getUserDetail(suid, dm_reg_user user) async {
    final ref = db.ref();
    bool foundflag = false;
    DataSnapshot snapshot = await ref.child('regusers').child(suid).get();

    if (snapshot.exists) {
      print("User Exist");
      GlobalSnackBarGet().showGetSucess(
          "Welcome", "Hi ${user.rgName}, welcome back to midfiled");
    } else {
      print('No user found');

      //Create new User
      await DatabaseWriteService().addUserData(suid, user);
    }
    return foundflag;
  }

  // Realtime Listeners for Buy Sell LTP Stocks
  // Stream<dm_stock> getrealtime_BuySellLtp_Stocks(
  //     String whichNifty, String stockname) {
  //   return FirebaseDatabase.instance
  //       .ref("livedata")
  //       .child(whichNifty) // Nifty50 or Nifty 100 or nifty 200
  //       .child(stockname)
  //       // .limitToFirst(1)
  //       .onValue
  //       .map((event) => dm_stock.fromJson(
  //           {"stckname": stockname.toString(), "ltp": event.snapshot.value}));
  // }
}
