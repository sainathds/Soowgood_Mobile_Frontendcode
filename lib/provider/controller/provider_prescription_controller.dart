import 'dart:developer';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_prescription_data_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_prescription_list_request.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_data_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_list_response.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

import '../../common/local_database/my_shared_preference.dart';

class ProviderPrescriptionController extends GetxController{
  ProviderRepository repository = ProviderRepository();

  var serviceReceiverId = ''.obs;
  var prescriptionList = <BeneficiaryPrescriptionListResponse>[].obs;
  var bookingId = ''.obs;
  var name = ''.obs;
  var age = ''.obs;
  var gender = ''.obs;
  var date = ''.obs;

  ///*
  ///
  /// get Bookings/getServiceReceiverForPrescription Api Response to get
  /// Patient Data
  void getPrescriptionPatientData()async{
    BeneficiaryPrescriptionDataRequest requestModel = BeneficiaryPrescriptionDataRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.serviceReceiverId = serviceReceiverId.value;
    List<BeneficiaryPrescriptionDataResponse>? responseModel = await repository.hitPrescriptionDataApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      name.value = getData(responseModel[0].serviceReceiver);
      age.value = getData(responseModel[0].age.toString());
      gender.value = getData(responseModel[0].gender);
      date.value = getUiDate(getData(responseModel[0].bookingDate));
      // prescriptionDate.value = getData(responseModel[0].bookingDate);
    }
  }


  ///*
  ///
  /// get Bookings/getPrescription Api Response to get
  /// list of prescription history
  void getPrescriptionListResponse()async{
    BeneficiaryPrescriptionListRequest requestModel = BeneficiaryPrescriptionListRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.serviceReceiverId = serviceReceiverId.value;

    List<BeneficiaryPrescriptionListResponse>? responseModel = await repository.hitPrescriptionListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      prescriptionList.clear();
      prescriptionList.value = responseModel;
    }else{
      prescriptionList.clear();
    }
  }


  ///*
  ///
  /// check null data
  String getData(String? data) {
    if(data != null){
      return data;
    }else{
      return '';
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


}