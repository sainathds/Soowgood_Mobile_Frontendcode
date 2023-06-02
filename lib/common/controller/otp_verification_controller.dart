import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/model/request/confirm_verification_request.dart';
import 'package:soowgood/common/model/response/confirm_verification_response.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/screen/set_password_screen.dart';

import '../dialog/ok_dialog.dart';
import '../local_database/my_shared_preference.dart';
import '../repository/common_repository.dart';

class OtpVerificationController extends GetxController{

  CommonRepository commonRepository = CommonRepository();

  dynamic argumentData = Get.arguments;
  String callFrom = '';

  var isOtpEmpty = false.obs;
  var isOtpInvalid = false.obs;
  var enteredOtp = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    callFrom = argumentData[0]['callFrom'];
    log('CallFrom : $callFrom');
    super.onInit();
  }


  ///*
  /// check validation is otp length or not
  void isDataValid() {
    if (enteredOtp.value.length != 4 ) {
      isOtpEmpty.value = true;
    } else {
      log('OtpVerification  : Successfully Validate');
      getConfirmVerificationResponse();

    }
  }


  ///*
  ///
  /// get Users/confirmverification Api Response
  void getConfirmVerificationResponse() async{
    ConfirmVerificationRequest requestModel = ConfirmVerificationRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.userRole = MySharedPreference.getString(KeyConstants.keyUserRole);
    requestModel.userName = MySharedPreference.getString(KeyConstants.keyUserName);
    requestModel.verificationotp = MySharedPreference.getString(KeyConstants.keyResponseOtp);
    requestModel.currentverificationotp = enteredOtp.value;
    log('getConfirmVerificationResponse : ${json.encode(requestModel)}');


    ConfirmVerificationResponse? responseModel = await commonRepository.hitConfirmVerificationApi(requestModel);

    if(responseModel != null){
      if(responseModel.success == '1'){
        log('getConfirmVerificationResponse : ${json.encode(responseModel)}');
        MySharedPreference.setString(KeyConstants.keyUserId, responseModel.id);
        Get.offAll(() => const SetPasswordScreen());

      }else{
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: responseModel.message,
            img: errorImage,
          ),
        );
      }
    }

  }
}