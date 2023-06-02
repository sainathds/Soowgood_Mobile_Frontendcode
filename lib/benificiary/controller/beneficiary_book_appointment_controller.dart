import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soowgood/benificiary/model/request/add_edit_booking_doc_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_add_edit_booking_request.dart';
import 'package:soowgood/benificiary/model/request/update_patient_data_request.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_add_edit_booking_responset.dart';
import 'package:soowgood/benificiary/model/response/ratings_list_response.dart';
import 'package:soowgood/benificiary/model/response/schedule_for_booking_response.dart';
import 'package:soowgood/benificiary/repository/beneficiary_repository.dart';
import 'package:soowgood/benificiary/screen/beneficiry_doctors_screen.dart';
import 'package:soowgood/benificiary/screen/booking_summary_screen.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_education_list_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_request.dart';
import 'package:soowgood/provider/model/request/schedule_for_booking_request.dart';
import 'package:soowgood/provider/model/response/provider_education_list_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_response.dart';
import 'package:soowgood/provider/model/response/provider_specialization_list_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

import '../../provider/model/request/provider_specialization_list_request.dart';

class BeneficiaryBookAppointmentController extends GetxController{


  late Function showModalSheet;

  BeneficiaryRepository beneficiaryRepository = BeneficiaryRepository();
  ProviderRepository providerRepository = ProviderRepository();
  String providerId = '';
  var educationList = <ProviderEducationListResponse>[].obs;
  var specializationList = <ProviderSpecializationListResponse>[].obs;
  var specializationDataList = <String>[].obs;
  var clinicScheduleList = <Data>[].obs;
  var tempClinicScheduleList = <Data>[].obs;
  var cliniList = <Cliniclist>[].obs;
  var allScheduleList = <Data>[].obs;
  var clinicWiseDateData = <Appointmentdatedata>[].obs;
  var allAppointmentDateData = <Appointmentdatedata>[].obs;

  var selectedDate = ''.obs;
  var selectedAppointmentDate = Appointmentdatedata().obs;


  var selectedScheduleData = Data().obs;

  var selectedClinicIndex = 0.obs;
  var selectedClinicData = Cliniclist().obs;


  var providerImageUrl = ''.obs;
  var name = ''.obs;
  var speciality = ''.obs;
  String ratingCount = '0';
  String reviews = '';
  var aboutContent = ''.obs;
  var specialities = ''.obs;
  var isClinicSelected = false.obs;
  var isOnlineSelected = false.obs;
  var isPhysicsSelected = false.obs;

  var selectedAppointmentType = ''.obs;

  var bookingId = ''.obs;
  var startTime = ''.obs;
  var endTime = ''.obs;
  var paidAmount = ''.obs;


  var file = "".obs;
  var fileName = ''.obs;
  var isAccepted = true.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  var isNameEmpty = false.obs;
  var isAddressEmpty = false.obs;


  var appointmentType = <String>[].obs;

  List<getRatingDataListResponse> ratingDataList = [];

  ///*
  ///
  ///
  void isDataValid(){
  if(selectedScheduleData.value.appointmentSettingId == null ){
    showDialog(
      context: Get.context!,
      builder: (BuildContext context1) => OKDialog(
        title: "",
        descriptions: 'Please select schedule',
        img: errorImage,
      ),
    );
    }else{
      getAddEditBookingResponse();
    }
  }

