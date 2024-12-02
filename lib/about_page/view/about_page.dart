import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/Colors.dart';
import '../controller/about_page_controller.dart';

class AboutScreenPage extends StatelessWidget {
  final pageController = Get.put(AboutScreenPageController());

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
                child: Padding(padding: EdgeInsets.only(left: 10,right: 10),

                  child: Column(

                    children: [
                      SizedBox(height: 100.h,),
                      Text(
                        "About page  ",
                        style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.sp,
                        ),
                      ),
                      SizedBox(height: 20.h,),
                     Obx(()=> Text(
                       "Id:: ${pageController.item_id.value}  ",
                       style: TextStyle(
                         color: appColor,
                         fontWeight: FontWeight.bold,
                         fontSize: 23.sp,
                       ),
                     )),
                      SizedBox(height: 30.h,),
                      Text(
                        """
                      Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 
                      """,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 15.sp,
                        ),
                      )
                    ],
                  ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
