import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Container noResultFoundTestimonial(String heading) {
  return Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        SvgPicture.asset("assets/images/nojournal.svg"),
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
          "The following query resulted in zero result, Please check again after sometime. If you still facing the issue, kindly contact the admin \n\n email: appapp_nameapp@gmail.com",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: const Color(0xff1c1c1c).withOpacity(0.3),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () => {
            // Navigator.pop(context)
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 16),
            decoration: BoxDecoration(
              color: const Color(0xFF2697FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text("Ok",
                  style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 14,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500)),
            ),
          ),
        )
      ],
    ),
  );
}
