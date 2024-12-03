import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/Colors.dart';
import '../../cyper_text.dart';
import '../../decryption_data.dart';
import '../../encryption_data.dart';
import '../../rsa.dart';
import '../controller/contact_us_page_controller.dart';

class ContactUsScreenPage extends StatelessWidget {
  final pageController = Get.put(ContactUsScreenPageController());

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
                      SizedBox(height: 60.h,),
                      Text(
                        "Contact Us",
                        style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.sp,
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      InkWell(
                        onTap: (){



                          // pageController.sha256encryptionAndDecryption();


                          // pageController.rsaencryptionAndDecryption();


                          CyperText().mainFunction("vhg544nbh544v","1");

                        },
                        child:Container(
                          padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 15.h,bottom: 15.h),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10.r)
                          ),
                          child: Text(
                            "Encryption Data",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                        ) ,
                      ),
                      
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
