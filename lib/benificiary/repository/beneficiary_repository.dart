import 'dart:convert';
import 'dart:developer';

import 'package:soowgood/benificiary/model/request/add_edit_booking_doc_request.dart';
import 'package:soowgood/benificiary/model/request/appointment_count_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_add_edit_booking_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_advice_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_cancel_appointment_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_drug_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_medical_test_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_prescription_data_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_prescription_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_providers_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_search_providers_request.dart';
import 'package:soowgood/benificiary/model/request/booking_summary_request.dart';
import 'package:soowgood/benificiary/model/request/appointment_list_request.dart';
import 'package:soowgood/benificiary/model/request/cancel_appointment_by_patient_request.dart';
import 'package:soowgood/benificiary/model/request/check_appointment_cancel_request.dart';
import 'package:soowgood/benificiary/model/request/doctor_count_request.dart';
import 'package:soowgood/benificiary/model/request/dummy_payment_request.dart';
import 'package:soowgood/benificiary/model/request/payment_process_request.dart';
import 'package:soowgood/benificiary/model/request/remove_booking_request.dart';
import 'package:soowgood/benificiary/model/request/update_patient_data_request.dart';
import 'package:soowgood/benificiary/model/response/add_edit_booking_doc_response.dart';
import 'package:soowgood/benificiary/model/response/appointment_count_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_add_edit_booking_responset.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_advice_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_cancel_appointment_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_drug_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_medical_test_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_data_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_providers_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_search_providers_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_specialization_response.dart';
import 'package:soowgood/benificiary/model/response/booking_summary_response.dart';
import 'package:soowgood/benificiary/model/response/appointment_list_response.dart';
import 'package:soowgood/benificiary/model/response/cancel_appointment_by_patient_response.dart';
import 'package:soowgood/benificiary/model/response/check_appointment_cancel_response.dart';
import 'package:soowgood/benificiary/model/response/doctor_count_response.dart';
import 'package:soowgood/benificiary/model/response/dummy_payment_response.dart';
import 'package:soowgood/benificiary/model/response/payment_process_response.dart';
import 'package:soowgood/benificiary/model/response/remove_booking_response.dart';
import 'package:soowgood/benificiary/model/response/schedule_for_booking_response.dart';
import 'package:soowgood/benificiary/model/response/update_patient_data_response.dart';
import 'package:soowgood/common/model/response/twilio_access_token_response.dart';
import 'package:soowgood/common/model/response/verify_user_response.dart';
import 'package:soowgood/common/network/api_client.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/provider/model/request/dropdown_list_request.dart';
import 'package:soowgood/provider/model/request/next_schedule_request.dart';
import 'package:soowgood/provider/model/request/provider_basic_info_request.dart';
import 'package:soowgood/provider/model/request/provider_cancel_appointment_request.dart';
import 'package:soowgood/provider/model/request/provider_consultancy_type_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_score_request.dart';
import 'package:soowgood/provider/model/request/provider_schedule_type_request.dart';
import 'package:soowgood/provider/model/request/schedule_for_booking_request.dart';
import 'package:soowgood/provider/model/request/toady_bill_request.dart';
import 'package:soowgood/provider/model/request/today_appointment_request.dart';
import 'package:soowgood/provider/model/request/upload_profile_pic_request.dart';
import 'package:soowgood/provider/model/request/your_clinic_request.dart';
import 'package:soowgood/provider/model/response/provider_basic_info_response.dart';
import 'package:soowgood/provider/model/response/provider_cancel_appointment_response.dart';
import 'package:soowgood/provider/model/response/provider_consultancy_type_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_score_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_type_response.dart';

class BeneficiaryRepository{

  ApiClient apiClient = ApiClient() ;

