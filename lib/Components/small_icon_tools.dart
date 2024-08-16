import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app_name/Helpers/textstyles.dart';

InkWell smallIcon(
    String iconText, SvgPicture svgIcon, VoidCallback onTapFunction) {
  return InkWell(
    onTap: () {
      onTapFunction.call();
    },
    child: Column(
      children: [
        svgIcon,
        SizedBox(
          height: 8,
        ),
        Text(iconText,
            textAlign: TextAlign.center,
            style: CustomTextStyle.COMPONENT_INSIDEBUTTON_STYLE_WHITE),
      ],
    ),
  );
}