  ///*
  ///
  /// get Degrees/GetDegree Api Response
  /// to get providers education list
  void getEducationListResponse() async{

    ProviderEducationListRequest requestModel = ProviderEducationListRequest();
    requestModel.userId = providerId;

    List<ProviderEducationListResponse>? responseModel = await providerRepository.hitEducationListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      educationList.clear();
      educationList.value = responseModel;
    }else{
      educationList.clear();
    }
  }

  ///*
  ///
  /// get Specializations/GetSpecialization Api response
  /// to get provider Specializations
  void getSpecializationListResponse() async{
    ProviderSpecializationListRequest requestModel = ProviderSpecializationListRequest();
    requestModel.userId = providerId;

    List<ProviderSpecializationListResponse>? responseModel = await providerRepository.hitGetSpecializationListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      specializationList.clear();
      specializationList.value = responseModel;

       specializationDataList.value = specializationList[0].specializationName!.split(',');
    }else{
      specializationList.clear();

    }
  }

  ///*
  ///
  /// get AppointmentSettings/AppointmentListForBooking Api response
  /// to get schedule list according to AppointmentType - Clinic, Online, or Physical Visit
  /// to get all clinics of provider
  /// to get all appointmentDateTime Data
  Future getScheduleListResponse() async{

    ScheduleForBookingRequest requestModel = ScheduleForBookingRequest();
    requestModel.serviceProviderId = providerId;
    requestModel.appointmentType = selectedAppointmentType.value;

    ScheduleForBookingResponse? responseModel = await beneficiaryRepository.hitScheduleForBookingApi(requestModel);

    if(responseModel != null){
      if(responseModel.success == '1'){
        if(responseModel.data != null || responseModel.data!.isNotEmpty){
          allScheduleList.clear();
          allScheduleList.value = responseModel.data!;
        }else{
          allScheduleList.clear();
        }

        if(responseModel.cliniclist != null && responseModel.cliniclist!.isNotEmpty){
          cliniList.clear();
          cliniList.value = responseModel.cliniclist!;
        }else{
          cliniList.clear();
        }

        if(responseModel.appointmentdatedata != null && responseModel.appointmentdatedata!.isNotEmpty){
          allAppointmentDateData.clear();
          allAppointmentDateData.value = responseModel.appointmentdatedata!;

        }else{
          allAppointmentDateData.clear();
        }
      }else{
        allScheduleList.clear();
        cliniList.clear();
        allAppointmentDateData.clear();


      }
    }else{
      allScheduleList.clear();
      cliniList.clear();
      allAppointmentDateData.clear();
    }
  }

  ///*
  ///
  /// get Users/getuserdatabyid api response to get provider profile data
  void getProviderDataResponse() async{
    ProviderProfileRequest requestModel = ProviderProfileRequest();
    requestModel.id = providerId;

    List<ProviderProfileResponse>? responseModel = await providerRepository.hitProfileDataApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      name.value = getData(responseModel[0].fullname);
      aboutContent.value = getData(responseModel[0].aboutme);
      providerImageUrl.value = getData(responseModel[0].profilephoto);

      if(providerImageUrl.value != ""){
        providerImageUrl.value = ApiConstant.fileBaseUrl + ApiConstant.profilePicFolder + providerImageUrl.value;
        log('PROVIDER_IMG_URL ${providerImageUrl.value}');
      }

    }
  }

  ///*
  ///
  /// get Users/getProvideReviewRating Api Response
  /// to get rating and review data of provider
  void getRatingDataResponse() async{
    ProviderProfileRequest requestModel = ProviderProfileRequest();
    requestModel.id = providerId;

    var responseModel = await providerRepository.hitRatingDataApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      var jsonObject = responseModel.first;
    print(jsonObject["totalratingpoint"]);
    ratingCount = jsonObject["totalratingpoint"].toString();
    reviews = jsonObject["totalreview"].toString();

    }
  }

  ///*
  Future getRatingListDataResponse() async{
    ProviderProfileRequest requestModel = ProviderProfileRequest();
    requestModel.id = providerId;

    List<getRatingDataListResponse>? responseModel = await providerRepository.hitRatingListDataApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      ratingDataList = responseModel;
    }
  }


  ///*
  void getAddEditBookingResponse() async{
    BeneficiaryAddEditBookingRequest requestModel = BeneficiaryAddEditBookingRequest();
    requestModel.appointmentSettingId = selectedScheduleData.value.appointmentSettingId;
    requestModel.dayofWeek = selectedScheduleData.value.appointmentDayOfWeek;
    requestModel.id = null;
    requestModel.serviceProviderId = providerId;
    requestModel.serviceReceiverId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.tentativeDate = getServerDate(selectedScheduleData.value.appointmentDate);
    requestModel.appointmentServiceId = selectedScheduleData.value.appointmentServiceId;
    requestModel.appointmentamt = selectedScheduleData.value.appointmentFees.toString();
    requestModel.doctorcharges = selectedScheduleData.value.doctorcharges.toString();
    requestModel.paidAmount = selectedScheduleData.value.paidAmount.toString();
    requestModel.scheduleEndTime = selectedScheduleData.value.appointmentendtime.toString();
    requestModel.scheduleStartTime = selectedScheduleData.value.appointmentstartime.toString();


    var responseModel = await beneficiaryRepository.hitAddEditBookingApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      bookingId.value = responseModel[0].id!;
      startTime.value = selectedScheduleData.value.appointmentstartime.toString();
      endTime.value = selectedScheduleData.value.appointmentendtime.toString();
      paidAmount.value = responseModel[0].paidAmount.toString();
      showModalSheet.call();

      /*showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Appointment Booked Successfully',
                buttonText: 'Ok',
                okBtnFunction: clearAll
            ),
      );*/
    }
  }

  ///*
  ///
  ///
  String? getServerDate(String? appointmentDate) {

    DateFormat fromDateFormatter = DateFormat('dd MMM yyyy');
    DateFormat toDateFormatter = DateFormat('yyyy-MM-dd');

    String newDate = '';

    List<String> validadeSplit = appointmentDate!.split(' ');

    if(validadeSplit.length > 1)
    {
      int day = int.parse(validadeSplit[0].toString());
      String month = validadeSplit[1];
      log('MONTH $month');
      int year = int.parse(validadeSplit[2].toString());

      String date = '$day $month $year';

      DateTime appointmentDateTime = fromDateFormatter.parse(date);
      log('DATE $appointmentDateTime');
      newDate = toDateFormatter.format(appointmentDateTime);
      log('newDate $newDate');


      
      /*_stringdate = DateTime.utc(year, month, day);
      formatedDate = formatter.format(_stringdate);
      print("tempDate :" + formatedDate);*/

    }

    return newDate;
  }



  dismiss() {
  }

  ///*
  ///
  /// use Bookings/addupdateBookingDocument api to upload document against particular booking
  void getUploadPrescriptionResponse() async{
    AddEditBookingDocRequest requestModel = AddEditBookingDocRequest();
    requestModel.bookingId = bookingId.value;
    requestModel.filetype = 'noturl';
    if(file.value.isNotEmpty){
      requestModel.file = file.value;
    }else{
      requestModel.file = "";
    }


    bool isUploadedSuccessfully = await beneficiaryRepository.hitUploadPrescriptionApi(requestModel);

    if(isUploadedSuccessfully){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Document Uploaded Successfully',
                buttonText: 'Ok',
                okBtnFunction: dismiss
            ),
      );
    }
  }


  void clearAll(){
    providerId = '';

    tempClinicScheduleList.clear();
    allScheduleList.clear();
    clinicWiseDateData.clear();
    allAppointmentDateData.clear();

    educationList.clear();
    specializationList.clear();
    specializationDataList.clear();
    clinicScheduleList.clear();
    cliniList.clear();

    providerImageUrl.value = '';
    name.value = '';
    speciality.value = '';
    aboutContent.value = '';
    specialities.value = '';
    isClinicSelected.value = false;
    isOnlineSelected.value = false;
    isPhysicsSelected.value = false;
    selectedAppointmentType.value = '';
    bookingId.value = '';

    fileName.value = '';
    file.value = '';

  }

  ///*
  ///
  ///
  void setAllErrorToFalse() {
    isNameEmpty.value = false;
    isAddressEmpty.value = false;
  }

  ///*
  ///
  /// check validation for required field
  void isPatientDataValid() {

    if(nameController.text.trim().isEmpty){
      isNameEmpty.value = true;

    }else if(selectedAppointmentType.value == 'Physical Visit' && addressController.text.trim().isEmpty){
      isAddressEmpty.value = true;

    }else{
      getUpdatePatientDataResponse();
    }
  }

  ///*
  ///
  /// use Bookings/updatePatientInfoIntoBooking Api
  /// to save  patient data for booking
  void getUpdatePatientDataResponse() async{

    UpdatePatientDataRequest requestModel = UpdatePatientDataRequest();
    requestModel.id = bookingId.toString();
    requestModel.patientName = nameController.text.trim();
    requestModel.patientAddress = addressController.text.trim();


    var responseModel = await beneficiaryRepository.hitUpdatePatientDataApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      Get.off(() => BookingSummaryScreen(bookingId: bookingId.value,)); //show booking summary
    }
  }

  ///*
  ///
  ///
  String getData(String? data) {
    if(data == null){
      return '';
    }else{
      return data;
    }
  }
}