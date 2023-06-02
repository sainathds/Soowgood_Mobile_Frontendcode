import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_award_list_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_document_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_education_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_experience_request.dart';
import 'package:soowgood/provider/model/request/provider_document_list_request.dart';
import 'package:soowgood/provider/model/request/provider_education_list_request.dart';
import 'package:soowgood/provider/model/request/provider_experience_list_request.dart';
import 'package:soowgood/provider/model/response/provider_award_list_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_document_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_education_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_experience_response.dart';
import 'package:soowgood/provider/model/response/provider_document_list_response.dart';
import 'package:soowgood/provider/model/response/provider_education_list_response.dart';
import 'package:soowgood/provider/model/response/provider_experience_list_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderEducationExperienceController extends GetxController{

  ProviderRepository providerRepository = ProviderRepository();
  List<ProviderEducationListResponse> educationList = <ProviderEducationListResponse>[];
  List<ProviderExperienceListResponse> experienceList = <ProviderExperienceListResponse>[];
  List<ProviderDocumentListResponse> documentList = <ProviderDocumentListResponse>[];


  late Function refreshPage;

  ///*
  ///
  ///
  void clearAll(){
    educationList.clear();
    experienceList.clear();
    documentList.clear();
  }

  ///*
  ///
  ///
  void getDocumentListResponse() async{

    ProviderDocumentListRequest requestModel = ProviderDocumentListRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderDocumentListResponse>? responseModel = await providerRepository.hitDocumentListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      documentList.clear();
      documentList = responseModel;
      refreshPage.call();
    }else{
      documentList.clear();
      refreshPage.call();
    }
  }


  ///*
  ///
  /// get Degrees/GetDegree Api response to get
  /// Education List
  void getEducationListResponse() async{

    ProviderEducationListRequest requestModel = ProviderEducationListRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderEducationListResponse>? responseModel = await providerRepository.hitEducationListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      educationList.clear();
      educationList = responseModel;
      refreshPage.call();
    }else{
      educationList.clear();
      refreshPage.call();

    }
  }


  ///*
  ///
  /// get Experiences/GetExperience Api Response to get
  /// Work experience list
  void getExperienceListResponse() async{

    ProviderExperienceListRequest requestModel = ProviderExperienceListRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderExperienceListResponse>? responseModel = await providerRepository.hitExperienceListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      experienceList = responseModel;
      refreshPage.call();
    }else{
      experienceList.clear();
      refreshPage.call();

    }
  }


  ///*
  ///
  /// use Degrees/DeleteDegree Api to
  /// Delete Education Data
  void getDeleteEducationResponse(String educationId) async{

    ProviderDeleteEducationRequest requestModel = ProviderDeleteEducationRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.id = educationId;


    ProviderDeleteEducationResponse? responseModel = await providerRepository.hitDeleteEducationApi(requestModel);

    if(responseModel != null){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Education Detail Deleted Successfully',
                buttonText: 'Ok',
                okBtnFunction: getEducationListResponse
            ),
      );
    }
  }


  ///*
  ///
  /// use Experiences/DeleteExperience Api to
  /// Delete Experience Data
  void getDeleteExperienceResponse(String experienceId) async{

    ProviderDeleteExperienceRequest requestModel = ProviderDeleteExperienceRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.id = experienceId;


    ProviderDeleteExperienceResponse? responseModel = await providerRepository.hitDeleteExperienceApi(requestModel);

    if(responseModel != null){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Experience Detail Deleted Successfully',
                buttonText: 'Ok',
                okBtnFunction: getExperienceListResponse
            ),
      );
    }
  }


  ///*
  ///
  /// use ProviderDocuments/deleteProviderDocumentDetails Api to
  /// Delete Document
  void getDeleteDocumentResponse(String documentId) async{

    ProviderDeleteDocumentRequest requestModel = ProviderDeleteDocumentRequest();
    // requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.id = documentId;


    ProviderDeleteDocumentResponse? responseModel = await providerRepository.hitDeleteDocumentApi(requestModel);

    if(responseModel != null){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Document Deleted Successfully',
                buttonText: 'Ok',
                okBtnFunction: getDocumentListResponse
            ),
      );
    }
  }

}