import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/model/request/appointment_count_request.dart';
import 'package:soowgood/benificiary/model/request/appointment_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_cancel_appointment_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_search_providers_request.dart';
import 'package:soowgood/benificiary/model/request/check_appointment_cancel_request.dart';
import 'package:soowgood/benificiary/model/request/doctor_count_request.dart';
import 'package:soowgood/benificiary/model/response/appointment_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_cancel_appointment_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_search_providers_response.dart';
import 'package:soowgood/benificiary/model/response/check_appointment_cancel_response.dart';
import 'package:soowgood/benificiary/repository/beneficiary_repository.dart';
import 'package:soowgood/common/conference/conference_page.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_profile_request.dart';
import 'package:soowgood/provider/model/response/provider_profile_response.dart';

import '../../common/dialog/custom_dialog.dart';

class BeneficiaryDashboardController extends GetxController{

  BeneficiaryRepository repository = BeneficiaryRepository();

  var doctorCount = ''.obs;
  var appointmentCount = ''.obs;
  var appointmentList = <AppointmentListResponse>[].obs;

  var userName = ''.obs;


  ///*
  ///
  /// get Dashboard/VisitedDoctor api response
  /// to get visited doctors count use to show on dashboard screen
  void getDoctorCount() async{

    DoctorsCountRequest requestModel = DoctorsCountRequest();
    requestModel.serviceReceiverId = MySharedPreference.getString(KeyConstants.keyUserId);

    var responseModel = await repository.hitDoctorCountApi(requestModel);

    if(responseModel != null){
      doctorCount.value = responseModel.toString();
      log('DOCTOR_COUNT ${doctorCount.value}');
    }
  }


  ///*
  ///
  /// get Dashboard/AllAppointment Api Response
  /// use to get count of appointments
  void getAppointmentCount() async{

    AppointmentCountRequest requestModel = AppointmentCountRequest();
    requestModel.serviceReceiverId = MySharedPreference.getString(KeyConstants.keyUserId);

    var responseModel = await repository.hitAppointmentCountApi(requestModel);

    if(responseModel != null){
      appointmentCount.value = responseModel.toString();
      log('Appointment_COUNT ${appointmentCount.value}');
    }
  }


  ///*
  ///
  /// get Bookings/patientAppointmentHistory Api Response
  /// use to get Recent Appointments
  void getAppointmentListResponse() async{
    AppointmentListRequest requestModel = AppointmentListRequest();
    requestModel.serviceReceiverId =   MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.bookingtype = 'Recent';
    requestModel.appointmentType = '';
    requestModel.availability = '';
    requestModel.consultationFees = 0;
    requestModel.gender = '';
    requestModel.providerSpeciality = '';
    requestModel.serviceType = '';
    requestModel.pageSize = 10000;
    requestModel.pageNumber = 0;

    List<AppointmentListResponse>? responseModel = await repository.hitAppointmentListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      appointmentList.value = responseModel.reversed.toList();
    }else{
      appointmentList.clear();
    }

  }

  ///*
  ///
  /// use Bookings/checkAppointmentCancellation api
  /// to cancel appointment
  void getCheckCancelAppointmentResponse(int index) async{
    CheckAppointmentCancelRequest requestModel = CheckAppointmentCancelRequest();
    requestModel.id = appointmentList[index].id;


    List<CheckAppointmentCancelResponse>? responseModel = await repository.hitCheckAppointmentCancelApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      if(responseModel[0].success == '1'){
        getCancelAppointmentResponse(index);
      }else{
        showDialog(
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
        );
      }
    }
  }



  ///*
  ///
  ///
  void getCancelAppointmentResponse(int index) async{
    BeneficiaryCancelAppointmentRequest requestModel = BeneficiaryCancelAppointmentRequest();
    requestModel.appointmentSettingId = appointmentList[index].appointmentSettingId;
    requestModel.beneficiaryComment = appointmentList[index].beneficiaryComment;
    requestModel.id = appointmentList[index].id;
    requestModel.isBookingCancelledByReceiver = true;
    requestModel.serviceProviderId = appointmentList[index].serviceProviderId;
    requestModel.serviceReceiverId =   MySharedPreference.getString(KeyConstants.keyUserId);


    List<BeneficiaryCancelAppointmentResponse>? responseModel = await repository.hitCancelAppointmentApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      showDialog(
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
      );
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


  ///*
  ///
  /// get Users/getuserdatabyid Api TResponse
  /// to get name of user to show on dashboard screen
  void getProfileResponse() async{

    ProviderProfileRequest requestModel = ProviderProfileRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderProfileResponse>? responseModel = await repository.hitProfileDataApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      userName.value = responseModel[0].fullname!;
    }
  }


}