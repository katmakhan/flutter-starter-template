import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app_name/Colors_Text_Components/colors.dart';

class GreenButton extends StatelessWidget {
  final Function() onTap;
  final String custtext;
  const GreenButton({super.key, required this.custtext, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 129,
        height: 40,
        decoration: ShapeDecoration(
          color: AppColors.lightgreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17.74),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              custtext,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8.51,
                fontFamily: 'Kanit',
                fontWeight: FontWeight.w600,
                height: 0.20,
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            SvgPicture.asset("assets/images/wrighta.svg")
          ],
        ),
      ),
    );
  }
}
