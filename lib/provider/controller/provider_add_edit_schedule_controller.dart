import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_add_edit_schedule_request.dart';
import 'package:soowgood/provider/model/request/provider_admin_charges_request.dart';
import 'package:soowgood/provider/model/request/provider_clinic_list_request.dart';
import 'package:soowgood/provider/model/request/provider_consultancy_type_request.dart';
import 'package:soowgood/provider/model/request/provider_schedule_details_request.dart';
import 'package:soowgood/provider/model/request/provider_schedule_duplication_request.dart';
import 'package:soowgood/provider/model/request/provider_schedule_type_request.dart';
import 'package:soowgood/provider/model/response/provider_add_edit_schedule_response.dart';
import 'package:soowgood/provider/model/response/provider_admin_charges_response.dart';
import 'package:soowgood/provider/model/response/provider_clinic_list_response.dart';
import 'package:soowgood/provider/model/response/provider_consultancy_type_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_details_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_duplication_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_type_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

import '../screen/provider_add_edit_schedule_screen.dart';
import '../screen/provider_schedule_screen.dart';

class ProviderAddEditScheduleController extends GetxController{
  late Function refreshPage;
  ProviderRepository repository = ProviderRepository();

  var clinicList = <ProviderClinicListResponse>[].obs;
  var selectedClinic = ProviderClinicListResponse().obs;

  var scheduleTypeList = <ProviderScheduleTypeResponse>[].obs;
  var selectedScheduleType = ProviderScheduleTypeResponse().obs;

  var consultancyTypeList = <ProviderConsultancyTypeResponse>[].obs;
  var selectedConsultancyType = ProviderConsultancyTypeResponse().obs;


  List<String> weekDays = <String>[];
  List<MultiSelectItem<String>> multiWeekDayList = <MultiSelectItem<String>>[];
  List<Object?> selectedWeekDayList = <Object?>[];


  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController noOfPatientsController = TextEditingController();
  TextEditingController timeSlotController = TextEditingController();
  TextEditingController appointmentFeeController = TextEditingController();
  TextEditingController adminChargesController = TextEditingController();
  TextEditingController patientChargesController = TextEditingController();
  var isActive = false.obs;

  String callFrom = '';
  String scheduleId = '';
  var isBack = false.obs;

  var isStartTimeEmpty = false.obs;
  var isEndTimeEmpty = false.obs;
  var isTimeSlotEmpty = false.obs;
  var isNoOfPatientEmpty = false.obs;
  var isInValidNoOfPatient = false.obs;
  var isAppointmentFeeEmpty = false.obs;

  var appointmentServiceId = ''.obs;

  var scheduleDetail = ProviderScheduleDetailResponse().obs;

