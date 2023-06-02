import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/screen/otp_verification_screen.dart';

import '../dialog/ok_dialog.dart';
import '../local_database/key_constants.dart';
import '../local_database/my_shared_preference.dart';
import '../model/request/forgot_password_request.dart';
import '../model/response/forgot_password_response.dart';
import '../repository/common_repository.dart';
import '../resources/my_assets.dart';

class ForgotPasswordController extends GetxController {

  CommonRepository commonRepository = CommonRepository();
  TextEditingController emailPhoneController = TextEditingController();
  var isEmailPhoneEmpty = false.obs;
  String userRole = '';


  ///*
  ///
  ///
  void isDataValid(){
    if(emailPhoneController.text.isEmpty){
      isEmailPhoneEmpty.value = true;

    }else {
      getForgotPasswordApiResponse();
    }
  }


  ///*
  ///
  ///
  void getForgotPasswordApiResponse() async{

    ForgotPasswordRequest requestModel = ForgotPasswordRequest();
    requestModel.email = emailPhoneController.text.trim();

    ForgotPasswordResponse? responseModel = await commonRepository.hitForgotPasswordApi(requestModel);

    if(responseModel != null){
      if(responseModel.success == '1'){
        log("getForgotPasswordApiResponse : ${responseModel.message}");

        MySharedPreference.setString(KeyConstants.keyUserId, responseModel.id);
        MySharedPreference.setString(KeyConstants.keyUserRole, responseModel.userRole!);
        MySharedPreference.setString(KeyConstants.keyUserName, responseModel.email);
        MySharedPreference.setString(KeyConstants.keyResponseOtp, responseModel.verificationotp);
        Get.off(const OtpVerificationScreen(), arguments: [{'callFrom' : 'forgotPass'}]);

      }else{
        log("getForgotPasswordApiResponse : ${responseModel.message}");
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: responseModel.message,
            img: errorImage,
          ),
        );
      }
    }else{
      log("getForgotPasswordApiResponse : NULL" );
    }
  }

}