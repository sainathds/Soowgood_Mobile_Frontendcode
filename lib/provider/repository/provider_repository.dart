import 'dart:convert';
import 'dart:developer';

import 'package:soowgood/benificiary/model/request/beneficiary_advice_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_drug_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_medical_test_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_prescription_data_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_prescription_list_request.dart';
import 'package:soowgood/benificiary/model/request/check_appointment_cancel_request.dart';
import 'package:soowgood/benificiary/model/request/dummy_payment_request.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_advice_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_drug_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_medical_test_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_data_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_list_response.dart';
import 'package:soowgood/benificiary/model/response/check_appointment_cancel_response.dart';
import 'package:soowgood/benificiary/model/response/dummy_payment_response.dart';
import 'package:soowgood/common/model/request/delete_all_notification_request.dart';
import 'package:soowgood/common/model/request/notification_list_request.dart';
import 'package:soowgood/common/model/request/read_all_notification_request.dart';
import 'package:soowgood/common/model/response/notification_list_response.dart';
import 'package:soowgood/common/model/response/read_all_notification_response.dart';
import 'package:soowgood/common/model/response/twilio_access_token_response.dart';
import 'package:soowgood/provider/model/request/dropdown_list_request.dart';
import 'package:soowgood/provider/model/request/get_patient_document_history_request.dart';
import 'package:soowgood/provider/model/request/next_schedule_request.dart';
import 'package:soowgood/provider/model/request/provider_add_award_request.dart';
import 'package:soowgood/provider/model/request/provider_add_clinic_request.dart';
import 'package:soowgood/provider/model/request/provider_add_document_request.dart';
import 'package:soowgood/provider/model/request/provider_add_edit_prescription_request.dart';
import 'package:soowgood/provider/model/request/provider_add_edit_schedule_request.dart';
import 'package:soowgood/provider/model/request/provider_add_education_request.dart';
import 'package:soowgood/provider/model/request/provider_add_experience_request.dart';
import 'package:soowgood/provider/model/request/provider_add_specialization_request.dart';
import 'package:soowgood/provider/model/request/provider_admin_charges_request.dart';
import 'package:soowgood/provider/model/request/provider_appointment_list_request.dart';
import 'package:soowgood/provider/model/request/provider_bill_information_request.dart';
import 'package:soowgood/provider/model/request/provider_billing_history_request.dart';
import 'package:soowgood/provider/model/request/provider_billing_setup_request.dart';
import 'package:soowgood/provider/model/request/provider_cancel_appointment_request.dart';
import 'package:soowgood/provider/model/request/provider_dashboard_appointments_request.dart';
import 'package:soowgood/provider/model/request/provider_award_list_request.dart';
import 'package:soowgood/provider/model/request/provider_basic_info_request.dart';
import 'package:soowgood/provider/model/request/provider_clinic_list_request.dart';
import 'package:soowgood/provider/model/request/provider_consultancy_type_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_award_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_billing_setup_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_clinic_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_document_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_education_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_experience_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_schedule_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_specialization_request.dart';
import 'package:soowgood/provider/model/request/provider_document_list_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_award_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_clinic_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_document_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_education_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_experience_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_specialization_request.dart';
import 'package:soowgood/provider/model/request/provider_education_list_request.dart';
import 'package:soowgood/provider/model/request/provider_experience_list_request.dart';
import 'package:soowgood/provider/model/request/provider_make_payment_request.dart';
import 'package:soowgood/provider/model/request/provider_patient_list_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_completion_Count_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_score_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_status_request.dart';
import 'package:soowgood/provider/model/request/provider_schedule_details_request.dart';
import 'package:soowgood/provider/model/request/provider_schedule_duplication_request.dart';
import 'package:soowgood/provider/model/request/provider_schedule_list_request.dart';
import 'package:soowgood/provider/model/request/provider_schedule_type_request.dart';
import 'package:soowgood/provider/model/request/provider_specialization_list_request.dart';
import 'package:soowgood/provider/model/request/provider_visited_doctor_request.dart';
import 'package:soowgood/provider/model/request/toady_bill_request.dart';
import 'package:soowgood/provider/model/request/today_appointment_request.dart';
import 'package:soowgood/provider/model/request/your_clinic_request.dart';
import 'package:soowgood/provider/model/response/get_patient_document_history_response.dart';
import 'package:soowgood/provider/model/response/provider_add_award_response.dart';
import 'package:soowgood/provider/model/response/provider_add_edit_prescription_response.dart';
import 'package:soowgood/provider/model/response/provider_add_edit_schedule_response.dart';
import 'package:soowgood/provider/model/response/provider_add_education_response.dart';
import 'package:soowgood/provider/model/response/provider_add_experience_response.dart';
import 'package:soowgood/provider/model/response/provider_add_specialization_response.dart';
import 'package:soowgood/provider/model/response/provider_admin_charges_response.dart';
import 'package:soowgood/provider/model/response/provider_appointment_list_response.dart';
import 'package:soowgood/provider/model/response/provider_bill_information_response.dart';
import 'package:soowgood/provider/model/response/provider_billing_history_response.dart';
import 'package:soowgood/provider/model/response/provider_billing_setup_response.dart';
import 'package:soowgood/provider/model/response/provider_cancel_appointment_response.dart';
import 'package:soowgood/provider/model/response/provider_dashboard_appointments_response.dart';
import 'package:soowgood/provider/model/response/provider_award_list_response.dart';
import 'package:soowgood/provider/model/response/provider_basic_info_response.dart';
import 'package:soowgood/provider/model/response/provider_category_type_response.dart';
import 'package:soowgood/provider/model/response/provider_clinic_list_response.dart';
import 'package:soowgood/provider/model/response/provider_consultancy_type_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_award_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_billing_setup_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_clinic_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_document_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_education_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_experience_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_schedule_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_specialization_response.dart';
import 'package:soowgood/provider/model/response/provider_document_list_response.dart';
import 'package:soowgood/provider/model/response/provider_edit_award_response.dart';
import 'package:soowgood/provider/model/response/provider_edit_education_response.dart';
import 'package:soowgood/provider/model/response/provider_edit_experience_response.dart';
import 'package:soowgood/provider/model/response/provider_edit_specialization_response.dart';
import 'package:soowgood/provider/model/response/provider_education_list_response.dart';
import 'package:soowgood/provider/model/response/provider_experience_list_response.dart';
import 'package:soowgood/provider/model/response/provider_make_payment_response.dart';
import 'package:soowgood/provider/model/response/provider_patient_list_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_completion_count_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_score_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_status_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_details_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_duplication_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_list_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_type_response.dart';
import 'package:soowgood/provider/model/response/provider_specialization_list_response.dart';
import 'package:soowgood/provider/model/response/provider_visited_doctor_response.dart';
import 'package:soowgood/provider/model/response/upload_profile_pic_response.dart';

