import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_clinic_list_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_clinic_request.dart';
import 'package:soowgood/provider/model/response/provider_clinic_list_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_clinic_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderClinicsController extends GetxController{

  ProviderRepository repository = ProviderRepository();
  List<ProviderClinicListResponse> clinicList = <ProviderClinicListResponse>[];

  late Function refreshPage;

  void clearAll(){
    clinicList.clear();
  }


  ///*
  ///
  /// get Clinics/GetClinic Api Response to
  /// get Clinic List
  void getClinicListResponse() async{

    ProviderClinicListRequest requestModel = ProviderClinicListRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderClinicListResponse>? responseModel = await repository.hitClinicListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      clinicList.clear();
      clinicList = responseModel;
      refreshPage.call();
    }else{
      clinicList.clear();
      refreshPage.call();
    }
  }


  ///*
  ///
  ///
  void getDeleteClinicResponse(String clinicId) async{

    ProviderDeleteClinicRequest requestModel = ProviderDeleteClinicRequest();
    requestModel.id = clinicId;


      ProviderDeleteClinicResponse? responseModel = await repository.hitDeleteClinicApi(requestModel);

    if(responseModel != null){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Clinic Detail Deleted Successfully',
                buttonText: 'Ok',
                okBtnFunction: getClinicListResponse
            ),
      );
    }
  }

}