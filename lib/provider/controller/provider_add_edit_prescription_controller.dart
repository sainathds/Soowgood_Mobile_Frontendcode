import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_advice_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_drug_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_medical_test_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_prescription_data_request.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_advice_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_drug_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_medical_test_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_data_response.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_add_edit_prescription_request.dart';
import 'package:soowgood/provider/model/response/provider_add_edit_prescription_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';
import 'package:path_provider/path_provider.dart';


class ProviderAddEditPrescriptionController extends GetxController{
  ProviderRepository repository = ProviderRepository();
  var callFrom = ''.obs;
  var receiverId = ''.obs;
  var bookingId = ''.obs;
  var name = ''.obs;
  var age = ''.obs;
  var gender = ''.obs;
  var date = ''.obs;
  var prescriptionDate = ''.obs;
  var prescriptionId = ''.obs;

  var medicalTestList = <BeneficiaryMedicalTestResponse>[].obs;
  var adviceList = <BeneficiaryAdviceListResponse>[].obs;
  var drugList = <BeneficiaryDrugListResponse>[].obs;

  TextEditingController diagnosisController = TextEditingController();
  TextEditingController testNameController = TextEditingController();
  TextEditingController adviceController = TextEditingController();
  TextEditingController drugController = TextEditingController();
  TextEditingController doseController = TextEditingController();

  var isDiagnosisNameEmpty = false.obs;
  var isDrugEmpty = false.obs;
  var isDoseEmpty = false.obs;
  var isWeekDaysEmpty = false.obs;
  var isTimingEmpty = false.obs;
  var isDrugDataValid = false.obs;

  var testNameIndex = 0.obs;
  var selectedTest = BeneficiaryMedicalTestResponse().obs;
  var isTestSelect = false.obs;

  var adviceIndex = 0.obs;
  var selectedAdvice = BeneficiaryAdviceListResponse().obs;
  var isAdviceSelect = false.obs;

  var drugIndex = 0.obs;
  var selectedDrug = BeneficiaryDrugListResponse().obs;
  var isDrugSelect = false.obs;


  List<String> weekDays = <String>[];
  List<MultiSelectItem<String>> multiWeekDayList = <MultiSelectItem<String>>[];
  List<Object?> selectedWeekDayList = <Object?>[];

  List<String> timingList = <String>[];
  List<MultiSelectItem<String>> multiTimingList = <MultiSelectItem<String>>[];
  List<Object?> selectedTimingList = <Object?>[];

  XFile? imageFile;
  var isLoad = false.obs;
  var signatureImageUrl = ''.obs;


  var compressedImageFilePath = ''.obs;

  ///*
  ///
  /// check validations for required field
  isDataValid(){
    if(diagnosisController.text.trim().isEmpty){
      isDiagnosisNameEmpty.value = true;

    }else if(drugList.isEmpty){
      showDialog(context: Get.context!,
          builder: (context){
            return OKDialog(
              title: ' ',
              descriptions: 'Please Add Drug Data',
              img: errorImage,
            );
          });

    }else if(medicalTestList.isEmpty){
      showDialog(context: Get.context!,
          builder: (context){
            return OKDialog(
              title: ' ',
              descriptions: 'Please Add Medical Test',
              img: errorImage,
            );
          });
    }else if(adviceList.isEmpty){
      showDialog(context: Get.context!,
          builder: (context){
            return OKDialog(
              title: ' ',
              descriptions: 'Please Add Advice',
              img: errorImage,
            );
          });
    }else if(callFrom.value == 'Add' && imageFile == null){
      showDialog(context: Get.context!,
          builder: (context){
            return OKDialog(
              title: ' ',
              descriptions: 'Please Add Signature',
              img: errorImage,
            );
          });
    }else {
      getSaveUpdatePrescriptionResponse();
    }
  }

  ///*
  ///
  /// get Bookings/getServiceReceiverForPrescription Api Response to get
  /// patient Data
  void getPrescriptionPatientData()async{
    BeneficiaryPrescriptionDataRequest requestModel = BeneficiaryPrescriptionDataRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.serviceReceiverId = receiverId.value;
    List<BeneficiaryPrescriptionDataResponse>? responseModel = await repository.hitPrescriptionDataApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      name.value = getData(responseModel[0].serviceReceiver);
      age.value = getData(responseModel[0].age.toString());
      gender.value = getData(responseModel[0].gender);
      date.value = getUiDate(getData(responseModel[0].bookingDate));
      prescriptionDate.value = getData(responseModel[0].bookingDate);
    }

