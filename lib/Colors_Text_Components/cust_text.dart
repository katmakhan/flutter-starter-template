// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:app_name/Colors_Text_Components/colors.dart';

class Cust_Text extends StatelessWidget {
  final String text;
  const Cust_Text({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: "Kanit",
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: AppColors.White,
      ),
    );
  }
}

class Cust_Text_dark extends StatelessWidget {
  final String custtext;
  const Cust_Text_dark({super.key, required this.custtext});
  @override
  Widget build(BuildContext context) {
    return Text(custtext,
        style: const TextStyle(
            fontFamily: 'Kanit',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.DarkGreen));
  }
}

class Cust_subhead_dark extends StatelessWidget {
  final String subhead_dark;
  const Cust_subhead_dark({super.key, required this.subhead_dark});
  @override
  Widget build(BuildContext context) {
    return Text(
      subhead_dark,
      style: const TextStyle(
        color: AppColors.Black,
        fontSize: 16,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w600,
        height: 1,
      ),
    );
  }
}

class Cust_subhead_white extends StatelessWidget {
  final String subhead_white;
  const Cust_subhead_white({super.key, required this.subhead_white});
  @override
  Widget build(BuildContext context) {
    return Text(
      subhead_white,
      style: const TextStyle(
        color: AppColors.White,
        fontSize: 16,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w600,
        height: 1,
      ),
    );
  }
}

class Cust_text_dark_14 extends StatelessWidget {
  final String text14_dark;
  const Cust_text_dark_14({super.key, required this.text14_dark});
  @override
  Widget build(BuildContext context) {
    return Text(
      text14_dark,
      style: const TextStyle(
        color: AppColors.Black,
        fontSize: 14,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w600,
        height: 0.08,
      ),
    );
  }
}

class Cust_text_dark_12 extends StatelessWidget {
  final String text12_dark;
  const Cust_text_dark_12({super.key, required this.text12_dark});
  @override
  Widget build(BuildContext context) {
    return Text(
      text12_dark,
      style: const TextStyle(
        color: AppColors.White,
        fontSize: 14,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w600,
        height: 0.08,
      ),
    );
  }
}

class Cust_text_black_12 extends StatelessWidget {
  final String text12_black;
  const Cust_text_black_12({super.key, required this.text12_black});
  @override
  Widget build(BuildContext context) {
    return Text(
      text12_black,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w600,
        height: 0,
      ),
    );
  }
}

class Cust_lightshade_white extends StatelessWidget {
  final String text_light;

  const Cust_lightshade_white({super.key, required this.text_light});
  @override
  Widget build(BuildContext context) {
    return Text(
      text_light,
      style: const TextStyle(
        color: Color(0xFFAFAFAF),
        fontSize: 8,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w500,
        height: 0,
      ),
    );
  }
}

class Cust_green_text extends StatelessWidget {
  final String text_green;

  const Cust_green_text({super.key, required this.text_green});
  @override
  Widget build(BuildContext context) {
    return Text(
      text_green,
      style: const TextStyle(
        color: Color(0xFF1BD592),
        fontSize: 10,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w600,
        height: 0,
      ),
    );
  }
}

class Cust_red_text extends StatelessWidget {
  final String text_red;

  const Cust_red_text({super.key, required this.text_red});
  @override
  Widget build(BuildContext context) {
    return Text(
      text_red,
      style: const TextStyle(
        color: Color.fromARGB(255, 213, 27, 27),
        fontSize: 10,
        fontFamily: 'Kanit',
        fontWeight: FontWeight.w600,
        height: 0,
      ),
    );
  }
}
