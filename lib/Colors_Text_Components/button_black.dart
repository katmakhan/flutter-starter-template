import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonBlack extends StatelessWidget {
  final Function() onTap;
  final String custtext;
  const ButtonBlack({super.key, required this.custtext, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 129,
        height: 40,
        decoration: ShapeDecoration(
          color: const Color(0xFF0A0A0A),
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
