import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/dropdown_list_request.dart';
import 'package:soowgood/provider/model/request/provider_add_specialization_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_specialization_request.dart';
import 'package:soowgood/provider/model/response/provider_add_specialization_response.dart';
import 'package:soowgood/provider/model/response/provider_category_type_response.dart';
import 'package:soowgood/provider/model/response/provider_edit_specialization_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderAddEditSpecializationController extends GetxController{

  late Function refreshPage;
  ProviderRepository repository = ProviderRepository();

  List<ProviderCategoryTypeResponse> categoryList = <ProviderCategoryTypeResponse>[];
  ProviderCategoryTypeResponse selectedCategory = ProviderCategoryTypeResponse();

  List<String> serviceList = <String>[];
  List<MultiSelectItem<String>> multiServiceList = <MultiSelectItem<String>>[];
  List<Object?> selectedServiceList = <Object?>[];


  List<String> specializationList = <String>[];
  List<MultiSelectItem<String>> multiSpecializationList = <MultiSelectItem<String>>[];
  List<Object?> selectedSpecializationList = <Object?>[];


  String callFrom = '';
  String specializationId = '';


  ///*
  ///
  /// check validations for required field
  void isDataValid(){
    if(selectedCategory.id!.isEmpty){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please Select Type Of Category",
          img: errorImage,
        ),
      );
    }else if(selectedServiceList.isEmpty){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please Select Services",
          img: errorImage,
        ),
      );
    }else if(selectedSpecializationList.isEmpty){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please Select Specialization",
          img: errorImage,
        ),
      );
    }else{
      if(callFrom == 'Add'){
        getAddSpecializationResponse();
      }else{
        getUpdateSpecializationResponse();
      }
    }
  }
  ///*
  ///
  /// get ProviderCategoryInfoes/GetProviderType Api Response
  /// to get CategoryList of data
  void getCategoryListResponse() async{

    DropdownListRequest requestModel = DropdownListRequest();
    requestModel.searchKeyword = '';

    List<ProviderCategoryTypeResponse>? responseModel = await repository.hitCategoryListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      categoryList = responseModel;
      refreshPage.call();
    }else{
      categoryList.clear();
      refreshPage.call();

    }
  }


  ///*
  ///
  /// get Specializations/ServiceList Api Response
  /// to get types of services
  void getServiceListResponse() async{

    DropdownListRequest requestModel = DropdownListRequest();
    requestModel.searchKeyword = '';

    List<String>? responseModel = await repository.hitServiceListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      serviceList = responseModel;
      multiServiceList = serviceList.map((e) => MultiSelectItem(e, e)).toList();
      refreshPage.call();
    }else{
      categoryList.clear();
      multiServiceList.clear();
      refreshPage.call();

    }
  }


  ///*
  ///
  /// get Specializations/SpecializationList Api Response
  /// to get types of specializations
  void getSpecializationListResponse() async{

    DropdownListRequest requestModel = DropdownListRequest();
    requestModel.searchKeyword = '';

    List<String>? responseModel = await repository.hitSpecializationTypeListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      specializationList = responseModel;
      multiSpecializationList = specializationList.map((e) => MultiSelectItem(e, e)).toList();
      refreshPage.call();
    }else{
      specializationList.clear();
      multiSpecializationList.clear();
      refreshPage.call();

    }
  }

  ///*
  ///
  ///
  void setDefaultValue() {
    selectedCategory.id = '';
    selectedCategory.medicalCareType = '';
    selectedCategory.provider = '';
    selectedCategory.providerType = '';
  }


  ///*
  ///
  ///
  void clearAll(){
    categoryList.clear();

    serviceList.clear();
    multiServiceList.clear();
    selectedServiceList.clear();

    specializationList.clear();
    multiSpecializationList.clear();
    selectedSpecializationList.clear();

  }

  ///*
  ///
  /// use Specializations/Information Api to save Provider-Specialization Data
  void getAddSpecializationResponse() async{
    ProviderAddSpecializationRequest requestModel = ProviderAddSpecializationRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.typeId = selectedCategory.id;
    requestModel.serviceName = selectedServiceList.join(',');
    requestModel.specializationName = selectedSpecializationList.join(',');

    ProviderAddSpecializationResponse? responseModel = await repository.hitAddSpecializationApi(requestModel);

    if(responseModel != null){
      if(responseModel.success == '1'){
        ProviderGlobal.isSkillBack = true;
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) =>
              CustomDialog(
                  my_context: Get.context!,
                  img: successImage,
                  title: "",
                  description: responseModel.message!,
                  buttonText: 'Ok',
                  okBtnFunction: clearAll
              ),
        );
      }else{
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) =>
              CustomDialog(
                  my_context: Get.context!,
                  img: errorImage,
                  title: "",
                  description: responseModel.message!,
                  buttonText: 'Ok',
                  okBtnFunction: clearAll
              ),
        );
      }

    }

  }


  ///*
  ///
  /// use Specializations/UpdateInformation Api to Update Provider-Specialization Data
  void getUpdateSpecializationResponse() async{
    ProviderEditSpecializationRequest requestModel = ProviderEditSpecializationRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.id = specializationId;
    requestModel.typeId = selectedCategory.id;
    requestModel.serviceName = selectedServiceList.join(',');
    requestModel.specializationName = selectedSpecializationList.join(',');

    ProviderEditSpecializationResponse? responseModel = await repository.hitUpdateSpecializationApi(requestModel);

    if(responseModel != null){
      ProviderGlobal.isSkillBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Skill Information Updated Successfully',
                buttonText: 'Ok',
                okBtnFunction: clearAll
            ),
      );
    }

  }


}