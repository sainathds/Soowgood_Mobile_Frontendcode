import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/screen/beneficiary_main_screen.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/model/request/fcm_data_request.dart';
import 'package:soowgood/common/model/request/set_changed_password_request.dart';
import 'package:soowgood/common/model/response/fcm_data_response.dart';
import 'package:soowgood/common/model/response/set_changed_password_response.dart';
import 'package:soowgood/common/screen/login_screen.dart';
import 'package:soowgood/provider/screen/provider_dashboard_screen.dart';

import '../dialog/ok_dialog.dart';
import '../repository/common_repository.dart';
import '../resources/my_assets.dart';

class SetPasswordController extends GetxController{

  CommonRepository commonRepository = CommonRepository();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  var isPasswordEmpty = false.obs;
  var isPasswordValid = false.obs;
  var isConfirmPasswordNotMatched = false.obs;

  var isPasswordObscure = true.obs;
  var isConfirmPasswordObscure = true.obs;

  var fcmToken = ''.obs;

  ///*
  ///
  ///
  void setAllErrorToFalse() {
    isPasswordEmpty.value = false;
    isPasswordValid.value = false;
    isConfirmPasswordNotMatched.value = false;
  }


  ///*
  ///
  /// check validation for password and confirm password field
  void isDataValid() {

    if(passwordController.text.trim().isEmpty){
      isPasswordEmpty.value = true;

    }else if(passwordController.text.trim().length < 6){
      setAllErrorToFalse();
      isPasswordValid.value = true;

    }else if(passwordController.text.trim() != confirmPasswordController.text.trim()){
      setAllErrorToFalse();
      isConfirmPasswordNotMatched.value = true;

    }else {
      setAllErrorToFalse();
      log('SetPassword data is valid');
      getSetPasswordResponse();
    }
  }


  ///*
  ///
  /// get Users/changePassword Api Response
  void getSetPasswordResponse() async{
    SetChangedPasswordRequest requestModel = SetChangedPasswordRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.password = passwordController.text.trim();
    requestModel.confirmPassword = confirmPasswordController.text.trim();
    requestModel.oldPassword = '@Default123';

    SetChangedPasswordResponse? responseModel = await commonRepository.hitSetChangedPasswordApi(requestModel);

    if(responseModel != null){
      if(responseModel.message == 'Password Changed!'){
        log("getSetPasswordResponse : ${responseModel.message}");
        // Get.offAll(() => LoginScreen());

        MySharedPreference.setBool(KeyConstants.keyIsLogin, true);
        MySharedPreference.setString(KeyConstants.keyUserId, responseModel.id);
        MySharedPreference.setString(KeyConstants.keyUserRole, responseModel.userRole);

        String userRole = responseModel.userRole!;
        getFcmDataResponse(userRole);


      }else{
        log("getSetPasswordResponse : ${responseModel.message}");
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
      log("getSetPasswordResponse : NULL" );
    }

  }


  ///*
  ///
  /// get Users/AddUpdateDeviceInformation Api Response
  void getFcmDataResponse(String userRole) async{

    FcmDataRequest requestModel = FcmDataRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.devicekey = fcmToken.value;

    FcmDataResponse? responseModel = await commonRepository.hitFcmDataApi(requestModel);

    if(responseModel != null){
      log('FCM_DATA_RESPONSE ${responseModel.id}');
      if(userRole == 'Provider'){

        log('getLoginResponse UserRole _Provider $userRole}');
        Get.off(()=> const ProviderDashboardScreen());

      }else if(userRole == 'Beneficiar'){
        log('getLoginResponse UserRole _Beneficiar $userRole}');
        Get.off(()=> const BeneficiaryMainScreen());

      }
    }

  }

}