import '../../benificiary/model/response/ratings_list_response.dart';
import '../../common/model/response/verify_user_response.dart';
import '../../common/network/api_client.dart';
import '../../common/network/api_constant.dart';
import '../model/request/upload_profile_pic_request.dart';

class ProviderRepository{

  ApiClient apiClient = ApiClient() ;

  ///*
  ///
  /// profile details
  Future<List<ProviderProfileResponse>?> hitProfileDataApi(ProviderProfileRequest requestModel) async{
    List<ProviderProfileResponse>? responseModel;

    final results = await apiClient.requestProviderProfile(
        url: ApiConstant.profileDataApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }
  ///*
  ///
  /// rating details
 Future<List<dynamic>?> hitRatingDataApi(ProviderProfileRequest requestModel) async{
   List<dynamic>? responseModel;

    final results = await apiClient.requestGetRating(
        url: ApiConstant.ratingDataApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results.toList();
    }
    return responseModel;

  }
  ///*
  ///
  /// rating List details
 Future<List<getRatingDataListResponse>?> hitRatingListDataApi(ProviderProfileRequest requestModel) async{
   List<getRatingDataListResponse>? responseModel;

    final results = await apiClient.requestGetRatingList(
        url: ApiConstant.ratingListDataApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results.toList();
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<List<VerifyUserResponse>?> hitDeleteAccountApi(ProviderProfileRequest requestModel) async{
    List<VerifyUserResponse>? responseModel ;

    final results = await apiClient.requestDeleteAccount(
        url: ApiConstant.deleteAccountApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<bool> hitUploadProfilePicApi(UploadProfilePicRequest requestModel) async{
    // UploadProfilePicResponse? responseModel ;
    bool isUploadToServer = false;
    final results = await apiClient.requestUploadProfilePic(
        url: ApiConstant.uploadProfilePicApi,
        requestModel: requestModel);

    if(results != null){
      /*await results.stream.bytesToString().then((value) {
        responseModel = UploadProfilePicResponse.fromJson(json.decode(value));
      });*/
      isUploadToServer = true;
    }
    return isUploadToServer;
  }


  ///*
  ///
  ///
  Future<ProviderBasicInfoResponse?> hitUpdateBasicInfoApi(ProviderBasicInfoRequest requestModel) async{
    ProviderBasicInfoResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.updateUserProfileApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderBasicInfoResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<ProviderProfileStatusResponse?> hitGetProfileStatusApi(ProviderProfileStatusRequest requestModel) async{
    ProviderProfileStatusResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.providerProfileStatusApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderProfileStatusResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  /// profile Score
  Future<List<ProviderProfileScoreResponse>?> hitGetProfileScoreApi(ProviderProfileScoreRequest requestModel) async{
    List<ProviderProfileScoreResponse>? responseModel;

    final results = await apiClient.requestProviderProfileScore(
        url: ApiConstant.providerProfileScoreApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<ProviderEducationListResponse>?> hitEducationListApi(ProviderEducationListRequest requestModel) async{
    List<ProviderEducationListResponse>? responseModel;

    final results = await apiClient.requestProviderEducationList(
        url: ApiConstant.getDegreeApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<ProviderAddEducationResponse?> hitAddEducationApi(ProviderAddEducationRequest requestModel) async{
    ProviderAddEducationResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.addDegreeApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderAddEducationResponse.fromJson(results);
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<ProviderEditEducationResponse?> hitUpdateEducationApi(ProviderEditEducationRequest requestModel) async{
    ProviderEditEducationResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.updateDegreeApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderEditEducationResponse.fromJson(results);
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<ProviderDeleteEducationResponse?> hitDeleteEducationApi(ProviderDeleteEducationRequest requestModel) async{
    ProviderDeleteEducationResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.deleteDegreeApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderDeleteEducationResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<ProviderAddExperienceResponse?> hitAddExperienceApi(ProviderAddExperienceRequest requestModel) async{
    ProviderAddExperienceResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.addExperienceApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderAddExperienceResponse.fromJson(results);
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<ProviderEditExperienceResponse?> hitUpdateExperienceApi(ProviderEditExperienceRequest requestModel) async{
    ProviderEditExperienceResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.updateExperienceApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderEditExperienceResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<ProviderExperienceListResponse>?> hitExperienceListApi(ProviderExperienceListRequest requestModel) async{
    List<ProviderExperienceListResponse>? responseModel;

    final results = await apiClient.requestProviderExperienceList(
        url: ApiConstant.getExperienceApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<ProviderDeleteExperienceResponse?> hitDeleteExperienceApi(ProviderDeleteExperienceRequest requestModel) async{
    ProviderDeleteExperienceResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.deleteExperienceApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderDeleteExperienceResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<ProviderAddAwardResponse?> hitAddAwardApi(ProviderAddAwardRequest requestModel) async{
    ProviderAddAwardResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.addAwardApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderAddAwardResponse.fromJson(results);
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<ProviderEditAwardResponse?> hitUpdateAwardApi(ProviderEditAwardRequest requestModel) async{
    ProviderEditAwardResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.updateAwardApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderEditAwardResponse.fromJson(results);
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<ProviderDeleteAwardResponse?> hitDeleteAwardApi(ProviderDeleteAwardRequest requestModel) async{
    ProviderDeleteAwardResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.deleteAwardApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderDeleteAwardResponse.fromJson(results);
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<List<ProviderAwardListResponse>?> hitAwardListApi(ProviderAwardListRequest requestModel) async{
    List<ProviderAwardListResponse>? responseModel;

    final results = await apiClient.requestProviderAwardList(
        url: ApiConstant.getAwardApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }



  ///*
  ///
  ///
  Future<List<ProviderCategoryTypeResponse>?> hitCategoryListApi(DropdownListRequest requestModel) async{

    List<ProviderCategoryTypeResponse>? responseModel;

    final results = await apiClient.requestCategoryTypeList(
        url: ApiConstant.categoryListApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<List<String>?> hitServiceListApi(DropdownListRequest requestModel) async{
    List<String>? responseModel;

    final results = await apiClient.requestStringList(
        url: ApiConstant.serviceListApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<String>?> hitSpecializationTypeListApi(DropdownListRequest requestModel) async{
    List<String>? responseModel;

    final results = await apiClient.requestStringList(
        url: ApiConstant.specializationTypeListApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<ProviderAddSpecializationResponse?> hitAddSpecializationApi(ProviderAddSpecializationRequest requestModel) async{
    ProviderAddSpecializationResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.addSpecializationApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderAddSpecializationResponse.fromJson(results);
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<ProviderEditSpecializationResponse?> hitUpdateSpecializationApi(ProviderEditSpecializationRequest requestModel) async{
    ProviderEditSpecializationResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.updateSpecializationApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderEditSpecializationResponse.fromJson(results);
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<List<ProviderSpecializationListResponse>?> hitGetSpecializationListApi(ProviderSpecializationListRequest requestModel) async{
    List<ProviderSpecializationListResponse>? responseModel;

    final results = await apiClient.requestProviderSpecializationList(
        url: ApiConstant.getSpecializationApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<ProviderDeleteSpecializationResponse?> hitDeleteSpecializationApi(ProviderDeleteSpecializationRequest requestModel) async{
    ProviderDeleteSpecializationResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.deleteSpecializationApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderDeleteSpecializationResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<bool> hitUploadDocumentApi(ProviderAddDocumentRequest requestModel) async{
    bool isDocumentUpload = false;
    final results = await apiClient.requestUploadDocumentFormData(
        url: ApiConstant.uploadDocumentApi,
        requestModel: requestModel);

    if(results != null){
      isDocumentUpload = true;
    }
    return isDocumentUpload;
  }

  ///*
  ///
  ///
  Future<bool> hitUpdateDocumentApi(ProviderEditDocumentRequest requestModel) async{
    bool isDocumentUpdated = false;
    final results = await apiClient.requestUpdateDocumentFormData(
        url: ApiConstant.updateDocumentApi,
        requestModel: requestModel);

    if(results != null){
      isDocumentUpdated = true;
    }
    return isDocumentUpdated;
  }


  ///*
  ///
  /// profile Score
  Future<List<ProviderDocumentListResponse>?> hitDocumentListApi(ProviderDocumentListRequest requestModel) async{
    List<ProviderDocumentListResponse>? responseModel;

    final results = await apiClient.requestProviderDocumentList(
        url: ApiConstant.getDocumentApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<ProviderDeleteDocumentResponse?> hitDeleteDocumentApi(ProviderDeleteDocumentRequest requestModel) async{
    ProviderDeleteDocumentResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.deleteDocumentApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderDeleteDocumentResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<ProviderClinicListResponse>?> hitClinicListApi(ProviderClinicListRequest requestModel) async{
    List<ProviderClinicListResponse>? responseModel;

    final results = await apiClient.requestProviderClinicList(
        url: ApiConstant.getClinicsApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<ProviderScheduleTypeResponse>?> hitScheduleTypeApi(ProviderScheduleTypeRequest requestModel) async{
    List<ProviderScheduleTypeResponse>? responseModel;

    final results = await apiClient.requestScheduleTypeList(
        url: ApiConstant.getScheduleTypeApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<List<ProviderConsultancyTypeResponse>?> hitConsultancyTypeApi(ProviderConsultancyTypeRequest requestModel) async{
    List<ProviderConsultancyTypeResponse>? responseModel;

    final results = await apiClient.requestConsultancyTypeList(
        url: ApiConstant.getConsultancyTypeApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<bool> hitAddClinicApi(ProviderAddClinicRequest requestModel) async{
    bool isAdded = false;
    final results = await apiClient.requestAddClinicFormData(
        url: ApiConstant.addClinicApi,
        requestModel: requestModel);

    if(results != null){
      isAdded = true;
    }
    return isAdded;
  }


  ///*
  ///
  ///
  Future<bool> hitEditClinicApi(ProviderEditClinicRequest requestModel) async{
    bool isAdded = false;
    final results = await apiClient.requestEditClinicFormData(
        url: ApiConstant.editClinicApi,
        requestModel: requestModel);

    if(results != null){
      isAdded = true;
    }
    return isAdded;
  }


  ///*
  ///
  ///
  Future<ProviderDeleteClinicResponse?> hitDeleteClinicApi(ProviderDeleteClinicRequest requestModel) async{
    ProviderDeleteClinicResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.deleteClinicApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderDeleteClinicResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<ProviderAdminChargesResponse?> hitAdminChargesApi(ProviderAdminChargesRequest requestModel) async{
    ProviderAdminChargesResponse? responseModel;

    final results = await apiClient.requestPost(
        url: ApiConstant.getAdminChargesApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderAdminChargesResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<ProviderScheduleDuplicationResponse?> hitCheckScheduleApi(ProviderScheduleDuplicationRequest requestModel) async{
    ProviderScheduleDuplicationResponse? responseModel;

    final results = await apiClient.requestPost(
        url: ApiConstant.checkScheduleDuplicationApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderScheduleDuplicationResponse.fromJson(results);
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<ProviderAddEditScheduleResponse?> hitAddEditScheduleApi(ProviderAddEditScheduleRequest requestModel) async{
    ProviderAddEditScheduleResponse? responseModel;

    final results = await apiClient.requestPost(
        url: ApiConstant.addEditScheduleApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderAddEditScheduleResponse.fromJson(results);
    }
    return responseModel;

  }




  ///*
  ///
  ///
    Future<List<ProviderScheduleListResponse>?> hitProviderScheduleListApi(ProviderScheduleListRequest requestModel) async{
    List<ProviderScheduleListResponse>? responseModel;

    final results = await apiClient.requestProviderScheduleList(
        url: ApiConstant.getScheduleListApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<ProviderDeleteScheduleResponse?> hitDeleteScheduleApi(ProviderDeleteScheduleRequest requestModel) async{
    ProviderDeleteScheduleResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.deleteScheduleApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderDeleteScheduleResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<ProviderScheduleDetailResponse>?> hitScheduleDetailApi(ProviderScheduleDetailRequest requestModel) async{
    List<ProviderScheduleDetailResponse>? responseModel;

    final results = await apiClient.requestScheduleDetail(
        url: ApiConstant.scheduleDetailApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<int?> hitTodayAppointmentCountApi(TodayAppointmentRequest requestModel) async{

    int? data;

    final results = await apiClient.requestIntData(
        url: ApiConstant.getTodayAppointmentCountApi,
        parameters: json.encode(requestModel));

    if(results != null){
      data = results;
    }
    return data;

  }

  ///*
  ///
  ///
  Future<int?> hitNextAppointmentCountApi(NextScheduleRequest requestModel) async{

    int? data;

    final results = await apiClient.requestIntData(
        url: ApiConstant.getNextScheduleCountApi,
        parameters: json.encode(requestModel));

    if(results != null){
      data = results;
    }
    return data;

  }

  ///*
  ///
  ///
  Future<String?> hitAppointmentBillAmountApi(TodayBillRequest requestModel) async{

    String? data;

    final results = await apiClient.requestStringData(
        url: ApiConstant.getTodayBillAmountApi,
        parameters: json.encode(requestModel));

    if(results != null){
      data = results;
    }
    return data;

  }

  ///*
  ///
  ///
  Future<int?> hitYourClinicApi(YourClinicRequest requestModel) async{

    int? data;

    final results = await apiClient.requestIntData(
        url: ApiConstant.getYourOfClinicCountApi,
        parameters: json.encode(requestModel));

    if(results != null){
      data = results;
    }
    return data;

  }


  ///*
  ///
  ///
  Future<List<ProviderDashboardAppointmentsResponse>?> hitDashboardAppointmentsApi(ProviderDashboardAppointmentsRequest requestModel) async{
    List<ProviderDashboardAppointmentsResponse>? responseModel;

    final results = await apiClient.requestProviderAppointments(
        url: ApiConstant.getProviderDashboardAppointmentsApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<ProviderAppointmentListResponse>?> hitAppointmentListApi(ProviderAppointmentListRequest requestModel) async{
    List<ProviderAppointmentListResponse>? responseModel;

    final results = await apiClient.requestAppointmentList(
        url: ApiConstant.getProviderAppointmentListApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<ProviderProfileCompletionCountResponse>?> hitProfileCompletionCountApi(ProviderProfileCompletionCountRequest requestModel) async{
    List<ProviderProfileCompletionCountResponse>? responseModel;

    final results = await apiClient.requestProfileCompletionCount(
        url: ApiConstant.getProfileCompletionCountApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<CheckAppointmentCancelResponse>?> hitCheckAppointmentCancelApi(CheckAppointmentCancelRequest requestModel) async{
    List<CheckAppointmentCancelResponse>? responseModel;

    final results = await apiClient.requestCheckAppointmentCancel(
        url: ApiConstant.checkAppointmentCancelApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<ProviderCancelAppointmentResponse>?> hitCancelAppointmentApi(ProviderCancelAppointmentRequest requestModel) async{
    List<ProviderCancelAppointmentResponse>? responseModel;

    final results = await apiClient.requestProviderAppointmentCancel(
        url: ApiConstant.providerCancelAppointmentApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<ProviderVisitedDoctorListResponse>?> hitVisitedDoctorApi(ProviderVisitedDoctorListRequest requestModel) async{
    List<ProviderVisitedDoctorListResponse>? responseModel;

    final results = await apiClient.requestProviderVisitedDoctor(
        url: ApiConstant.providerVisitedDoctorApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<GetPatientDocumentHistoryResponse>?> hitGetDocumentHistory(GetPatientDocumentHistoryRequest requestModel) async{
    List<GetPatientDocumentHistoryResponse>? responseModel;

    final results = await apiClient.requestPatientDocumentHistory(
        url: ApiConstant.getPatientDocumentHistoryApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<List<BeneficiaryPrescriptionDataResponse>?> hitPrescriptionDataApi(BeneficiaryPrescriptionDataRequest requestModel) async{
    List<BeneficiaryPrescriptionDataResponse>? responseModel;

    final results = await apiClient.requestBeneficiaryPrescriptionData(
        url: ApiConstant.patientPrescriptionDataApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }

  ///*
  ///
  ///
  /// 
  Future<bool> hitAddEditPrescriptionApi(ProviderAddEditPrescriptionRequest requestModel, String callfrom) async{
    bool isUploadToServer = false;

    final results = await apiClient.requestAddEditPrescriptionFormData(
        url: ApiConstant.addEditPrescriptionApi,
        callfrom: callfrom,
        requestModel: requestModel);

    if(results != null){
      isUploadToServer = true;
    }
    return isUploadToServer;

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryPrescriptionListResponse>?> hitPrescriptionListApi(BeneficiaryPrescriptionListRequest requestModel) async{
    List<BeneficiaryPrescriptionListResponse>? responseModel;

    final results = await apiClient.requestBeneficiaryPrescriptionList(
        url: ApiConstant.getPrescriptionListApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryDrugListResponse>?> hitDrugListApi(BeneficiaryDrugListRequest requestModel) async{
    List<BeneficiaryDrugListResponse>? responseModel;

    final results = await apiClient.requestBeneficiaryDrugList(
        url: ApiConstant.beneficiaryGetDrugApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryMedicalTestResponse>?> hitMedicalTestListApi(BeneficiaryMedicalTestRequest requestModel) async{
    List<BeneficiaryMedicalTestResponse>? responseModel;

    final results = await apiClient.requestBeneficiaryMedicalList(
        url: ApiConstant.beneficiaryGetMedicalTestApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryAdviceListResponse>?> hitAdviceListApi(BeneficiaryAdviceListRequest requestModel) async{
    List<BeneficiaryAdviceListResponse>? responseModel;

    final results = await apiClient.requestBeneficiaryAdviceList(
        url: ApiConstant.beneficiaryGetAdviceApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<ProviderBillingSetupResponse?> hitBillingSetupApi(ProviderBillingSetupRequest requestModel) async{
    ProviderBillingSetupResponse? response;

    final results = await apiClient.requestPost(
        url: ApiConstant.billingSetupApi,
        parameters: json.encode(requestModel));

    if(results != null){
      response = ProviderBillingSetupResponse.fromJson(results);
    }
    return response;

  }

  ///*
  ///
  ///
  Future<List<ProviderBillInformationResponse>?> hitGetBillInfoApi(ProviderBillInformationRequest requestModel) async{
    List<ProviderBillInformationResponse>? responseModel;

    final results = await apiClient.requestProviderBillInfo(
        url: ApiConstant.getBillingSetupInfoApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<ProviderDeleteBillingSetupResponse?> hitDeleteBillingSetupApi(ProviderDeleteBillingSetupRequest requestModel) async{
    ProviderDeleteBillingSetupResponse? response;

    final results = await apiClient.requestPost(
        url: ApiConstant.deleteBillingSetupApi,
        parameters: json.encode(requestModel));

    if(results != null){
      response = ProviderDeleteBillingSetupResponse.fromJson(results);
    }
    return response;

  }


  ///*
  ///
  ///
  Future<List<ProviderBillingHistoryResponse>?> hitBillingHistoryApi(ProviderBillingHistoryRequest requestModel) async{
    List<ProviderBillingHistoryResponse>? responseModel;

    final results = await apiClient.requestProviderBillingHistory(
        url: ApiConstant.billingHistoryApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<List<ProviderPatientListResponse>?> hitProviderPatientsApi(ProviderPatientListRequest requestModel) async{
    List<ProviderPatientListResponse>? responseModel;

    final results = await apiClient.requestPatientList(
        url: ApiConstant.patientListApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }

  ///*
  ///
  /// call Dashboard/getNotification Api to get Notification list for both beneficiary and provider
  Future<List<NotificationListResponse>?> hitGetNotificationListApi(NotificationListRequest requestModel) async{
    List<NotificationListResponse>? responseModel;

    final results = await apiClient.requestNotificationList(
        url: ApiConstant.notificationListApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<ReadAllNotificationResponse>?> hitReadAllNotification(ReadAllNotificationRequest requestModel) async{
    List<ReadAllNotificationResponse>? responseModel;

    final results = await apiClient.requestReadAllNotification(
        url: ApiConstant.readAllNotificationsApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }



  ///*
  ///
  ///
  Future<bool?> hitDeleteAllNotificationApi(DeleteAllNotificationRequest requestModel) async{

    bool? data;

    final results = await apiClient.requestDeleteNotificationData(
        url: ApiConstant.deleteAllNotificationsApi,
        parameters: json.encode(requestModel));

    if(results != null){
      data = results;
    }
    return data;

  }



  ///*
  ///
  ///
  Future<ProviderMakePaymentResponse?> hitMakePaymentRequestApi(ProviderMakePaymentRequest requestModel) async{
    ProviderMakePaymentResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.makePaymentRequestApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ProviderMakePaymentResponse.fromJson(results);
    }
    return responseModel;

  }



  ///*
  ///
  ///
  Future<TwilioAccessTokenResponse?> hitTwilioAccessTokenApi() async{
    TwilioAccessTokenResponse? responseModel ;

    final results = await apiClient.requestGet(
        url: ApiConstant.twilioAccessToken,);

    if(results != null){
      responseModel = TwilioAccessTokenResponse.fromJson(results);
    }
    return responseModel;

  }





}

