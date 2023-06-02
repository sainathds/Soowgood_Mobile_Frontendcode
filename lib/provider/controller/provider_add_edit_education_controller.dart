import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/provider/model/request/provider_add_education_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_education_request.dart';
import 'package:soowgood/provider/model/response/provider_add_education_response.dart';
import 'package:soowgood/provider/model/response/provider_edit_education_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

import '../../common/dialog/custom_dialog.dart';
import '../../common/resources/my_assets.dart';

class ProviderAddEditEducationController extends GetxController{


  ProviderRepository repository = ProviderRepository();
  TextEditingController degreeController  = TextEditingController();
  TextEditingController collegeController  = TextEditingController();
  TextEditingController passingYearController  = TextEditingController();

  var isDegreeEmpty = false.obs;
  var isCollegeEmpty = false.obs;
  var isPassingYearEmpty = false.obs;

  String educationId = '';
  String callFrom = '';

  ///*
  ///
  ///
  void setAllErrorToFalse(){
    isDegreeEmpty.value = false;
    isCollegeEmpty.value = false;
    isPassingYearEmpty.value = false;

  }

  ///*
  ///
  ///
  void clearAll(){
    educationId = '';
    callFrom = '';
    degreeController.clear();
    collegeController.clear();
    passingYearController.clear();
  }


  ///*
  ///
  /// check validations for required field
  void isDataValid(){

    if(degreeController.text.trim().isEmpty){
      setAllErrorToFalse();
      isDegreeEmpty.value = true;

    }else if(collegeController.text.trim().isEmpty){
      setAllErrorToFalse();
      isCollegeEmpty.value = true;

    }else if(passingYearController.text.trim().isEmpty){
      setAllErrorToFalse();
      isPassingYearEmpty.value = true;

    }else {
      setAllErrorToFalse();
      if(callFrom == 'Add'){
        getAddEducationResponse();
      }else{
        getUpdateEducationResponse();
      }
    }
  }

  ///*
  ///
  /// use Degrees/Degree Api to add Education detail
  void getAddEducationResponse() async{

    ProviderAddEducationRequest requestModel = ProviderAddEducationRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.name = degreeController.text.trim();
    requestModel.institution = collegeController.text.trim();
    requestModel.yearOfCompletion = passingYearController.text.trim();

    ProviderAddEducationResponse? responseModel = await repository.hitAddEducationApi(requestModel);

    if(responseModel != null){
      ProviderGlobal.isEducationBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Education Detail Added Successfully',
                buttonText: 'Ok',
                okBtnFunction: clearAll
            ),
      );
    }
  }



  ///*
  ///
  /// use Degrees/UpdateDegree Api to update Education Detail
  void getUpdateEducationResponse() async{

    ProviderEditEducationRequest requestModel = ProviderEditEducationRequest();
    requestModel.id = educationId;
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.name = degreeController.text.trim();
    requestModel.institution = collegeController.text.trim();
    requestModel.yearOfCompletion = passingYearController.text.trim();

    ProviderEditEducationResponse? responseModel = await repository.hitUpdateEducationApi(requestModel);

    if(responseModel != null){
      ProviderGlobal.isEducationBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Education Detail Updated Successfully',
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