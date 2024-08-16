import 'package:app_name/Colors_Text_Components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Container noResultFoundPhoto(String heading, String asset) {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        SvgPicture.asset(asset),
        const SizedBox(
          height: 30,
        ),
        Text(
          heading,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "The following query resulted in zero result, Please check again after sometime. If you still facing the issue, kindly contact the admin \n\n email: appapp_name@gmail.com",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

Container noResultFoundPhotoDark(String heading, String asset) {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        SvgPicture.asset(asset),
        const SizedBox(
          height: 30,
        ),
        Text(
          heading,
          style: const TextStyle(
              fontSize: 16,
              color: AppColors.White,
              fontFamily: 'Kanit',
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "The following query resulted in zero result, Please check again after sometime. If you still facing the issue, kindly contact the admin \n\n email: appapp_name@gmail.com",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.White.withOpacity(0.5),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
