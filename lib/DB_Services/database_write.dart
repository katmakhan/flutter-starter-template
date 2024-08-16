import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:app_name/DataModels/dm_reg_users.dart';
import 'package:app_name/Helpers/global_snackbar_get.dart';

class DatabaseWriteService {
  FirebaseDatabase db = FirebaseDatabase.instance;

  Future<bool> updateUserStatus(String key, String status) async {
    // bool is_sucess = false;
    final ref = db.ref();
    if (key == "null") {
      GlobalSnackBarGet().showGetError("Error", "No user key found");
      return false;
    }

    try {
      // make sure to use await function for catching exception
      ref.child("newmembers").child(key).child("st").set(status);

      GlobalSnackBarGet().showGetSucess("Sucess", "Details Updated.");
    } on PlatformException catch (err) {
      GlobalSnackBarGet().showGetError("Error", err.toString());
      print("Catched error: $err");
      return false;
    } catch (e) {
      print("Catched the database error:$e");
      return false;
    }

    return true;
  }

  Future<bool> updateUserFCM(String uidkey, String fcmkey) async {
    // bool is_sucess = false;
    final ref = db.ref();
    if (uidkey == "null") {
      // GlobalSnackBarGet().showGetError("Error", "No user key found");
      return false;
    }
    try {
      // make sure to use await function for catching exception
      ref.child("fcmlist").child(uidkey).child("fcmkey").set(fcmkey);
    } on PlatformException catch (err) {
      print("Catched error: $err");
      return false;
    } catch (e) {
      print("Catched the database error:$e");
      return false;
    }

    return true;
  }

  Future<bool> deleteFromRTD(String path, bool showit) async {
    // bool is_sucess = false;
    final ref = db.ref();
    print("Trying to delete $path");

    if (path.isEmpty || path == "") {
      GlobalSnackBarGet().showGetError("Error", "something went wrong");
      return false;
    }

    try {
      // make sure to use await function for catching exception
      await ref.child(path).remove();

      if (showit) {
        GlobalSnackBarGet().showGetSucess("Sucess", "Removed From RTD.");
      }
    } on PlatformException catch (err) {
      GlobalSnackBarGet().showGetError("Error", err.toString());
      print("Catched error: $err");
    } catch (e) {
      print("Catched the database error:$e");
      GlobalSnackBarGet().showGetError("Error", "Something else went wrong");
    }

    return true;
  }

  //Add registered user details, logged in users
  Future<bool> addUserData(suid, dm_reg_user user) async {
    bool is_sucess = false;
    final ref = db.ref();

    try {
      // make sure to use await function for catching exception
      await ref.child('regusers').child(suid).set(user.toJson());
      GlobalSnackBarGet().showGetSucess("Registered", "Welcome ${user.rgName}");
      is_sucess = true;
    } on PlatformException catch (err) {
      GlobalSnackBarGet().showGetError("Error", err.toString());
      print("Catched error: $err");
    } catch (e) {
      print("Catched the database error:$e");
      GlobalSnackBarGet().showGetError("Error", "Something else went wrong");
    }

    return is_sucess;
  }
}
