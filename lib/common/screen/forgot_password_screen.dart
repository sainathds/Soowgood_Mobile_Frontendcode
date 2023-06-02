import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/controller/forgor_password_controller.dart';
import 'package:soowgood/common/resources/my_assets.dart';

import '../resources/my_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  ForgotPasswordController getXController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Obx((){
              return Column(
                children: [

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250.0,
                    child: Image(
                      image: setPasswordImg,
                      fit: BoxFit.fill,
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: MyColor.themeTealBlue,
                      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [

                            const Text(
                              'Password Recovery',
                              style: TextStyle(
                                  color: MyColor.offWhite,
                                  fontSize: 24.0,
                                  fontFamily: 'poppins_bold'
                              ),
                            ),

                            const Text(
                              'Please enter your email address or phone number to receive a verification code.',
                              style: TextStyle(
                                  color: MyColor.offWhite,
                                  fontSize: 13.0,
                                  fontFamily: 'poppins_regular'
                              ),
                            ),

                            const SizedBox(height: 30.0,),
                            emailOrPhoneWidget(),


                            const SizedBox(height: 30.0,),
                            continueButtonWidget(),

                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              );
            })
        ));

  }


  ///*
  ///
  ///
  emailOrPhoneWidget() {
    return TextFormField(
      onTap: () {
        getXController.isEmailPhoneEmpty.value = false;
      },
      controller: getXController.emailPhoneController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_medium'
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0),
          hintText: 'Email Address/Phone Number',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isEmailPhoneEmpty.value == true? "Please Enter Email Address/Phone Number" : null
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
                fontSize: 16.0,
                fontFamily: 'poppins_semibold'
            ),
          )),
    );

  }

}
