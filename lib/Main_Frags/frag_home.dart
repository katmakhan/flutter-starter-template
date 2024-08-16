import 'package:flutter/material.dart';
import 'package:app_name/Auth_Service/auth_service.dart';
import 'package:app_name/Colors_Text_Components/colors.dart';
import 'package:app_name/Dialogs/no_resulfound_nobutton.dart';

class FragHome extends StatefulWidget {
  const FragHome({Key? key}) : super(key: key);

  @override
  State<FragHome> createState() => _FragHomeState();
}

class _FragHomeState extends State<FragHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    AuthService().logOut();
                  },
                  child: noResultFoundNoButton(context, "Click here to logout"))
            ],
          ),
        ));
  }
}
