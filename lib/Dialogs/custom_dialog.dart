import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(
      BuildContext context,
      String title,
      String description,
      String okBtnText,
      String cancelBtnText,
      Function okBtnFunction) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: Text(description),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () => {okBtnFunction.call()},
                    child: Text(okBtnText)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 16, 0),
                child: InkWell(
                    onTap: () => {Navigator.pop(context)},
                    child: Text(cancelBtnText)),
              )
            ],
          );
        });
  }

  void showCustomDialogGreen(BuildContext context, String title, String descrip,
      String date, String image, Function okBtnFunction) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return AlertDialog(
          // backgroundColor: Colors.black.withOpacity(0.2),
          content: Center(
            child: Container(
              width: 260,
              height: 380,
              decoration: ShapeDecoration(
                color: const Color(0xFF1BD592),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () => {Navigator.pop(context)},
                          child:
                              SvgPicture.asset("assets/images/closebtn.svg")),
                      const SizedBox(
                        width: 4,
                      )
                    ],
                  ),
                  SvgPicture.asset(image),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 200,
                        height: 98,
                        decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10)),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  descrip,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF014342),
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Expanded(
                                child: Text(
                                  date,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF014342),
                                    fontSize: 14,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => {okBtnFunction.call()},
                        child: Container(
                          width: 60,
                          height: 98,
                          decoration: const ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10)),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'OK',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Kanit',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void showCustomDialogUpdate(
      BuildContext context,
      String title,
      String descrip,
      String okBtnText,
      String cancelBtnText,
      Function okBtnFunction,
      Function cancelBtnFunction,
      bool compulsory) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: !compulsory,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () {
            // return Future.value(false);
            return Future.value(!compulsory);
          },
          child: Center(
            child: Container(
              height: 200,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              // child: UpdateRequiredBox(),
              child: SizedBox.expand(
                  child: DialogContent(
                      title,
                      descrip,
                      okBtnText,
                      context,
                      cancelBtnText,
                      okBtnFunction,
                      cancelBtnFunction,
                      compulsory)),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  static Container DialogContent(
      String title,
      String description,
      String okBtnText,
      BuildContext context,
      String cancelBtnText,
      Function acceptFunction,
      Function DeclineFunction,
      bool compulsory) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            child: Text(title,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    decoration: TextDecoration.none,
                    fontSize: 20,
                    color: Color(0xFF363e44),
                    fontWeight: FontWeight.w700)),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 16),
            child: Text(description,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    decoration: TextDecoration.none,
                    fontSize: 16,
                    color: const Color(0xFF45413C).withOpacity(0.8),
                    fontWeight: FontWeight.w400)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: !compulsory,
                  child: GestureDetector(
                    onTap: () => {DeclineFunction.call()},
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: Text(
                        cancelBtnText,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.none,
                            fontSize: 12,
                            color: Color(0xFFE61E26),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {acceptFunction.call()},
                  child: Container(
                    height: 28,
                    width: 86,
                    decoration: const BoxDecoration(
                      color: Color(0xff9E00FF),
                    ),
                    child: Center(
                      child: Text(
                        okBtnText,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            decoration: TextDecoration.none,
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
