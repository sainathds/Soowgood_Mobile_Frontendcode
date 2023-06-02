import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/provider/model/request/provider_bill_information_request.dart';
import 'package:soowgood/provider/model/request/provider_billing_history_request.dart';
import 'package:soowgood/provider/model/request/provider_billing_setup_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_billing_setup_request.dart';
import 'package:soowgood/provider/model/request/provider_delete_schedule_request.dart';
import 'package:soowgood/provider/model/request/provider_make_payment_request.dart';
import 'package:soowgood/provider/model/response/provider_bill_information_response.dart';
import 'package:soowgood/provider/model/response/provider_billing_history_response.dart';
import 'package:soowgood/provider/model/response/provider_billing_setup_response.dart';
import 'package:soowgood/provider/model/response/provider_consultancy_type_response.dart';
import 'package:soowgood/provider/model/response/provider_delete_billing_setup_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

import '../model/request/provider_consultancy_type_request.dart';

class ProviderBillingDetailsController extends GetxController{

 ProviderRepository repository = ProviderRepository();
 var selectedMethod = ''.obs;

 var billingHistoryList = <ProviderBillingHistoryResponse>[].obs;

 TextEditingController bankNameController = TextEditingController();
 TextEditingController branchNameController = TextEditingController();
 TextEditingController accountNameController = TextEditingController();
 TextEditingController accountNumberController = TextEditingController();

 var isBankNameEmpty = false.obs;
 var isBranchNameEmpty = false.obs;
 var isAccountNameEmpty = false.obs;
 var isAccountNumberEmpty = false.obs;

 TextEditingController gPayMobileNoController = TextEditingController();
 var isGPayNoEmpty = false.obs;
 var isGPayNoInValid = false.obs;

 TextEditingController emailController = TextEditingController();
 TextEditingController paypalMobileNoController = TextEditingController();
 var isEmailEmpty = false.obs;
 var isPaypalNoEmpty = false.obs;
 var isPayPalNoInValid = false.obs;


 var isBillingSetupInfoShow = false.obs;
 var billingSetupId = ''.obs;

 var isGPayDataInValid = true.obs;
 var isAccountDataInValid = true.obs;
 var isPayPalDataInValid = true.obs;

 var appointmentTypeList = <ProviderConsultancyTypeResponse>[].obs;
 var selectedAppointmentType = ProviderConsultancyTypeResponse().obs;
 var appointmentType = 'All'.obs;

 var paymentStatusList = <String>[].obs;

 var selectedPaymentStatus = 'All'.obs;


 ///*
 ///
 ///
 setAllErrorToFalse(){
  isBankNameEmpty.value = false;
  isBranchNameEmpty.value = false;
  isAccountNameEmpty.value = false;
  isAccountNumberEmpty.value = false;

  isGPayNoEmpty.value = false;
  isGPayNoInValid.value = false;

  isEmailEmpty.value = false;
  isPaypalNoEmpty.value = false;
  isPayPalNoInValid.value = false;

  isAccountDataInValid.value = true;
  isGPayDataInValid.value = true;
  isPayPalDataInValid.value = true;

 }

 ///*
 ///
 ///
  void isBankDataValid() {
     if(bankNameController.text.trim().isEmpty){
      setAllErrorToFalse();
      isBankNameEmpty.value = true;

     }else if(branchNameController.text.trim().isEmpty){
      setAllErrorToFalse();
      isBranchNameEmpty.value = true;

     }else if(accountNameController.text.trim().isEmpty){
      setAllErrorToFalse();
      isAccountNameEmpty.value = true;

     }else if(accountNumberController.text.trim().isEmpty){
      setAllErrorToFalse();
      isAccountNumberEmpty.value = true;

     }else {
      log('ACCOUNT DATA VALID');
      isAccountDataInValid.value = false;
      getBillingSetupResponse();
     }
  }


  ///*
 ///
 ///
  void isGPayDataValid(){
  if(gPayMobileNoController.text.trim().isEmpty){
   setAllErrorToFalse();
   isGPayNoEmpty.value = true;

  }else if(gPayMobileNoController.text.trim().length != 11){
   setAllErrorToFalse();
   isGPayNoInValid.value = true;

  }else{
   isGPayDataInValid.value = false;
   getBillingSetupResponse();
  }

  }


 ///*
 ///
 ///
 void isPayPalDataValid(){

  if(emailController.text.trim().isEmpty){
   setAllErrorToFalse();
   isEmailEmpty.value = true;

  }else if(paypalMobileNoController.text.trim().isEmpty){
   setAllErrorToFalse();
   isPaypalNoEmpty.value = true;

  }else if(paypalMobileNoController.text.trim().length != 11){
   setAllErrorToFalse();
   isPayPalNoInValid.value = true;

  }else{
   isPayPalDataInValid.value = false;
   getBillingSetupResponse();
  }

 }


 ///*
 ///
 ///
 ///  save / update billing details according to billing method types
 ///  using ProviderBillInformation/saveProviderBillInformation Api
 void getBillingSetupResponse() async{
  ProviderBillingSetupRequest requestModel = ProviderBillingSetupRequest();
  requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
  requestModel.accounttype = selectedMethod.value;

  if(selectedMethod.value == 'Bank Account'){
   requestModel.accountname = accountNameController.text.trim();
   requestModel.accountno = accountNumberController.text.trim();
   requestModel.bankname = bankNameController.text.trim();
   requestModel.branchname = branchNameController.text.trim();

  }else if(selectedMethod.value == 'Google Pay'){
   requestModel.accountname = '';
   requestModel.accountno = gPayMobileNoController.text.trim();
   requestModel.bankname = '';
   requestModel.branchname = '';

  }else if(selectedMethod.value == 'Paypal'){
   requestModel.accountname = emailController.text.trim();
   requestModel.accountno = paypalMobileNoController.text.trim();
   requestModel.bankname = '';
   requestModel.branchname = '';
  }


  ProviderBillingSetupResponse? responseModel = await repository.hitBillingSetupApi(requestModel);

  if(responseModel != null){
   getBillInformation();
  }

 }

