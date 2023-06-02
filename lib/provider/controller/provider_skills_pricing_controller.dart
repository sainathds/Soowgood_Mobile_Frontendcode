import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_delete_specialization_request.dart';
import 'package:soowgood/provider/model/request/provider_specialization_list_request.dart';
import 'package:soowgood/provider/model/response/provider_delete_specialization_response.dart';
import 'package:soowgood/provider/model/response/provider_specialization_list_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderSkillsPricingController extends GetxController{

  ProviderRepository repository = ProviderRepository();
  List<ProviderSpecializationListResponse> specializationList = <ProviderSpecializationListResponse>[];

  late Function refreshPage;

  ///*
  ///
  ///
  void clearAll(){
    specializationList.clear();
  }

  ///*
  ///
  /// get Specializations/GetSpecialization Api Response to get
  /// Specializations
  void getSpecializationListResponse() async{
    ProviderSpecializationListRequest requestModel = ProviderSpecializationListRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderSpecializationListResponse>? responseModel = await repository.hitGetSpecializationListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      specializationList.clear();
      specializationList = responseModel;
      refreshPage.call();
    }else{
      specializationList.clear();
      refreshPage.call();

    }
  }


  ///*
  ///
  /// use Specializations/deleteSpecialization Api to delete Specialization data
  void getDeleteSpecializationResponse(String specializationId) async{

    ProviderDeleteSpecializationRequest requestModel = ProviderDeleteSpecializationRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.id = specializationId;


    ProviderDeleteSpecializationResponse? responseModel = await repository.hitDeleteSpecializationApi(requestModel);

    if(responseModel != null){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Specialization Detail Deleted Successfully',
                buttonText: 'Ok',
                okBtnFunction: getSpecializationListResponse
            ),
      );
    }
  }



}