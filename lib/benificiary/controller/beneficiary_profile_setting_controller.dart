import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soowgood/benificiary/repository/beneficiary_repository.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_basic_info_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_score_request.dart';
import 'package:soowgood/provider/model/response/provider_basic_info_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_score_response.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class BeneficiaryProfileSettingController extends GetxController{

  BeneficiaryRepository repository = BeneficiaryRepository();
  var profileScore = ''.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode dobFocus = FocusNode();
  FocusNode mobileNoFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode zipCodeFocus = FocusNode();
  FocusNode aboutMeFocus = FocusNode();

  var isFullNameEmpty = false.obs;
  var isUserNameEmpty = false.obs;
  var isDobEmpty = false.obs;
  var isGenderEmpty = false.obs;
  var isBloodGroupEmpty = false.obs;
  var isMobileNoEmpty = false.obs;
  var isMobileNoValid = false.obs;
  var isAddressEmpty = false.obs;
  var isZipCodeEmpty = false.obs;
  var isAboutMeEmpty = false.obs;


  var selectedGender = ''.obs;
  var selectedBloodGroup = ''.obs;

  double latitude = 0.0;
  double longitude = 0.0;

  bool isUpdated = false;

  ///*
  ///
  ///
  void setAllErrorToFalse(){
    isFullNameEmpty.value = false;
    isUserNameEmpty.value = false;
    isDobEmpty.value = false;
    isGenderEmpty.value = false;
    isBloodGroupEmpty.value = false;
    isMobileNoEmpty.value = false;
    isMobileNoValid.value = false;
    isAddressEmpty.value = false;
    isZipCodeEmpty.value = false;
    isAboutMeEmpty.value = false;

  }


  ///*
  ///
  ///
  void clearAllField(){
    fullNameController.clear();
    userNameController.clear();
    dobController.clear();
    selectedGender.value = '';
    selectedBloodGroup.value = '';
    mobileNoController.clear();
    addressController.clear();
    zipCodeController.clear();
    aboutMeController.clear();


  }

  ///*
  ///
  ///
  void isDataValid() {

    if(fullNameController.text.isEmpty){
      setAllErrorToFalse();
      isFullNameEmpty.value = true;

    }else if(userNameController.text.isEmpty){
      setAllErrorToFalse();
      isUserNameEmpty.value = true;

    }else if(dobController.text.isEmpty){
      setAllErrorToFalse();
      isDobEmpty.value = true;

    }else if(selectedGender == ''){
      setAllErrorToFalse();
      isGenderEmpty.value = true;

    }else if(selectedBloodGroup == ''){
      setAllErrorToFalse();
      isBloodGroupEmpty.value = true;

    }else if(mobileNoController.text.isEmpty){
      setAllErrorToFalse();
      isMobileNoEmpty.value = true;

    }else if(addressController.text.isEmpty){
      setAllErrorToFalse();
      isAddressEmpty.value = true;

    }else if(zipCodeController.text.isEmpty){
      setAllErrorToFalse();
      isZipCodeEmpty.value = true;

    }else {
      setAllErrorToFalse();
      getBasicInfoResponse();
    }
  }

  ///*
  ///
  ///
  ///
  void getBasicInfoResponse() async{
    ProviderBasicInfoRequest requestModel = ProviderBasicInfoRequest();
    if (selectedGender.value == "Male") {
      requestModel.gender = "1";
    } else if (selectedGender.value == "Female") {
      requestModel.gender = "2";
    } else if (selectedGender.value == "Other") {
      requestModel.gender = "3";
    }

    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.fullname = fullNameController.text.trim();
    requestModel.username = userNameController.text.trim();
    requestModel.dateofbirth = dobController.text.trim();
    requestModel.bloodgroup = selectedBloodGroup.value;
    requestModel.email = emailController.text.trim();
    requestModel.phonenumber = mobileNoController.text.trim();
    requestModel.currentaddress = addressController.text.trim();
    requestModel.postalCode = zipCodeController.text.trim();
    requestModel.aboutme = aboutMeController.text.trim();
    requestModel.country = '';
    requestModel.state = '';
    requestModel.city = '';
    requestModel.usertype = 'Beneficiary';


    ProviderBasicInfoResponse? responseModel = await repository.hitUpdateBasicInfoApi(requestModel);

    if(responseModel != null){
      if(responseModel.success == '1'){
        MySharedPreference.getInstance();
        MySharedPreference.setString(KeyConstants.keyFullName, fullNameController.text.trim());
        ProviderGlobal.isBeneficiarySettingBack = true;
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) =>
              CustomDialog(
                  my_context: Get.context!,
                  img: successImage,
                  title: "",
                  description: isUpdated? 'Profile Info Updated Successfully': responseModel.message! ,
                  buttonText: 'Ok',
                  okBtnFunction: getProfileResponse
              ),
        );

      }
    }

  }




  ///*
  ///
  /// get Users/getuserdatabyid Api response
  /// to get profile details
  void getProfileResponse() async{

    ProviderProfileRequest requestModel = ProviderProfileRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderProfileResponse>? responseModel = await repository.hitProfileDataApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){

      emailController.text = responseModel[0].email!;
      userNameController.text = responseModel[0].username!;
      fullNameController.text = responseModel[0].fullname!;
      dobController.text = uiFormattedDate(responseModel[0].dob!);
      selectedBloodGroup.value = responseModel[0].bloodgroup!;
      mobileNoController.text = responseModel[0].mobileno!;
      addressController.text = responseModel[0].currentaddress!;
      zipCodeController.text = responseModel[0].postalcode!;
      // aboutMeController.text = responseModel[0].aboutme!;

      if(responseModel[0].gender! == '1'){
        selectedGender.value = 'Male';

      }else if(responseModel[0].gender! == '2'){
        selectedGender.value = 'Female';

      }else if(responseModel[0].gender! == '3'){
        selectedGender.value = 'Other';
      }

      if(fullNameController.text.isNotEmpty){
        isUpdated = true;
      }else{
        isUpdated = false;
      }
      log('AddressResponse : ${addressController.text}');
    }
  }


  ///*
  ///
  ///
  String uiFormattedDate(String date){
    DateFormat formatter = DateFormat('MM-dd-yyyy');
    DateTime _stringdate;
    String formatedDate = "";

    List<String> validadeSplit = date.split('/');

    if(validadeSplit.length > 1)
    {
      int day = int.parse(validadeSplit[1].toString());
      int month = int.parse(validadeSplit[0].toString());
      int year = int.parse(validadeSplit[2].toString());

      _stringdate = DateTime.utc(year, month, day);
      formatedDate = formatter.format(_stringdate);
      print("tempDate :" + formatedDate);

    }

    return formatedDate;
  }


  ///*
  ///
  /// get Users/getUserProfileCompletionStatus Api response
  /// to get profile completion status
  void getProfileScoreResponse() async{

    ProviderProfileScoreRequest requestModel = ProviderProfileScoreRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderProfileScoreResponse>? responseModel = await repository.hitGetProfileScoreApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      profileScore.value = responseModel[0].profileScore!;

      log('ProfileScoreValue : ${profileScore.value}');
    }
  }



}