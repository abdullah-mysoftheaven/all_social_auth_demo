import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/Colors.dart';
import '../controller/facebook_auth_page_controller.dart';

class FaceBookAuthScreenPage extends StatelessWidget {
  final pageController = Get.put(FaceBookAuthPageController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: imageBgColor,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    ElevatedButton(
                      onPressed: () async {
                        try {
                          UserCredential? userCredential = await pageController.signInWithFacebook();
                          print('Sign-in successful');

                          User? user = userCredential.user;
                          // Print user data using the new method
                          pageController.printUserData(user);
                        } catch (e) {
                          print('Error signing in: $e');
                        }
                      },
                      child: Text(
                        "Facebook Login",
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
                         await pageController.signOutWithFacebook();
                      },
                      child: Text(
                        "Facebook Sign Out",
                        style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 45.h),
                    Obx(()=>Text(
                      "UserInfo : ${pageController.userInfo.value}",
                      style: TextStyle(
                        color: appColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    )),


                    // Expanded(child: Container(), flex: 3),
                  ],
                ),
              ),
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
                        "Social Auth Facebook",
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
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

}
