import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/model/request/check_appointment_cancel_request.dart';
import 'package:soowgood/benificiary/model/response/check_appointment_cancel_response.dart';
import 'package:soowgood/common/conference/conference_page.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/model/request/notification_list_request.dart';
import 'package:soowgood/common/model/response/notification_list_response.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/next_schedule_request.dart';
import 'package:soowgood/provider/model/request/provider_cancel_appointment_request.dart';
import 'package:soowgood/provider/model/request/provider_dashboard_appointments_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_completion_Count_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_status_request.dart';
import 'package:soowgood/provider/model/request/toady_bill_request.dart';
import 'package:soowgood/provider/model/request/today_appointment_request.dart';
import 'package:soowgood/provider/model/request/your_clinic_request.dart';
import 'package:soowgood/provider/model/response/provider_cancel_appointment_response.dart';
import 'package:soowgood/provider/model/response/provider_dashboard_appointments_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_completion_count_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_status_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderHomeController extends GetxController{

  ProviderRepository repository = ProviderRepository();
  var isProfileApproved = false.obs;

  var todayAppointmentCount = ''.obs;
  var nextScheduleCount = ''.obs;
  var yourClinicsCount = ''.obs;
  var todayBillCount = ''.obs;
  var totalPointsCount = '12'.obs;
  var profileCompleteCount = ''.obs;

  var recentAppointmentList = <ProviderDashboardAppointmentsResponse>[].obs;
  var upcomingAppointmentList = <ProviderDashboardAppointmentsResponse>[].obs;

  var notificationCount = 0.obs;

  var userName = ''.obs;

  ///*
  ///
  ///  get Users/getuserdatabyid Api Response to get name of user to show on home screen
  void getProfileResponse() async{

    ProviderProfileRequest requestModel = ProviderProfileRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderProfileResponse>? responseModel = await repository.hitProfileDataApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      userName.value = responseModel[0].fullname!;
    }
  }


  ///*
  ///
  ///  get Users/GetUser api response to know is provider profile is approved by admin or not
  void getProfileApprovedResponse() async{
    ProviderProfileStatusRequest requestModel = ProviderProfileStatusRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    ProviderProfileStatusResponse? responseModel = await repository.hitGetProfileStatusApi(requestModel);

    if(responseModel != null){
      log('getProfileApprovedResponse ${json.encode(responseModel)}');
      isProfileApproved.value = responseModel.isConfirmedByAdmin!;

    }
  }

  ///*
  ///
  /// get Dashboard/TodayTotalAppointment Api Response to get TodayAppointment Count
  void getTodayAppointmentCount() async{

    TodayAppointmentRequest requestModel = TodayAppointmentRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);

    var responseModel = await repository.hitTodayAppointmentCountApi(requestModel);

    if(responseModel != null){
      todayAppointmentCount.value = responseModel.toString();
      log('COUNT todayAppointment ${todayAppointmentCount.value}');
      getNextScheduleCount();
    }
  }

  ///*
  ///
  /// get Dashboard/UpcomingTotalAppointment Api Response to get NextWeekSchedule Count
  void getNextScheduleCount() async{

    NextScheduleRequest requestModel = NextScheduleRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);

    var responseModel = await repository.hitNextAppointmentCountApi(requestModel);

    if(responseModel != null){
      nextScheduleCount.value = responseModel.toString();
      log('COUNT nextAppointment ${nextScheduleCount.value}');
      getToadyBillCount();
    }
  }

  ///*
  ///
  /// get Dashboard/TotalAppointmentBill Api Response to get TodayBill Count
  void getToadyBillCount() async{

    TodayBillRequest requestModel = TodayBillRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);

    var responseModel = await repository.hitAppointmentBillAmountApi(requestModel);

    if(responseModel != null){
      todayBillCount.value = responseModel.toString();
      log('COUNT AppointmentBill ${todayBillCount.value}');
      getYourClinicCount();
    }
  }

  ///*
  ///
  /// get Dashboard/NoOfClinic Api Response to get YourClinics Count
  void getYourClinicCount() async{

    YourClinicRequest requestModel = YourClinicRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);

    var responseModel = await repository.hitYourClinicApi(requestModel);

    if(responseModel != null){
      yourClinicsCount.value = responseModel.toString();
      log('COUNT yourClinicCount ${yourClinicsCount.value}');
      getProfileCompletionCount();
    }
  }



  ///*
  ///
  /// get Bookings/providerAppointmentHistory Api Response to get Recent and Upcoming Appointment List
  void getAppointmentsResponse(String bookingType) async{

    ProviderDashboardAppointmentsRequest requestModel = ProviderDashboardAppointmentsRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.bookingtype = bookingType;

    List<ProviderDashboardAppointmentsResponse>? responseModel = await repository.hitDashboardAppointmentsApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      if(bookingType == 'Recent'){
        recentAppointmentList.clear();
        recentAppointmentList.value = responseModel.reversed.toList();

      }else if(bookingType == 'Upcoming'){
        upcomingAppointmentList.clear();
        upcomingAppointmentList.value = responseModel.reversed.toList();
      }
    }else{
      if(bookingType == 'Recent'){
        recentAppointmentList.clear();

      }else if(bookingType == 'Upcoming'){
        upcomingAppointmentList.clear();


      }
    }
  }



  ///*
  ///
  /// get Users/getUserProfileCompletionStatus Api Response to get status of ProfileComplete Count
  void getProfileCompletionCount() async{

    ProviderProfileCompletionCountRequest requestModel = ProviderProfileCompletionCountRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderProfileCompletionCountResponse>? responseModel = await repository.hitProfileCompletionCountApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      profileCompleteCount.value = responseModel[0].profileScore!;
      }else{
      profileCompleteCount.value = '0';
    }
  }


  ///*
  ///
  /// get Bookings/checkAppointmentCancellation Api Response
  /// to check is Appointment cancelable for recent and upcoming appointment
  /// if get success 1 then you can cancel appointment by calling getCancelAppointmentResponse()
  void getCheckCancelAppointmentResponse(int index, String type) async{
    CheckAppointmentCancelRequest requestModel = CheckAppointmentCancelRequest();

    if(type == 'Recent'){
      requestModel.id = recentAppointmentList[index].id;

    }else if(type == 'Upcoming'){
      requestModel.id = upcomingAppointmentList[index].id;

    }


    List<CheckAppointmentCancelResponse>? responseModel = await repository.hitCheckAppointmentCancelApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      if(responseModel[0].success == '1'){

        getCancelAppointmentResponse(index, type);

      }else if(responseModel[0].success == '0'){
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: responseModel[0].message,
            img: errorImage,
          ),
        );
      }
    }
  }

  ///*
  ///
  /// get Bookings/cancelBookingByProvider api response to cancel appointment for both
  /// Recent and Upcoming appointment list
  void getCancelAppointmentResponse(int index, String type) async{
    ProviderCancelAppointmentRequest requestModel = ProviderCancelAppointmentRequest();

    if(type == 'Recent'){
      requestModel.appointmentSettingId = recentAppointmentList[index].appointmentSettingId;
      requestModel.beneficiaryComment = recentAppointmentList[index].beneficiaryComment;
      requestModel.id = recentAppointmentList[index].id;
      requestModel.isBookingCancelledByReceiver = true;
      requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
      requestModel.serviceReceiverId =   recentAppointmentList[index].serviceReceiverId;

    }else if(type == 'Upcoming'){
      requestModel.appointmentSettingId = upcomingAppointmentList[index].appointmentSettingId;
      requestModel.beneficiaryComment = upcomingAppointmentList[index].beneficiaryComment;
      requestModel.id = upcomingAppointmentList[index].id;
      requestModel.isBookingCancelledByReceiver = true;
      requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
      requestModel.serviceReceiverId =   upcomingAppointmentList[index].serviceReceiverId;

    }


    List<ProviderCancelAppointmentResponse>? responseModel = await repository.hitCancelAppointmentApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      getAppointmentsResponse(type); //call to get updated list for both recent and upcoming
    }
  }

  ///*
  ///
  /// get Dashboard/getNotification Api Response to show unread notification count on home screen
  void getNotificationListResponse() async{

    NotificationListRequest requestModel = NotificationListRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<NotificationListResponse>? responseModel = await repository.hitGetNotificationListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){

      var unreadList = <NotificationListResponse>[];
      for (NotificationListResponse data in responseModel) {
        if (data.isread! == 0) {
          unreadList.add(data);  //filter unread notification to show count on home screen
        }
      }
      notificationCount.value = unreadList.length;
    }else{
      notificationCount.value = 0;
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