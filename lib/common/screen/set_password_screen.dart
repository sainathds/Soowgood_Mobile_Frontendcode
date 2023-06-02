import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/controller/set_password_controller.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';

import '../resources/my_assets.dart';
import '../resources/my_colors.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);

  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {


  SetPasswordController getXController = Get.put(SetPasswordController());


  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance(); //get instance of ShearedPref

    getFcmToken();

    super.initState();
  }

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
                              'Set Your Password',
                              style: TextStyle(
                                  color: MyColor.offWhite,
                                  fontSize: 24.0,
                                  fontFamily: 'poppins_bold'
                              ),
                            ),

                            SizedBox(height: 10.0,),
                            const Text(
                              'For a strong password make sure to use Capital letters, numbers and symbols.',
                              style: TextStyle(
                                  color: MyColor.offWhite,
                                  fontSize: 13.0,
                                  fontFamily: 'poppins_regular'
                              ),
                            ),

                            const SizedBox(height: 30.0,),
                            passwordField(),


                            const SizedBox(height: 20.0,),
                            confirmPasswordField(),

                            const SizedBox(height: 40.0,),
                            confirmButtonWidget(),


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
  Widget passwordField() {
    return TextFormField(
      onTap: () {
        setState(() {
          getXController.setAllErrorToFalse();
        });
      },
      controller: getXController.passwordController,
      keyboardType: TextInputType.text,
      obscureText: getXController.isPasswordObscure.value,
      textInputAction: TextInputAction.next,
      focusNode: getXController.passwordFocus,
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
          hintText: 'Password',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          suffixIcon: IconButton(
          icon: Icon(
            getXController.isPasswordObscure.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              getXController.isPasswordObscure.value = !getXController.isPasswordObscure.value;
            });
          },
        ),
          errorText: getXController.isPasswordEmpty.value? "Please Enter Password" : getXController.isPasswordValid.value ? "Required minimum 6 character of Password" : null ,
      )
    );
  }



  ///*
  ///
  ///
  Widget confirmPasswordField() {
    return TextFormField(
        onTap: () {
          setState(() {
            getXController.setAllErrorToFalse();
          });
        },
        controller: getXController.confirmPasswordController,
        keyboardType: TextInputType.text,
        obscureText: getXController.isConfirmPasswordObscure.value,
        textInputAction: TextInputAction.next,
        focusNode: getXController.confirmPasswordFocus,
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
          hintText: 'Confirm Password',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          suffixIcon: IconButton(
            icon: Icon(
              getXController.isConfirmPasswordObscure.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () {
              setState(() {
                getXController.isConfirmPasswordObscure.value = !getXController.isConfirmPasswordObscure.value;
              });
            },
          ),
          errorText: getXController.isConfirmPasswordNotMatched.value? "Confirm password doesn't match" : null
        )
    );
  }


  ///*
  ///
  ///
  confirmButtonWidget() {
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
            'Confirm',
            style: TextStyle(
                color: MyColor.offWhite,
                fontSize: 16.0,
                fontFamily: 'poppins_semibold'
            ),
          )),
    );

  }

  ///
  ///
  /// get Firebase Token
  void getFcmToken() {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) {
      getXController.fcmToken.value = token!;
    });
  }

}



