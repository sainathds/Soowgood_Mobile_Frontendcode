import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_delete_schedule_request.dart';
import 'package:soowgood/provider/model/request/provider_schedule_list_request.dart';
import 'package:soowgood/provider/model/response/provider_delete_schedule_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_list_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderOnlineScheduleController extends GetxController{

  var onlineScheduleList = <ProviderScheduleListResponse>[].obs;
  ProviderRepository repository = ProviderRepository();


  clearAll(){
    onlineScheduleList.clear();
  }

  ///*
  ///
  ///
  void getOnlineScheduleListResponse() async{
    ProviderScheduleListRequest requestModel = ProviderScheduleListRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.appointmentType = 'Online';

    List<ProviderScheduleListResponse>? responseModel = await repository.hitProviderScheduleListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      onlineScheduleList.clear();
      onlineScheduleList.value = responseModel;
    }else{
      onlineScheduleList.clear();
    }
  }

  ///*
  ///
  ///
  void getDeleteScheduleResponse(String scheduleId) async{
    ProviderDeleteScheduleRequest requestModel = ProviderDeleteScheduleRequest();
    requestModel.id = scheduleId;


    ProviderDeleteScheduleResponse? responseModel = await repository.hitDeleteScheduleApi(requestModel);

    if(responseModel != null){
      if(responseModel.success == '1'){
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) =>
              CustomDialog(
                  my_context: Get.context!,
                  img: successImage,
                  title: "",
                  description: responseModel.message!,
                  buttonText: 'Ok',
                  okBtnFunction: getOnlineScheduleListResponse
              ),
        );
      }
    }
  }
}