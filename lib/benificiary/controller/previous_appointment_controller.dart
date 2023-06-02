import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/model/request/appointment_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_cancel_appointment_request.dart';
import 'package:soowgood/benificiary/model/request/cancel_appointment_by_patient_request.dart';
import 'package:soowgood/benificiary/model/request/check_appointment_cancel_request.dart';
import 'package:soowgood/benificiary/model/response/appointment_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_cancel_appointment_response.dart';
import 'package:soowgood/benificiary/model/response/cancel_appointment_by_patient_response.dart';
import 'package:soowgood/benificiary/model/response/check_appointment_cancel_response.dart';
import 'package:soowgood/benificiary/repository/beneficiary_repository.dart';
import 'package:soowgood/common/conference/conference_page.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';

class   PreviousAppointmentController extends  GetxController{

  BeneficiaryRepository repository = BeneficiaryRepository();
  var appointmentList = <AppointmentListResponse>[].obs;
  List<AppointmentListResponse> appointmentListNew = <AppointmentListResponse>[];
  TextEditingController searchController = TextEditingController();
  var isShow = false.obs;

  ///*
  ///
  ///
  void getAppointmentListResponse() async{
    AppointmentListRequest requestModel = AppointmentListRequest();
    requestModel.serviceReceiverId =   MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.bookingtype = 'Previous'/*'Dashboard Recent'*/;
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
      appointmentList.value = responseModel;
    }else{
      appointmentList.clear();
    }
  }


  ///*
  ///
  ///
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


}