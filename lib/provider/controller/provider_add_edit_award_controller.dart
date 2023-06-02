import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_add_award_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_award_request.dart';
import 'package:soowgood/provider/model/response/provider_add_award_response.dart';
import 'package:soowgood/provider/model/response/provider_edit_award_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderAddEditAwardController extends GetxController{

  ProviderRepository repository = ProviderRepository();
  TextEditingController awardController  = TextEditingController();
  TextEditingController receiveYearController  = TextEditingController();

  var isAwardEmpty = false.obs;
  var isReceiveYearEmpty = false.obs;

  String callFrom = '';
  String awardId = '';


  ///*
  ///
  ///
  void setAllErrorToFalse(){
    isAwardEmpty.value = false;
    isReceiveYearEmpty.value = false;
  }


  ///*
  ///
  ///
  void clearAll(){
    callFrom = '';
    awardId = '';
    awardController.clear();
    receiveYearController.clear();
  }

  ///*
  ///
  /// check validations for required field
  void isDataValid(){
    if(awardController.text.trim().isEmpty){
      setAllErrorToFalse();
      isAwardEmpty.value = true;

    }else if(receiveYearController.text.trim().isEmpty){
      setAllErrorToFalse();
      isReceiveYearEmpty.value = true;

    }else {
      setAllErrorToFalse();
      if(callFrom == 'Add'){
        getAddAwardResponse();
      }else{
        getUpdateAwardResponse();
      }
    }
  }

  ///*
  ///
  /// use Awards/Awards Api to Add Award
  void getAddAwardResponse() async{
    ProviderAddAwardRequest requestModel = ProviderAddAwardRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.name = awardController.text.trim();
    requestModel.receivedYear = receiveYearController.text.trim();

    ProviderAddAwardResponse? responseModel = await repository.hitAddAwardApi(requestModel);

    if(responseModel != null){
      ProviderGlobal.isAwardBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Award Detail Added Successfully',
                buttonText: 'Ok',
                okBtnFunction: clearAll
            ),
      );
    }
  }


  ///*
  ///
  /// use Awards/UpdateAward Api to update Award
  void getUpdateAwardResponse() async{
    ProviderEditAwardRequest requestModel = ProviderEditAwardRequest();
    requestModel.id = awardId;
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.name = awardController.text.trim();
    requestModel.receivedYear = receiveYearController.text.trim();

    ProviderEditAwardResponse? responseModel = await repository.hitUpdateAwardApi(requestModel);

    if(responseModel != null){
      ProviderGlobal.isAwardBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Award Detail Updated Successfully',
                buttonText: 'Ok',
                okBtnFunction: okFunction
            ),
      );
    }
  }


  ///*
  ///
  ///
  okFunction() {
  }
}