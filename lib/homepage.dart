// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app_name/Colors_Text_Components/colors.dart';
import 'package:app_name/Dialogs/custom_dialog.dart';
import 'package:app_name/Helpers/open_url.dart';
import 'package:app_name/Helpers/update_helper.dart';
import 'package:app_name/Main_Frags/frag_home.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

bool isSucess = true;

class _HomepageState extends State<Homepage> {
  bool compulsory = false;
  String androidurl =
      "https://play.google.com/store/apps/details?id=com.appapp_name.app";
  String iosurl = "https://apps.apple.com/in/app/appapp_name/id6447514602";

  List pages = [FragHome(), FragHome(), FragHome(), FragHome()];

  int currentIndex = 0;

  void onTap(int Index) {
    setState(() {
      currentIndex = Index;
    });
  }

  @override
  void initState() {
    // if (widget.fragpos != null) {
    //   currentIndex = widget.fragpos!;
    // } else {
    //   currentIndex = 0; //Default value
    // }
    // if (widget.issucess != null) {
    //   isSucess = widget.issucess!;
    // } else {
    //   isSucess = true; //Default value
    // }
    fetchRemoteConfig();
    super.initState();
  }

  // PageController _dotcontroller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          child: Container(
            height: Platform.isIOS ? 100 : 75,
            padding: const EdgeInsets.only(top: 10),
            color: AppColors.lightgreen,
            child: Theme(
              data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: AppColors.lightgreen,

                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: AppColors.White,
                // bottomAppBarColor: AppColors.White,
                // textTheme: Theme.of(context).textTheme.copyWith(
                //     caption: const TextStyle(
                //         color: Color(
                //             0xffe0e0e0)))
              ), // sets the inactive color of the `BottomNavigationBar`
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: currentIndex,
                  // selectedFontSize: 8,
                  // unselectedFontSize: 8,
                  onTap: onTap,
                  selectedLabelStyle: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  unselectedLabelStyle: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.5)),
                  selectedItemColor: AppColors.White,
                  unselectedItemColor: AppColors.White.withOpacity(0.8),
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/images/nhome.svg"),
                      label: "Home",
                      activeIcon: SvgPicture.asset("assets/images/ahome.svg"),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/images/ntrade.svg"),
                      label: "Trade",
                      activeIcon: SvgPicture.asset("assets/images/atrade.svg"),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/images/norder.svg"),
                      label: "Orders",
                      activeIcon: SvgPicture.asset("assets/images/aorder.svg"),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/images/ncourse.svg"),
                      label: "Courses",
                      activeIcon: SvgPicture.asset("assets/images/acourse.svg"),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/images/nprofile.svg"),
                      label: "Profile",
                      activeIcon:
                          SvgPicture.asset("assets/images/aprofile.svg"),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    try {
      // Using zero duration to force fetching from remote server.
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 120),
        ),
      );

      // Activate the oldervalues immediately
      await remoteConfig.activate();

      //Then fetch the latest values
      await remoteConfig.fetch();

      iosurl = remoteConfig.getString('ioslink');
      androidurl = remoteConfig.getString('androidlink');
      String message = remoteConfig.getString('Message');

      int latest_version = remoteConfig.getInt('latest_version');
      int min_version = remoteConfig.getInt('min_version');

      int bnumber = await getBuildNumber();
      print("Current Build Number: $bnumber");
      print("Latest Build Number: $latest_version");
      print("Min Build Number: $min_version");

      //Compulsory Logic
      if (bnumber < min_version) {
        compulsory = true;
      } else {
        compulsory = false;
      }

      //To show dialog
      if (bnumber < latest_version) {
        DialogUtils().showCustomDialogUpdate(
            context,
            "Update Available",
            message,
            "Update",
            "Cancel",
            updateFunction,
            cancelFunction,
            compulsory);
      }

      // DialogUtils().showCustomDialogUpdate(context, title, descrip, okBtnText, cancelBtnText, okBtnFunction, cancelBtnFunction)
    } catch (e) {
      // Handle error
      print('Error fetching remote config: $e');
    }
  }

  updateFunction() {
    // compulsory=
    if (Platform.isIOS) {
      print('is a IOS');
      OpenHelper.open_url(iosurl);
    } else if (Platform.isAndroid) {
      print('is a Andriod');
      OpenHelper.open_url(androidurl);
    } else {}
  }

  cancelFunction() {
    if (compulsory) {
    } else {
      Navigator.pop(context);
    }
  }
}