  ///*
  ///
  ///
  Future<List<BeneficiaryProvidersResponse>?> hitProvidersApi(BeneficiaryProvidersRequest requestModel) async{
    List<BeneficiaryProvidersResponse>? responseModel;

    final results = await apiClient.requestBeneficiaryProvidersList(
        url: ApiConstant.beneficiaryProvidersApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<BeneficiarySpecializationResponse>?> hitSpecializationApi() async{
    List<BeneficiarySpecializationResponse>? responseModel;

    final results = await apiClient.requestBeneficiarySpecializationList(
        url: ApiConstant.beneficiarySpecializationApi,);

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<BeneficiarySearchProvidersResponse>?> hitSearchProvidersApi(BeneficiarySearchProvidersRequest requestModel) async{
    List<BeneficiarySearchProvidersResponse>? responseModel;

    final results = await apiClient.requestSearchProvidersList(
      url: ApiConstant.searchProvidersApi,
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
  Future<List<ProviderConsultancyTypeResponse>?> hitAppointmentTypeApi(ProviderConsultancyTypeRequest requestModel) async{
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
  Future<ScheduleForBookingResponse?> hitScheduleForBookingApi(ScheduleForBookingRequest requestModel) async{
    ScheduleForBookingResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.scheduleForBookingApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ScheduleForBookingResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryAddEditBookingResponse>?> hitAddEditBookingApi(BeneficiaryAddEditBookingRequest requestModel) async{
    List<BeneficiaryAddEditBookingResponse>? responseModel;

    final results = await apiClient.requestAddEditBooking(
        url: ApiConstant.addEditBookingApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<bool> hitUploadPrescriptionApi(AddEditBookingDocRequest requestModel) async{
    bool isDocumentUpload = false;
    final results = await apiClient.requestUploadPrescriptionFormData(
        url: ApiConstant.addEditBookingDocApi,
        requestModel: requestModel);

    if(results != null){
      log('UploadPrescription_Response : ${results.toString()}');
      isDocumentUpload = true;
    }
    return isDocumentUpload;
  }


  ///*
  ///
  ///
  Future<List<UpdatePatientDataResponse>?> hitUpdatePatientDataApi(UpdatePatientDataRequest requestModel) async{
    List<UpdatePatientDataResponse>? responseModel;

    final results = await apiClient.requestUpdatePatientData(
        url: ApiConstant.updatePatientDataApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<List<BookingSummaryResponse>?> hitGetBookingSummaryApi(BookingSummaryRequest requestModel) async{
    List<BookingSummaryResponse>? responseModel;

    final results = await apiClient.requestBookingSummaryApi(
        url: ApiConstant.getBookingSummaryApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<PaymentProcessResponse?> hitPaymentProcessApi(PaymentProcessRequest requestModel) async{
    PaymentProcessResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.getPaymentProcessApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = PaymentProcessResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///
  Future<int?> hitDoctorCountApi(DoctorsCountRequest requestModel) async{

    int? data;

    final results = await apiClient.requestIntData(
        url: ApiConstant.getDoctorCountApi,
        parameters: json.encode(requestModel));

    if(results != null){
      data = results;
    }
    return data;

  }


  ///*
  ///
  ///
  Future<int?> hitAppointmentCountApi(AppointmentCountRequest requestModel) async{
    int? data ;

    final results = await apiClient.requestIntData(
        url: ApiConstant.getAppointmentCountApi,
        parameters: json.encode(requestModel));

    if(results != null){
      data = results;
    }
    return data;

  }


  ///*
  ///
  ///
  Future<List<AppointmentListResponse>?> hitAppointmentListApi(AppointmentListRequest requestModel) async{
    List<AppointmentListResponse>? responseModel;

    final results = await apiClient.requestAppointmentListApi(
        url: ApiConstant.getAppointmentListApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

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
  Future<RemoveBookingResponse?> hitRemoveBookingApi(RemoveBookingRequest requestModel) async{
    RemoveBookingResponse? responseModel ;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.getRemoveBookingApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = RemoveBookingResponse.fromJson(results);
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
  Future<List<BeneficiaryCancelAppointmentResponse>?> hitCancelAppointmentApi(BeneficiaryCancelAppointmentRequest requestModel) async{
    List<BeneficiaryCancelAppointmentResponse>? responseModel;

    final results = await apiClient.requestBeneficiaryAppointmentCancel(
        url: ApiConstant.beneficiaryCancelAppointmentApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = results;
    }
    return responseModel;

  }


  ///*
  ///
  /// profile details
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
  /// profile details
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
  /// profile details
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
  /// profile details
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
  Future<TwilioAccessTokenResponse?> hitTwilioAccessTokenApi() async{
    TwilioAccessTokenResponse? responseModel ;

    final results = await apiClient.requestGet(
      url: ApiConstant.twilioAccessToken,);

    if(results != null){
      responseModel = TwilioAccessTokenResponse.fromJson(results);
    }
    return responseModel;

  }

  ///*
  ///
  ///
  Future<DummyPaymentResponse?> hitDummyPaymentApi(DummyPaymentRequest requestModel) async{
    DummyPaymentResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.dummyPaymentApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = DummyPaymentResponse.fromJson(results);
    }
    return responseModel;

  }


}