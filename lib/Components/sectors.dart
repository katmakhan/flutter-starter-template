import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

InkWell Sector(
    SvgPicture svgMPicture, String mainheading, VoidCallback ontapFunction) {
  return InkWell(
    onTap: ontapFunction,
    child: Container(
      margin: EdgeInsets.fromLTRB(6, 6, 6, 6),
      height: 58,
      decoration: BoxDecoration(
        color: Color(0xff1B1B1B),
        border: Border.all(width: 1, color: Color(0xff363636)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              svgMPicture,
              SizedBox(
                width: 12,
              ),
              Text(
                mainheading,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ],
          ),
          SvgPicture.asset("assets/images/whitearrowsector.svg")
        ],
      ),
    ),
  );
}
