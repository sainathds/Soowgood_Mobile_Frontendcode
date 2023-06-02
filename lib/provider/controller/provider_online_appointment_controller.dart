import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soowgood/benificiary/model/request/check_appointment_cancel_request.dart';
import 'package:soowgood/benificiary/model/response/check_appointment_cancel_response.dart';
import 'package:soowgood/common/conference/conference_page.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_appointment_list_request.dart';
import 'package:soowgood/provider/model/request/provider_cancel_appointment_request.dart';
import 'package:soowgood/provider/model/request/provider_clinic_list_request.dart';
import 'package:soowgood/provider/model/response/provider_appointment_list_response.dart';
import 'package:soowgood/provider/model/response/provider_cancel_appointment_response.dart';
import 'package:soowgood/provider/model/response/provider_clinic_list_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderOnlineAppointmentController extends GetxController{
  ProviderRepository repository = ProviderRepository();

  TextEditingController searchController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  var isShow = false.obs;

  var clinicList = <ProviderClinicListResponse>[].obs;
  var selectedClinic = ProviderClinicListResponse().obs;
  var onlineAppointmentList = <ProviderAppointmentListResponse>[].obs;
  var newOnlineAppointmentList = <ProviderAppointmentListResponse>[].obs;

  var appointmentTypeId = ''.obs;

  ///*
  ///
  /// get OnlineAppointment list data
  void getAppointmentListResponse() async{

    ProviderAppointmentListRequest requestModel = ProviderAppointmentListRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.appointmentTypeId = appointmentTypeId.value;
    requestModel.clinicId = selectedClinic.value.id;
    requestModel.schedule = getServerDate(dateController.text.trim());

    List<ProviderAppointmentListResponse>? responseModel = await repository.hitAppointmentListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      onlineAppointmentList.clear();
      onlineAppointmentList.value = responseModel;
    }else{
      onlineAppointmentList.clear();
    }
  }

  ///*
  ///
  /// get Clinics/GetClinic api response to get
  /// clinic list
  void getClinicListResponse(String appointmentTypeId) async{

    ProviderClinicListRequest requestModel = ProviderClinicListRequest();
    requestModel.userId =   MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderClinicListResponse>? responseModel = await repository.hitClinicListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      clinicList.clear();
      clinicList.value = responseModel;
      ProviderClinicListResponse defaultData = ProviderClinicListResponse();
      defaultData.id = '0';
      defaultData.name = 'All';
      clinicList.insert(0, defaultData);
      selectedClinic.value = clinicList[0];
      getAppointmentListResponse();

    }else{
      clinicList.clear();
    }
  }



  ///*
  ///
  ///
  String? getServerDate(String? appointmentDate) {

    DateFormat fromDateFormatter = DateFormat('MM/dd/yyyy');
    DateFormat toDateFormatter = DateFormat('yyyy-MM-dd');

    String newDate = '';

    List<String> validadeSplit = appointmentDate!.split('/');

    if(validadeSplit.length > 1)
    {
      int day = int.parse(validadeSplit[1].toString());
      String month = validadeSplit[0];
      int year = int.parse(validadeSplit[2].toString());

      String date = '$month/$day/$year';

      DateTime appointmentDateTime = fromDateFormatter.parse(date);
      newDate = toDateFormatter.format(appointmentDateTime);

    }

    return newDate;
  }



  ///*
  ///
  ///
  void getCheckCancelAppointmentResponse(int index) async{
    CheckAppointmentCancelRequest requestModel = CheckAppointmentCancelRequest();
    requestModel.id = onlineAppointmentList[index].id;


    List<CheckAppointmentCancelResponse>? responseModel = await repository.hitCheckAppointmentCancelApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      if(responseModel[0].success == '1'){
        getCancelAppointmentResponse(index);
      }else{
        getAppointmentListResponse();
        /*showDialog(
          context: Get.context!,
          builder: (BuildContext context1) =>
              CustomDialog(
                  my_context: Get.context!,
                  img: successImage,
                  title: "",
                  description: responseModel[0].message!,
                  buttonText: 'Ok',
                  okBtnFunction: getAppointmentListResponse
              ),
        );*/
      }
    }
  }



  ///*
  ///
  ///
  void getCancelAppointmentResponse(int index) async{
    ProviderCancelAppointmentRequest requestModel = ProviderCancelAppointmentRequest();
    requestModel.appointmentSettingId = onlineAppointmentList[index].appointmentSettingId;
    requestModel.beneficiaryComment = onlineAppointmentList[index].beneficiaryComment;
    requestModel.id = onlineAppointmentList[index].id;
    requestModel.isBookingCancelledByReceiver = true;
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.serviceReceiverId =   onlineAppointmentList[index].serviceReceiverId;


    List<ProviderCancelAppointmentResponse>? responseModel = await repository.hitCancelAppointmentApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      getAppointmentListResponse();
      /*showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Appointment Cancelled Successfully',
                buttonText: 'Ok',
                okBtnFunction: getAppointmentListResponse
            ),
      );*/
    }
  }


  ///*
  ///
  /// call https://meet.soowgood.com/api/twilio/token api to get TwillioAccessToken against particular bookingId
  /// for Video Call
  void getTwilioAccessTokenResponse(String bookingId) async{
    var response = await repository.hitTwilioAccessTokenApi();

    if(response != null && response.token != ''){
      Get.to(() => ConferencePage(accessToken: response.token!, bookingId: bookingId,));
    }
  }


}