    if(callFrom.value == 'Edit'){
      getDrugListResponse();
    }
  }

  ///*
  ///
  /// get Bookings/getprescriptiondurgdetails Api Response to get
  /// Drug history
  void getDrugListResponse()async{
    BeneficiaryDrugListRequest requestModel = BeneficiaryDrugListRequest();
    requestModel.id = prescriptionId.value;

    List<BeneficiaryDrugListResponse>? responseModel = await repository.hitDrugListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      drugList.clear();
      drugList.value = responseModel;
      getMedicalTestListResponse();
    }else{
      drugList.clear();
      getMedicalTestListResponse();
    }
  }


  ///*
  ///
  /// get Bookings/getprescriptionmedicaltestdetails Api Response to get
  /// medical Test history
  void getMedicalTestListResponse()async{
    BeneficiaryMedicalTestRequest requestModel = BeneficiaryMedicalTestRequest();
    requestModel.id = prescriptionId.value;

    List<BeneficiaryMedicalTestResponse>? responseModel = await repository.hitMedicalTestListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      medicalTestList.clear();
      medicalTestList.value = responseModel;
      getAdviceListResponse();
    }else{
      medicalTestList.clear();
      getAdviceListResponse();
    }
  }

  ///*
  ///
  /// get Bookings/getprescriptionadvicetestdetails APi Response to get
  /// Advice history list
  void getAdviceListResponse()async{
    BeneficiaryAdviceListRequest requestModel = BeneficiaryAdviceListRequest();
    requestModel.id = prescriptionId.value;

    List<BeneficiaryAdviceListResponse>? responseModel = await repository.hitAdviceListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      adviceList.clear();
      adviceList.value = responseModel;
    }else{
      adviceList.clear();
    }
  }


  ///*
  ///
  /// get formatted date
  String getUiDate(String? appointmentDate) {

    String subString = appointmentDate!.substring(0,10);

    log('BookingDate substring: $subString');


    DateFormat fromDateFormatter = DateFormat('yyyy/MM/dd');
    DateFormat toDateFormatter = DateFormat('dd MMM yyyy');

    String newDate = '';

    List<String> validadeSplit = subString.split('/');

    if(validadeSplit.length > 1)
    {
      int day = int.parse(validadeSplit[2].toString());
      String month = validadeSplit[1];
      int year = int.parse(validadeSplit[0].toString());

      String date = '$year/$month/$day'; //this format should be same as fromDateFormat

      DateTime appointmentDateTime = fromDateFormatter.parse(date);
      newDate = toDateFormatter.format(appointmentDateTime);
    }
    return newDate;
  }


  ///*
  ///
  ///
  String getData(String? data) {

    if(data != null){
      return data;
    }else{
      return '';
    }
  }

  ///*
  ///
  ///
  void setAllErrorToFalse() {
    isDiagnosisNameEmpty.value = false;
    isDoseEmpty.value = false;
    isDrugEmpty.value = false;
    isWeekDaysEmpty.value = false;
    isTimingEmpty.value = false;
    isDrugDataValid.value = false;
  }

  ///*
  ///
  ///
  getWeekdaysList(){
    weekDays.add('Sun');
    weekDays.add('Mon');
    weekDays.add('Tue');
    weekDays.add('Wed');
    weekDays.add('Thu');
    weekDays.add('Fri');
    weekDays.add('Sat');

    multiWeekDayList = weekDays.map((e) => MultiSelectItem(e, e)).toList();
  }


  ///*
  ///
  ///
  getTimingList(){
    timingList.add('Morning');
    timingList.add('Afternoon');
    timingList.add('Evening');
    multiTimingList = timingList.map((e) => MultiSelectItem(e, e)).toList();
  }

  ///*
  ///
  ///
   isDrugValid() {
    if(drugController.text.trim().isEmpty){
      setAllErrorToFalse();
      isDrugEmpty.value = true;

    }else if(doseController.text.trim().isEmpty){
      setAllErrorToFalse();
      isDoseEmpty.value = true;

    }else if(selectedWeekDayList.isEmpty){
      setAllErrorToFalse();
      isWeekDaysEmpty.value = true;
      showDialog(context: Get.context!,
          builder: (context){
            return OKDialog(
              title: ' ',
              descriptions: 'Please select Weekdays',
              img: errorImage,
            );
          });

    }else if(selectedTimingList.isEmpty){
      setAllErrorToFalse();
      isTimingEmpty.value = true;
      showDialog(context: Get.context!,
          builder: (context){
            return OKDialog(
              title: ' ',
              descriptions: 'Please select Timing',
              img: errorImage,
            );
          });

    }else {
      isDrugDataValid.value = true;
    }
    return isDrugDataValid.value;
  }

  ///*
  ///
  ///
  void clearDrugData() {
    selectedWeekDayList.clear();
    selectedTimingList.clear();
    timingList.clear();
    weekDays.clear();
    multiWeekDayList.clear();
    multiTimingList.clear();
    drugController.clear();
    doseController.clear();
  }


  ///*
  ///
  /// get Bookings/savePrescriptionInformation Api Response
  /// use to save or update Prescription data
  void getSaveUpdatePrescriptionResponse()async {

    ProviderAddEditPrescriptionRequest requestModel = ProviderAddEditPrescriptionRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.serviceReceiverId = receiverId.value;
    requestModel.bookingId = bookingId.value;
    requestModel.diognosis = diagnosisController.text.trim();
    requestModel.prescriptiondate = prescriptionDate.value;
    if(callFrom.value == "Edit"){
      requestModel.id = prescriptionId.value;
    }
    requestModel.prescriptiondurgdetails = getDrugData();
    requestModel.prescriptionmedicaltestdetails = getMedicalTestData();
    requestModel.prescriptionadvicedetails = getAdviceData();


      requestModel.file = compressedImageFilePath.value;

      bool responseModel = await repository.hitAddEditPrescriptionApi(requestModel,callFrom.value);

    if (responseModel) {

      if(callFrom.value == 'Edit'){
        showDialog(
            context: Get.context!,
            builder: (BuildContext context1) =>
                CustomDialog(
                    my_context: Get.context!,
                    img: successImage,
                    title: "",
                    description: 'Prescription Data Updated Successfully',
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
                    description: 'Prescription Data Added Successfully',
                    buttonText: 'Ok',
                    okBtnFunction: clearAll
                )
        );
      }

    }
  }


  ///*
  ///
  ///
  clearAll() {
    Get.back();
    callFrom.value = '';
    receiverId.value = '';
    bookingId.value = '';
    name.value = '';
    age.value = '';
    gender.value = '';
    date.value = '';
    prescriptionDate.value = '';

    medicalTestList.clear();
    adviceList.clear();
    drugList.clear();

     diagnosisController.clear();
     testNameController.clear();
     adviceController.clear();
     drugController.clear();
     doseController.clear();

     testNameIndex.value = 0;
     selectedTest.value = BeneficiaryMedicalTestResponse();
     isTestSelect.value = false;

     adviceIndex.value = 0;
     selectedAdvice.value = BeneficiaryAdviceListResponse();
     isAdviceSelect.value = false;

     drugIndex.value = 0;
     selectedDrug.value = BeneficiaryDrugListResponse();
     isDrugSelect.value = false;

    weekDays.clear();
    multiWeekDayList.clear();
    selectedWeekDayList.clear();

    timingList.clear();
     multiTimingList.clear();
    selectedTimingList.clear();

     imageFile = null;
     isLoad.value = false;
     signatureImageUrl.value = '';
     setAllErrorToFalse();
  }

  ///*
  ///
  ///
  okFunction() {
    Navigator.pop(Get.context!);
  }

  ///*
  ///
  /// use to get DrugData in html formatted (Api requirement)
  String? getDrugData() {
    List<String> drugData = <String>[];
    for (int index = 0; index < drugList.length; index++) {
      drugData.add("<row>"
          "<durgid></durgid>"
          "<durgname>${drugList[index].durgname}</durgname>"
          "<weeklyschedule>${drugList[index].weeklyschedule}</weeklyschedule>"
          "<timing>${drugList[index].timing}</timing>"
          "<dose>${drugList[index].dose}</dose>"
          "</row>");
    }
    return '<rows>${drugData.toString()}</rows>';
  }

  ///*
  ///
  /// use to get MedicalTestData in html formatted (Api requirement)
  String? getMedicalTestData() {
    List<String> medicalTestData = <String>[] ;
    for(int index = 0; index < medicalTestList.length; index++ ){
      medicalTestData.add("<row>"
          "<testid></testid>"
          "<medicaltest>${medicalTestList[index].medicaltest}</medicaltest>"
          "</row>");
    }
    return '<rows>$medicalTestData</rows>';
  }

  ///*
  ///
  /// use to get AdviceData in html formatted (Api requirement)
  String? getAdviceData() {
    List<String> adviceData = <String>[];
    for(int index = 0; index < adviceList.length; index++ ){
          adviceData.add("<row>"
              "<adviceid></adviceid>"
              "<medicaladvice>${adviceList[index].advice}</medicaladvice>"
              "</row>");
    }
    return '<rows>$adviceData</rows>';
  }
}