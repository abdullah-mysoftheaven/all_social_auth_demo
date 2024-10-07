import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/Colors.dart';
import '../controller/splash_screen_page_controller.dart';

class SplashScreenPage extends StatelessWidget {
  final pageController = Get.put(SplashScreenPageController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: imageBgColor,
      body: Container(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(child: Container(), flex: 2),
                                        ElevatedButton(
                                          onPressed: () async {
                                            try {
                                              UserCredential userCredential = await pageController.signInWithGoogle();
                                              print('Sign-in successful');

                                              User? user = userCredential.user;
                                              // Print user data using the new method
                                              pageController.printUserData(user);
                                            } catch (e) {
                                              print('Error signing in: $e');
                                            }
                                          },
                                          child: Text(
                                            "Google Login",
                                            style: TextStyle(
                                              color: appColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        ElevatedButton(
                                          onPressed: () async {
                                            await pageController.signOutWithGoogle();
                                          },
                                          child: Text(
                                            "Google Sign Out",
                                            style: TextStyle(
                                              color: appColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        Obx(()=>Text(
                                          "UserInfo : ${pageController.userInfo.value}",
                                          style: TextStyle(
                                            color: appColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.sp,
                                          ),
                                        )),

                                        SizedBox(height: 15.h),
                                        TweenAnimationBuilder(
                                          tween: Tween<double>(begin: Get.width / 4, end: 0),
                                          duration: Duration(milliseconds: 2000), // Adjust the duration as needed
                                          builder: (_, double value, __) {
                                            return Transform.translate(
                                              offset: Offset(value, 0),
                                              child: Text(
                                                "Social Login",
                                                style: TextStyle(
                                                  color: appColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.sp,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Expanded(child: Container(), flex: 3),
                                      ],
                                    ),
                                  ),
                                  TweenAnimationBuilder(
                                    tween: Tween<double>(begin: -30, end: 0),
                                    duration: Duration(seconds: 1), // Adjust the duration as needed
                                    builder: (_, double value, __) {
                                      return Transform.translate(
                                        offset: Offset(0, value),
                                        child: Text(
                                          "Developed By",
                                          style: TextStyle(
                                            fontFamily: "Noto Sans Bengali UI",
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff000000),
                                            height: 19 / 14,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      );
                                    },
                                  ),
                                  TweenAnimationBuilder(
                                    tween: Tween<double>(begin: 30, end: 0),
                                    duration: const Duration(seconds: 1), // Adjust the duration as needed
                                    builder: (_, double value, __) {
                                      return Transform.translate(
                                        offset: Offset(0, value),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Social Auth",
                                              style: TextStyle(
                                                fontFamily: "Noto Sans Bengali UI",
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff000000),
                                                height: 27 / 20,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
