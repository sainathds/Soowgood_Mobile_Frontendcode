import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_providers_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_search_providers_request.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_providers_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_search_providers_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_specialization_response.dart';
import 'package:soowgood/benificiary/repository/beneficiary_repository.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/model/request/notification_list_request.dart';
import 'package:soowgood/common/model/response/notification_list_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class BeneficiaryHomeController extends GetxController{

  BeneficiaryRepository repository = BeneficiaryRepository();

  late Function refreshPage;

  var providerList = <BeneficiarySearchProvidersResponse>[].obs;
  var specializationList = <BeneficiarySpecializationResponse>[];

  TextEditingController searchEditController = TextEditingController();

  var notiCount = 0.obs;

  ///*
  ///
  /// get Searches/GlobalSearch api reponse
  /// to get Providers list
  void getProvidersResponse() async{

    /*BeneficiaryProvidersRequest requestModel = BeneficiaryProvidersRequest();
    requestModel.userRole = 'Provider';

    List<BeneficiaryProvidersResponse>? responseModel = await repository.hitProvidersApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      providerList.clear();
      providerList = responseModel;
      refreshPage.call();
    }else{
      providerList.clear();
      refreshPage.call();
    }*/

    BeneficiarySearchProvidersRequest requestModel = BeneficiarySearchProvidersRequest();
    requestModel.gender = "";
    requestModel.appointmentType = "";
    requestModel.availability = "";
    requestModel.providerSpeciality = "";
    requestModel.consultationFees = 0;
    requestModel.dayEndTime = "2003-12-31T12:00:00.000Z";
    requestModel.dayStartingTime = "2003-12-31T12:00:00.000Z";
    requestModel.location = "";
    requestModel.pageNumber = 0;
    requestModel.pageSize = 1000;
    requestModel.providerType = "";
    requestModel.searchKeyword = "";
    requestModel.serviceType = "";


    List<BeneficiarySearchProvidersResponse>? responseModel = await repository.hitSearchProvidersApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      providerList.clear();
      providerList.value = responseModel;
    }else{
      providerList.clear();
    }

  }



  ProviderRepository repository2 = ProviderRepository();
  var notificationList = <NotificationListResponse>[].obs;

  ///*
  ///
  /// get Dashboard/getNotification Api Response to show Unread notification count on HomeScreen
  void getNotificationListResponse() async{

    NotificationListRequest requestModel = NotificationListRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<NotificationListResponse>? responseModel = await repository2.hitGetNotificationListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      var unreadList = <NotificationListResponse>[];
      for (NotificationListResponse data in responseModel) {
        if (data.isread! == 0) {
          unreadList.add(data); //filter unread notification to show count
        }
      }
      notiCount.value = unreadList.length;
    }else{
      notiCount.value = 0;
    }
  }

}