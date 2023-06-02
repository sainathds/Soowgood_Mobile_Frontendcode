import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_add_experience_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_experience_request.dart';
import 'package:soowgood/provider/model/response/provider_add_experience_response.dart';
import 'package:soowgood/provider/model/response/provider_edit_experience_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderAddEditExperienceController extends GetxController{

  ProviderRepository repository = ProviderRepository();
  TextEditingController hospitalController  = TextEditingController();
  TextEditingController designationController  = TextEditingController();
  TextEditingController fromDateController  = TextEditingController();
  TextEditingController toDateController  = TextEditingController();

  var isHospitalEmpty = false.obs;
  var isDesignationEmpty = false.obs;
  var isFromDateEmpty = false.obs;
  var isToDateEmpty = false.obs;

  String experienceId = '';
  String callFrom = '';

  ///*
  ///
  ///
  void setAllErrorToFalse(){
    isHospitalEmpty.value = false;
    isDesignationEmpty.value = false;
    isFromDateEmpty.value = false;
    isToDateEmpty.value = false;

  }

  ///*
  ///
  ///
  void clearAll(){
    experienceId = '';
    callFrom = '';
    hospitalController.clear();
    designationController.clear();
    fromDateController.clear();
    toDateController.clear();
  }



  ///
  ///
  ///
  void isDataValid(){

    if(hospitalController.text.trim().isEmpty){
      setAllErrorToFalse();
      isHospitalEmpty.value = true;

    }else if(designationController.text.trim().isEmpty){
      setAllErrorToFalse();
      isDesignationEmpty.value = true;

    }else if(fromDateController.text.trim().isEmpty){
      setAllErrorToFalse();
      isFromDateEmpty.value = true;


    }else if(toDateController.text.trim().isEmpty){
      setAllErrorToFalse();
      isToDateEmpty.value = true;


    }else {
      setAllErrorToFalse();
      if(callFrom == 'Add'){
        getAddExperienceResponse();
      }else{
        getUpdateExperienceResponse();
      }
    }
  }


  ///*
  ///
  /// use Experiences/UpdateExperience Api to Update experience Data
  void getUpdateExperienceResponse() async{

    ProviderEditExperienceRequest requestModel = ProviderEditExperienceRequest();
    requestModel.id = experienceId;
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.hospitalName = hospitalController.text.trim();
    requestModel.designation = designationController.text.trim();
    requestModel.fromDate = fromDateController.text.trim();
    requestModel.toDate = toDateController.text.trim();
    requestModel.isPresent = false;


      ProviderEditExperienceResponse? responseModel = await repository.hitUpdateExperienceApi(requestModel);

    if(responseModel != null){
      ProviderGlobal.isExperienceBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Experience Detail Updated Successfully',
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

  ///*
  ///
  /// use Experiences/Experience Api ton save ExperienceData
  void getAddExperienceResponse() async{

    ProviderAddExperienceRequest requestModel = ProviderAddExperienceRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.hospitalName = hospitalController.text.trim();
    requestModel.designation = designationController.text.trim();
    requestModel.fromDate = fromDateController.text.trim();
    requestModel.toDate = toDateController.text.trim();
    requestModel.isPresent = false;


    ProviderAddExperienceResponse? responseModel = await repository.hitAddExperienceApi(requestModel);

    if(responseModel != null){
      ProviderGlobal.isExperienceBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Experience Detail Added Successfully',
                buttonText: 'Ok',
                okBtnFunction: clearAll
            ),
      );
    }
  }

}