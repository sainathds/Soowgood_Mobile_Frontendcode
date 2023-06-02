import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/model/request/verify_user_request.dart';
import 'package:soowgood/common/model/response/verify_user_response.dart';
import 'package:soowgood/common/repository/common_repository.dart';
import 'package:soowgood/common/screen/otp_verification_screen.dart';

import '../dialog/ok_dialog.dart';
import '../resources/my_assets.dart';

class SignupController extends GetxController{

  CommonRepository commonRepository = CommonRepository();


  TextEditingController emailPhoneController = TextEditingController();
  var isEmailPhoneEmpty = false.obs;

  String userRole = '';


    @override
    void onInit() {
    // TODO: implement onInit
      super.onInit();
  }


  ///*
  ///
  /// check validation for email
    void isSignUpDataValid(){
      log('TestCase 1 :$isEmailPhoneEmpty');
      if(emailPhoneController.text.isEmpty){
        isEmailPhoneEmpty.value = true;
        log('TestCase 2 :$isEmailPhoneEmpty');

      }else {
        getVerifyUserApiResponse();
      }
    }

  ///*
  ///
  /// get Users/verifyuser Api Response
  /// use to get otp on email
  void getVerifyUserApiResponse() async{

      VerifyUserRequest requestModel = VerifyUserRequest();
      requestModel.email = emailPhoneController.text.trim();
      requestModel.userRole = userRole;

      VerifyUserResponse? verifyUserResponse = await commonRepository.hitVerifyUserApi(requestModel);

      if(verifyUserResponse != null){
        if(verifyUserResponse.success == '1'){
          log("getSignupApiResponse : ${verifyUserResponse.message}");

          MySharedPreference.setString(KeyConstants.keyUserId, "");
          MySharedPreference.setString(KeyConstants.keyUserRole, verifyUserResponse.userRole!);
          MySharedPreference.setString(KeyConstants.keyUserName, verifyUserResponse.email);
          MySharedPreference.setString(KeyConstants.keyResponseOtp, verifyUserResponse.verificationotp);
          Get.to(() => const OtpVerificationScreen(), arguments: [{'callFrom' : 'signup'}]);

        }else{
          log("getSignupApiResponse : ${verifyUserResponse.message}");
          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: verifyUserResponse.message,
              img: errorImage,
            ),
          );
        }
      }else{
        log("getSignupApiResponse : NULL" );
      }
  }
}