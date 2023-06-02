import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/provider/model/request/provider_patient_list_request.dart';
import 'package:soowgood/provider/model/response/provider_patient_list_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderPatientsController extends GetxController{

  ProviderRepository repository = ProviderRepository();
  TextEditingController searchController = TextEditingController();

  var patientList = <ProviderPatientListResponse>[].obs;
  var newPatientList = <ProviderPatientListResponse>[].obs;
  var isShow = false.obs;

  ///*
  ///
  /// get Bookings/getProviderPatients Api Response to get Patients list
  void getPatientListResponse() async{

    ProviderPatientListRequest requestModel = ProviderPatientListRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderPatientListResponse>? responseModel = await repository.hitProviderPatientsApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      patientList.clear();
      patientList.value = responseModel;
    }else {
      patientList.clear();
    }
  }

}