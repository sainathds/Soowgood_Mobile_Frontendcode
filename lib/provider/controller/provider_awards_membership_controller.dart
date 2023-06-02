import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_award_list_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_award_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_experience_request.dart';
import 'package:soowgood/provider/model/response/provider_award_list_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_award_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_experience_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

import '../../common/dialog/custom_dialog.dart';

class ProviderAwardMembershipController extends GetxController{

  ProviderRepository providerRepository = ProviderRepository();
  List<ProviderAwardListResponse> awardList = <ProviderAwardListResponse>[];

  late Function refreshPage;

  ///*
  ///
  ///
  void clearAll(){
    awardList.clear();
  }

  ///*
  ///
  /// get Awards/GetAward api to
  /// get award list
  void getAwardListResponse() async{

    ProviderAwardListRequest requestModel = ProviderAwardListRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderAwardListResponse>? responseModel = await providerRepository.hitAwardListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      awardList = responseModel;
      refreshPage.call();
    }else{
      awardList.clear();
      refreshPage.call();

    }
  }

  ///*
  ///
  /// use Awards/DeleteAward Api to delete awardData
  void getDeleteAwardResponse(String awardId) async{

    ProviderDeleteAwardRequest requestModel = ProviderDeleteAwardRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.id = awardId;


    ProviderDeleteAwardResponse? responseModel = await providerRepository.hitDeleteAwardApi(requestModel);

    if(responseModel != null){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Award Deleted Successfully',
                buttonText: 'Ok',
                okBtnFunction: getAwardListResponse
            ),
      );
    }
  }



}