import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:soowgood/common/controller/otp_verification_controller.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {


  OtpVerificationController getXController = Get.put(OtpVerificationController());

  @override
  void initState() {
    // TODO: implement initState

    MySharedPreference.getInstance(); //get instance of ShearedPref


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: MyColor.themeTealBlue,
         appBar: AppBar(
           elevation: 0.0,
           backgroundColor: Colors.transparent,
           leading: InkWell(
             onTap: (){
               Get.back();
             },
             child: Padding(
               padding: const EdgeInsets.all(10.0),
               child: Image(image: backArrowWhiteIcon),
             ),
           ),
           centerTitle: true,
           title: const Text('Code Verification',
           style: TextStyle(
             color: MyColor.offWhite,
             fontSize: 17.0,
             fontFamily: 'poppins_semibold'
           ),),

         ),
        body: Obx((){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0,right: 15.0,bottom: 20),
                child: Text('We sent a verification code to your email. Enter the code from the email in the field below.',
                  style: TextStyle(
                      color: MyColor.offWhite,
                      fontSize: 13.0,
                      fontFamily: 'poppins_medium'
                  ),
                textAlign: TextAlign.center,),
              ),
              Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [

                    Positioned(
                        top: 40,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyColor.offWhite)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              SizedBox(height: 20,),
                              !getXController.isOtpEmpty.value ?
                              const Text('Enter verification Code',
                                style: TextStyle(
                                    color: MyColor.offWhite,
                                    fontSize: 17.0,
                                    fontFamily: 'poppins_semibold'
                                ),)

                              : getXController.isOtpEmpty.value?
                                  const Text('Enter 4 digit OTP',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 17.0,
                                    fontFamily: 'poppins_semibold'
                                ),)

                              : getXController.isOtpInvalid.value?
                              const Text('Wrong Code Please Try Again',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 17.0,
                                    fontFamily: 'poppins_semibold'
                                ),)

                                  : SizedBox(),



                              SizedBox(height: 20,),

                              otpWidget()

                            ],
                          ),
                        )),

                    Positioned(
                        top: 0,
                        child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Colors.white,

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image(image: lockIcon,),
                            ))),

                  ],),
              ),

              Padding(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: continueButtonWidget(),

              )

            ],
          );
        })
      ),
    );
  }


  ///*
  ///
  ///
  otpWidget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      child: PinCodeTextField(
        appContext: context,
        textStyle: const TextStyle(
            fontSize: 16.0,
            color: MyColor.themeTealBlue,
            fontFamily: 'poppins_semibold'
        ),
        length: 4,
        animationType: AnimationType.fade,
        validator: (v) {
          if (v!.length < 4) {
            return "";
          } else {
            return null;
          }
        },
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 45,
          fieldWidth: 45,
          activeColor: MyColor.activeOtp,
          activeFillColor: MyColor.activeOtp,

          selectedColor: MyColor.selectedOtp,
          selectedFillColor: MyColor.selectedOtp,

          inactiveColor: MyColor.inactiveOtp,
          inactiveFillColor: MyColor.inactiveOtp,
        ),
        cursorColor: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          getXController.enteredOtp.value = v;
          log('OtpVerification Value : $v');
          log('OtpVerification EnteredOtp : ${getXController.enteredOtp.value}');
          },

        onChanged: (v){
          getXController.isOtpInvalid.value = false;
          getXController.isOtpEmpty.value = false;

        },
      ),
    );
  }


  ///*
  ///
  ///
  continueButtonWidget() {
    return SizedBox(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: (){
            getXController.isDataValid();
          },
          style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),),
          child: const Text(
            'Continue',
            style: TextStyle(
                color: MyColor.offWhite,
                fontSize: 15.0,
                fontFamily: 'poppins_semibold'
            ),
          )),
    );

  }

}
