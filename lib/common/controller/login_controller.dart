import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/screen/beneficiary_main_screen.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/model/request/fcm_data_request.dart';
import 'package:soowgood/common/model/request/login_request.dart';
import 'package:soowgood/common/model/response/fcm_data_response.dart';
import 'package:soowgood/common/model/response/login_response.dart';
import 'package:soowgood/provider/screen/provider_dashboard_screen.dart';

import '../repository/common_repository.dart';
import '../resources/my_assets.dart';

class LoginController extends GetxController{

  CommonRepository commonRepository = CommonRepository();

  TextEditingController emailPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isEmailPhoneEmpty = false.obs;
  var isPasswordEmpty = false.obs;

  var isPasswordObscure = true.obs;

  FocusNode passwordFocus = FocusNode();

  var fcmToken = ''.obs;

  ///*
  ///
  /// check validations for email and password field
  void isDataValid(){
    if(emailPhoneController.text.trim().isEmpty) {
      isEmailPhoneEmpty.value = true;

    }else if(passwordController.text.trim().isEmpty){
      setAllErrorToFalse();
      isPasswordEmpty.value = true;

    }else {
      log('LoginController : LoginData Valid');
      getLoginResponse();
    }
  }

  ///*
  ///
  ///
  void setAllErrorToFalse(){
    isEmailPhoneEmpty.value = false;
    isPasswordEmpty.value = false;
  }


  ///*
  ///
  /// get Users/login Api Response
  void getLoginResponse() async{

    LoginRequest requestModel = LoginRequest();
    requestModel.email = emailPhoneController.text.trim();
    requestModel.password = passwordController.text.trim();

    LoginResponse? responseModel = await commonRepository.hitLoginApi(requestModel);

    if(responseModel != null){

      if(responseModel.message == "User Exists! Login Successful!" || responseModel.message == "Your profile is under apporval, please contact system Administrator."){
        MySharedPreference.setBool(KeyConstants.keyIsLogin, true);
        MySharedPreference.setString(KeyConstants.keyUserId, responseModel.id);
        MySharedPreference.setString(KeyConstants.keyUserRole, responseModel.userRole);

        String userRole = responseModel.userRole!;
        getFcmDataResponse(userRole);

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


  ///*
  ///
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
        Get.off(const ProviderDashboardScreen());

      }else if(userRole == 'Beneficiar'){
        log('getLoginResponse UserRole _Beneficiar $userRole}');
        Get.off(const BeneficiaryMainScreen());

      }
    }

  }
}