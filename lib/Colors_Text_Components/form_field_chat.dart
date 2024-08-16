// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Cust_Form_field_chat extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Function()? onChangedFnction;
  // final String cus_label;
  final String hintText;
  final bool? enabled;

  const Cust_Form_field_chat(
      {super.key,
      // required this.cus_label,
      this.controller,
      this.validator,
      this.onChangedFnction,
      this.keyboardType,
      required this.hintText,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width - 70,
      width: MediaQuery.of(context).size.width - 110,
      margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
      // height: 48,
      decoration: ShapeDecoration(
        color: Color.fromARGB(51, 255, 246, 246),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: TextFormField(
          minLines: 1,
          maxLines: 4,
          style: const TextStyle(
              fontFamily: "Kanit",
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color.fromARGB(255, 6, 6, 6)),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            hintText: hintText,

            labelStyle: TextStyle(
                fontFamily: "Kanit",
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.4)),
            // labelText: cus_label,
            // prefixIcon: Icon(Icons.email),
          ),
          enabled: enabled,
          keyboardType: keyboardType,
          controller: controller,
          onChanged: (value) {
            if (onChangedFnction != null) {
              onChangedFnction!.call(); // Invoke onSaved if it is not null
            }
          },
          // initialValue: val,
          // validator: (value) {
          //   return "true";
          //   // return addprofiledetailContoller.validateName(value!);
          // },
          validator: validator,
        ),
      ),
    );
  }
}
