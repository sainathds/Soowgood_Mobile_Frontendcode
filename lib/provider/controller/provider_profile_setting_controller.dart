import 'dart:developer';

import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/provider/model/request/provider_profile_score_request.dart';
import 'package:soowgood/provider/model/response/provider_profile_score_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderProfileSettingController extends GetxController{

  ProviderRepository providerRepository = ProviderRepository();
  var profileScore = ''.obs;

  ///*
  ///
  /// get  Users/getUserProfileCompletionStatus Api Response to get
  /// profile completion score in %
  void getProfileScoreResponse() async{

    ProviderProfileScoreRequest requestModel = ProviderProfileScoreRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderProfileScoreResponse>? responseModel = await providerRepository.hitGetProfileScoreApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      profileScore.value = responseModel[0].profileScore!;

      log('ProfileScoreValue : ${profileScore.value}');
    }
  }


}