  ///*
  ///
  ///
  void isDataValid(){
    if(selectedClinic.value.id!.isEmpty){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please Select Clinic",
          img: errorImage,
        ),
      );

    } else if(selectedScheduleType.value.id!.isEmpty){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please Select Type Of Schedule",
          img: errorImage,
        ),
      );

    }else if(selectedWeekDayList.isEmpty){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please Select Week Days",
          img: errorImage,
        ),
      );

    }else if(startTimeController.text.isEmpty) {
      setAllErrorToFalse();
      isStartTimeEmpty.value = true;

    }else if(endTimeController.text.isEmpty) {
      setAllErrorToFalse();
      isEndTimeEmpty.value = true;

    }else if(noOfPatientsController.text.isEmpty){
      setAllErrorToFalse();
      isNoOfPatientEmpty.value = true;

    }else if(noOfPatientsController.text.isNotEmpty && noOfPatientsController.text == '0' ){
      setAllErrorToFalse();
      isInValidNoOfPatient.value = true;

    }else if(timeSlotController.text.isEmpty) {
      setAllErrorToFalse();
      isTimeSlotEmpty.value = true;

    } else if(selectedConsultancyType.value.id!.isEmpty){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please Select Type Of Consultancy",
          img: errorImage,
        ),
      );

    }else if(appointmentFeeController.text.isEmpty){
      setAllErrorToFalse();
      isAppointmentFeeEmpty.value = true;

    }else {
      getCheckScheduleResponse();

    }
  }


  ///*
  ///
  ///
  void getConsultancyTypeResponse() async{

    ProviderConsultancyTypeRequest requestModel = ProviderConsultancyTypeRequest();
    requestModel.id =   MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderConsultancyTypeResponse>? responseModel = await repository.hitConsultancyTypeApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      consultancyTypeList.value = responseModel;
      getAdminChargesResponse();
    }else{
      consultancyTypeList.clear();
      getAdminChargesResponse();
    }
  }


  ///*
  ///
  ///
  void getScheduleTypeResponse() async{

    ProviderScheduleTypeRequest requestModel = ProviderScheduleTypeRequest();
    requestModel.userId =   MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderScheduleTypeResponse>? responseModel = await repository.hitScheduleTypeApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      scheduleTypeList.value = responseModel;
      getConsultancyTypeResponse();
    }else{
      scheduleTypeList.clear();
      getConsultancyTypeResponse();
    }
  }


  ///*
  ///
  ///
  void getClinicListResponse() async{

    ProviderClinicListRequest requestModel = ProviderClinicListRequest();
    requestModel.userId =   MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderClinicListResponse>? responseModel = await repository.hitClinicListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      clinicList.value = responseModel;
      getScheduleTypeResponse();
    }else{
      clinicList.clear();
      getScheduleTypeResponse();
    }
  }


  ///*
  ///
  ///
  void getAdminChargesResponse() async{

    ProviderAdminChargesRequest requestModel = ProviderAdminChargesRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);

    ProviderAdminChargesResponse? responseModel = await repository.hitAdminChargesApi(requestModel);

    if(responseModel != null){
      log('ADMIN_CHARGES ${responseModel.commission.toString()}');
      adminChargesController.text = responseModel.commission!.toString();
      if(callFrom == 'Edit'){
        getScheduleDetailResponse();
      }

    }
  }

  ///*
  ///
  ///
  void getCheckScheduleResponse()async {
    ProviderScheduleDuplicationRequest requestModel = ProviderScheduleDuplicationRequest();
    requestModel.appointmentSettingId = scheduleId;
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.appointmentType = selectedConsultancyType.value.id;
    requestModel.clinicId = selectedClinic.value.id;
    requestModel.dayEndingTime = endTimeController.text;
    requestModel.dayStartingTime = startTimeController.text;
    requestModel.daysOfWeek = selectedWeekDayList.join(',');

    ProviderScheduleDuplicationResponse? responseModel = await repository
        .hitCheckScheduleApi(requestModel);

    if (responseModel != null) {
      if (responseModel.success == '1') {
        log('getCheckScheduleResponse : Success Schedule');
        getSaveUpdateScheduleResponse();

      } else {
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) =>
              CustomDialog(
                  my_context: Get.context!,
                  img: errorImage,
                  title: "",
                  description: responseModel.message!,
                  buttonText: 'Ok',
                  okBtnFunction: (){Get.back();}
              )
        );
      }
    }
  }

  ///*
  ///
  ///
  void getSaveUpdateScheduleResponse()async {
    ProviderAddEditScheduleRequest requestModel = ProviderAddEditScheduleRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);

    if(scheduleId.isEmpty){
      requestModel.appointmentSettingId = null;

    }else{
      requestModel.appointmentSettingId = scheduleId;

    }
    requestModel.appointmentType = "<rows><row>"
        "<AppointmentServiceId>${appointmentServiceId.value}</AppointmentServiceId>"
        "<AppointmentTypeId>${selectedConsultancyType.value.id}</AppointmentTypeId>"
        "<appointmentFees>${appointmentFeeController.text}</appointmentFees>"
        "<isActive>Yes</isActive>"
        "</row></rows>";
    requestModel.clinicId = selectedClinic.value.id;
    requestModel.dayEndingTime = endTimeController.text;
    requestModel.dayStartingTime = startTimeController.text;
    requestModel.noOfPatients = noOfPatientsController.text;
    requestModel.taskTypeId = selectedScheduleType.value.id;
    requestModel.timeSlot = timeSlotController.text;
    requestModel.daysOfWeek = selectedWeekDayList.join(',');

    ProviderAddEditScheduleResponse? responseModel = await repository.hitAddEditScheduleApi(requestModel);

    if (responseModel != null) {
      ProviderGlobal.isScheduleBack = true;

      if(callFrom == 'Edit'){
        showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                CustomDialog(
                    my_context: Get.context!,
                    img: successImage,
                    title: "",
                    description: 'Schedule Updated Successfully',
                    buttonText: 'Ok',
                    okBtnFunction: okFunction
                )
        );
      }else{
        showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                CustomDialog(
                    my_context: Get.context!,
                    img: successImage,
                    title: "",
                    description: 'Schedule Added Successfully',
                    buttonText: 'Ok',
                    okBtnFunction: okFunction
                )
        );
      }

    }
  }

  ///*
  ///
  ///
  void setAllErrorToFalse() {
     isStartTimeEmpty.value = false;
     isEndTimeEmpty.value = false;
     isTimeSlotEmpty.value = false;
     isNoOfPatientEmpty.value = false;
     isInValidNoOfPatient.value = false;
     isAppointmentFeeEmpty.value = false;
  }


  ///*
  ///
  ///
  getWeekdaysList(){
    weekDays.add('Sunday');
    weekDays.add('Monday');
    weekDays.add('Tuesday');
    weekDays.add('Wednesday');
    weekDays.add('Thursday');
    weekDays.add('Friday');
    weekDays.add('Saturday');

    multiWeekDayList = weekDays.map((e) => MultiSelectItem(e, e)).toList();
  }

  ///*
  ///
  ///
  void clearAll() {

    callFrom = '';
    scheduleId = '';

    selectedClinic.value.id = '';
    selectedClinic.value.name = '';

    selectedScheduleType.value.id = '';
    selectedScheduleType.value.name = '';

    selectedConsultancyType.value.id = '';
    selectedConsultancyType.value.name = '';

    selectedWeekDayList.clear();
    startTimeController.clear();
    endTimeController.clear();
    noOfPatientsController.clear();
    timeSlotController.clear();
    appointmentFeeController.clear();
    patientChargesController.clear();
    isActive.value = false;

    appointmentServiceId.value = '';
  }


  ///*
  ///
  ///
  void getScheduleDetailResponse() async{
    ProviderScheduleDetailRequest requestModel = ProviderScheduleDetailRequest();
    requestModel.id = scheduleId;

    List<ProviderScheduleDetailResponse>? responseModel = await repository.hitScheduleDetailApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      scheduleDetail.value = responseModel[0];

      log("SCHEDULE_DETAILS ${json.encode(scheduleDetail.value)}");
      setData();
    }
  }

  ///*
  ///
  ///
  void setData() {
    String clinicId = scheduleDetail.value.clinicId!;
    String scheduleId = scheduleDetail.value.taskTypeId!;
    String scheduleType = scheduleDetail.value.taskType!;
    String startTime = scheduleDetail.value.dayStartingTime!;
    String endTime = scheduleDetail.value.dayEndingTime!;
    String noOfPatient = scheduleDetail.value.noOfPatients!.toString();
    String consultancyTypeId = scheduleDetail.value.appointmentServiceTypeList![0].appointmentTypeId!;
    String consultancyType = scheduleDetail.value.appointmentServiceTypeList![0].consultancyType!;
    String appointmentFee = scheduleDetail.value.appointmentServiceTypeList![0].appointmentFees!.toString();



    for(int index = 0; index < clinicList.length; index++){
      if(clinicList[index].id == clinicId){
        selectedClinic.value = clinicList[index];
        log('SELECTED_ CLINIC_NAME ${selectedClinic.value.name}');
        break;
      }
    }

    for(int index = 0; index < scheduleTypeList.length; index++){
      if(scheduleTypeList[index].id == scheduleId){
        selectedScheduleType.value = scheduleTypeList[index];
        log('SELECTED_ SCHEDULE_NAME ${selectedScheduleType.value.name}');
        break;
      }
    }

    for(int index = 0; index < consultancyTypeList.length; index++){
      if(consultancyTypeList[index].id == consultancyTypeId){
        selectedConsultancyType.value = consultancyTypeList[index];
        log('SELECTED_ CONSULTANCY_NAME ${selectedConsultancyType.value.name}');
        break;
      }
    }

    for(int index = 0; index < scheduleDetail.value.appointmentDayList!.length; index++){
      selectedWeekDayList.add(scheduleDetail.value.appointmentDayList![index].appointmentDayOfWeek);
    }
    log("SELECTED_ WEEKDAY ${selectedWeekDayList.toString()}");

    startTimeController.text = startTime;
    endTimeController.text = endTime;
    noOfPatientsController.text = noOfPatient;
    appointmentFeeController.text = appointmentFee;
    appointmentServiceId.value = scheduleDetail.value.appointmentServiceTypeList![0].appointmentServiceId!;

    getTimeSlot();
    getPatientCharges();

  }


  ///*
  ///
  ///
  void getTimeSlot(){

    if(startTimeController.text.isNotEmpty && endTimeController.text.isNotEmpty) {
      String startTime = startTimeController.text;
      String endTime = endTimeController.text;
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      var date = dateFormat.format(DateTime.now());
      DateTime startDateTime = DateFormat("yyyy-MM-dd hh:mm").parse('$date $startTime');
      DateTime endDateTime = DateFormat("yyyy-MM-dd hh:mm").parse('$date $endTime');
      
      int inMinutes = endDateTime
          .difference(startDateTime)
          .inMinutes;
      log('IN_MINUTES $inMinutes');

      int patients = int.parse(noOfPatientsController.text.toString());
      double slot = inMinutes/patients;
      var slots = slot.toInt();
      timeSlotController.text = slots.toString();
    }

  }


  ///*
  ///
  ///
  void getPatientCharges(){

    double commissionDouble = double.parse(adminChargesController.text.toString());
    double fees = double.parse(appointmentFeeController.text.toString());
    double patientCharges = (fees*commissionDouble)/100 + fees;

    patientChargesController.text = patientCharges.round().toString();
    // setState(() {});

  }


  ///*
  ///
  ///
  okFunction() {
    clearAll();
    Navigator.pop(Get.context!);
    Navigator.pushReplacement(
      Get.context!,
      MaterialPageRoute(builder: (context) => const ProviderScheduleScreen()),
    );
    // Get.to(() => const ProviderScheduleScreen());
  }
}