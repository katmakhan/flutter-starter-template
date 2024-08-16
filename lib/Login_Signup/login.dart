import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app_name/Auth_Service/auth_service.dart';
import 'package:app_name/Colors_Text_Components/colors.dart';
import 'package:app_name/DB_Services/database_read.dart';
import 'package:app_name/DataModels/dm_reg_users.dart';
import 'package:app_name/Helpers/constants.dart';
import 'package:app_name/Helpers/date_conversion.dart';
import 'package:app_name/Helpers/global_snackbar_get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/loginb.png"),
              fit: BoxFit.cover)),
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    const Color(0xff1BD692),
                    const Color(0xff0D7D33).withOpacity(.70)
                  ], // Gradient colors
                  begin: Alignment.topCenter, // Gradient start point
                  end: Alignment.bottomCenter, // Gradient end point
                ).createShader(bounds);
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(24, 50, 12, 20),
                child: const Text(
                  'App_name\nStart\nNow',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 80,
                    height: 1,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(24, 0, 100, 20),
              child: const Text(
                "Kindly follow, or leave a star in the github account of katmakhan",
                style: TextStyle(
                  color: Color(0xff9F9F9F),
                  fontSize: 16,
                  height: 1.2,
                  fontFamily: 'Kanit',
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
        Positioned(
          bottom: 120,
          left: 0,
          right: 0,
          child: LoginButton(context),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Platform.isIOS ? LoginAppleButton(context) : Container(),
        ),
      ]),
    ));
  }

  InkWell LoginAppleButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        await AuthService().signInWithApple();

        //Check if the user is created for the first time or not
        ChecKIfFirstTime();
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.Black,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/appleo.svg"),
              const SizedBox(
                width: 12,
              ),
              const Text(
                "Login with Apple",
                style: TextStyle(
                  fontFamily: "Kanit",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.White,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//
  InkWell LoginButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        await AuthService().signInWithGoogle();

        //Check if the user is created for the first time or not
        ChecKIfFirstTime();
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/google.svg"),
              const SizedBox(
                width: 12,
              ),
              const Text(
                "Login with Google",
                style: TextStyle(
                  fontFamily: "Kanit",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.White,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void ChecKIfFirstTime() async {
    try {
      var suid = FirebaseAuth.instance.currentUser!.uid;
      var email = FirebaseAuth.instance.currentUser!.email;
      var displayname = FirebaseAuth.instance.currentUser!.displayName;
      var profilepic = FirebaseAuth.instance.currentUser!.photoURL;

      dm_reg_user user = dm_reg_user();
      user.rgEmail = email;
      user.rgName = displayname;
      user.rgImage = profilepic;

      // Update with current date and time
      user.rgTimeinmill = Date_Conversions().getTimeinmill();
      user.rgTime = Date_Conversions().getCurrentDate(Constants.TIME_format);
      user.rgDate = Date_Conversions().getCurrentDate(Constants.DATE_format);

      await DatabaseReadService().getUserDetail(suid, user);
    } catch (e) {
      GlobalSnackBarGet()
          .showGetError("Invalid", "contact admin, something went wrong");
    }
  }
}
