import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/model/request/set_changed_password_request.dart';
import 'package:soowgood/common/model/response/set_changed_password_response.dart';
import 'package:soowgood/common/repository/common_repository.dart';
import 'package:soowgood/common/resources/my_assets.dart';

class ChangePasswordController extends GetxController{

  CommonRepository repository = CommonRepository();
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  var isCurrentPassEmpty = false.obs;
  var isNewPassEmpty = false.obs;
  var isConfirmPassEmpty = false.obs;
  var isConfirmPassNotMatched = false.obs;

  var isCurrentPassObscure = true.obs;
  var isNewPassObscure = true.obs;
  var isConfirmPassObscure = true.obs;


  ///*
  ///
  ///
  void isDataValid(){
    if(currentPassController.text.trim().isEmpty){
      isCurrentPassEmpty.value = true;
    }else if(newPassController.text.trim().isEmpty){
      setAllErrorToFalse();
      isNewPassEmpty.value = true;
    }else if(confirmPassController.text.trim().isEmpty){
      setAllErrorToFalse();
      isConfirmPassEmpty.value = true;
    }else if(confirmPassController.text.trim()  != newPassController.text.trim()){
      setAllErrorToFalse();
      isConfirmPassNotMatched.value = true;
    }else{
      setAllErrorToFalse();
      getChangePasswordResponse();
    }
  }

  ///*
  ///
  ///
  setAllErrorToFalse(){
    isCurrentPassEmpty.value = false;
    isNewPassEmpty.value = false;
    isConfirmPassEmpty.value = false;
    isConfirmPassNotMatched.value = false;
  }

  ///*
  ///
  ///
  void getChangePasswordResponse() async{
    SetChangedPasswordRequest requestModel = SetChangedPasswordRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.password = newPassController.text.trim();
    requestModel.confirmPassword = confirmPassController.text.trim();
    requestModel.oldPassword = currentPassController.text.trim();;

    SetChangedPasswordResponse? responseModel = await repository.hitSetChangedPasswordApi(requestModel);

    if(responseModel != null){
        log("getChangePasswordResponse : ${responseModel.message}");
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => CustomDialog(
            my_context: Get.context!,
            buttonText: 'Ok',
            title: "",
            description: responseModel.message!,
            img: successImage,
            okBtnFunction: clearAll,
          ),
        );

    }else{
      log("getSetPasswordResponse : NULL" );
    }

  }

  ///*
  ///
  ///
  clearAll() {
     currentPassController.clear();
     newPassController.clear();
     confirmPassController.clear();
  }
}