import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

InkWell HomepageIcons(
    VoidCallback ontapFunction, String sectiontext, SvgPicture svgicon) {
  return InkWell(
    onTap: ontapFunction,
    child: Container(
      // width: 70,
      margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          svgicon,
          SizedBox(
            height: 12,
          ),
          Container(
            width: 70,
            child: Text(
              sectiontext,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 10,
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w500,
                // height: 1,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
