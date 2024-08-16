import 'package:flutter/material.dart';
import 'package:app_name/Colors_Text_Components/colors.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final Widget? leading;

  final IconData? icon;
  const CustomAppbar({super.key, required this.title, this.leading, this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      bottomOpacity: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.lightgreen,
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: 'Kanit',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.White),
      ),
      leading: leading ??
          const BackButton(
            color: Colors.white,
          ),
    );
  }
}