 ///*
 ///
 /// get ProviderBillInformation/getProviderBillInformation Api Response
 /// to get Billing Details
 void getBillInformation() async {
  ProviderBillInformationRequest requestModel = ProviderBillInformationRequest();
  requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);

  List<ProviderBillInformationResponse>? responseModel = await repository
      .hitGetBillInfoApi(requestModel);

  if (responseModel != null && responseModel.isNotEmpty) {
     billingSetupId.value = responseModel[0].id!;
     isBillingSetupInfoShow.value = true;
     selectedMethod.value = responseModel[0].accounttype!;
     if(responseModel[0].accounttype == 'Bank Account'){
      accountNameController.text = responseModel[0].accountname!;
      accountNumberController.text = responseModel[0].accountno!;
      bankNameController.text = responseModel[0].bankname!;
      branchNameController.text = responseModel[0].branchname!;

     }else if(responseModel[0].accounttype == 'Google Pay'){
      gPayMobileNoController.text = responseModel[0].accountno!;

     }else if(responseModel[0].accounttype == 'Paypal'){
      emailController.text = responseModel[0].accountname!;
      paypalMobileNoController.text = responseModel[0].accountno!;
     }
  }else{
   isBillingSetupInfoShow.value = false;

  }
 }


 ///*
 ///
 /// Delete billing detail using ProviderBillInformation/deleteProviderBillInformation Api
 void deleteBillingSetup() async{
  ProviderDeleteBillingSetupRequest requestModel = ProviderDeleteBillingSetupRequest();
  requestModel.id = billingSetupId.value;


  ProviderDeleteBillingSetupResponse? responseModel = await repository.hitDeleteBillingSetupApi(requestModel);

  if(responseModel != null) {
   if (responseModel.isDeleted! && !responseModel.isActive!) {
    isBillingSetupInfoShow.value = false;

    if(selectedMethod.value == 'Bank Account'){
     clearBankAccData();
    }else if(selectedMethod.value == 'Google Pay'){
     clearGPayData();
    }else {
     clearPaypalData();
    }
   }else{
    isBillingSetupInfoShow.value = true;
   }
  }else{
   isBillingSetupInfoShow.value = true;

  }
 }

 ///*
 ///
 ///
 clearAll(){
  clearBankAccData();
  clearGPayData();
  clearPaypalData();
 }

 ///*
 ///
 ///
  void clearBankAccData() {

    selectedMethod.value = '';
    accountNameController.clear();
    accountNumberController.clear();
    bankNameController.clear();
    branchNameController.clear();
  }


 ///*
 ///
 ///
 void clearGPayData() {
  selectedMethod.value = '';
  gPayMobileNoController.clear();
 }


 ///*
 ///
 ///
 void clearPaypalData() {
  selectedMethod.value = '';
  emailController.clear();
  paypalMobileNoController.clear();
 }


 ///*
 ///
 /// get  Bookings/getProviderBookingBillDetails Api Response
 /// to get Billing history of all patients
 void getBillingHistoryResponse() async{

  ProviderBillingHistoryRequest requestModel = ProviderBillingHistoryRequest();
  requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);
  requestModel.appointmentTypeName = appointmentType.value;
  requestModel.paybackstatus = selectedPaymentStatus.value;

  List<ProviderBillingHistoryResponse>? responseModel = await repository.hitBillingHistoryApi(requestModel);

  if(responseModel != null && responseModel.isNotEmpty){
   billingHistoryList.clear();
   billingHistoryList.value = responseModel;
  }else{
   billingHistoryList.clear();
  }
 }

 ///*
 ///
 ///  get AppointmentTypes/AppointmentType Api response
 ///  to get provider consultancy types
 void getAppointmentTypeResponse() async{

  ProviderConsultancyTypeRequest requestModel = ProviderConsultancyTypeRequest();
  requestModel.id =   MySharedPreference.getString(KeyConstants.keyUserId);

  List<ProviderConsultancyTypeResponse>? responseModel = await repository.hitConsultancyTypeApi(requestModel);

  if(responseModel != null && responseModel.isNotEmpty){
   appointmentTypeList.value = responseModel;
   ProviderConsultancyTypeResponse data = ProviderConsultancyTypeResponse();
   data.name = 'All';
   appointmentTypeList.insert(0,data);
   selectedAppointmentType.value = appointmentTypeList[0];
  }else{
   appointmentTypeList.clear();
   ProviderConsultancyTypeResponse data = ProviderConsultancyTypeResponse();
   data.name = 'All';
   appointmentTypeList.insert(0,data);
   selectedAppointmentType.value = appointmentTypeList[0];
  }

  getPaymentStatusList();

 }

 ///*
 ///
 /// bind custom payment status
  void getPaymentStatusList() {
  paymentStatusList.add('All');
  paymentStatusList.add('Requested');
  paymentStatusList.add('Completed');
  selectedPaymentStatus.value = paymentStatusList[0];
 }


 ///*
 ///
 /// use Bookings/makeRequestForPayBack Api
 /// if payment not done then Request for Payment
  void requestForPayment(String bookingId) async {
   ProviderMakePaymentRequest requestModel = ProviderMakePaymentRequest();
   requestModel.id = bookingId;

   var response = await repository.hitMakePaymentRequestApi(requestModel);

   if(response != null && response.id != null && response.id != ''){
    getBillingHistoryResponse();
   }
  }


}