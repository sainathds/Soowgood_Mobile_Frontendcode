import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_add_clinic_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_clinic_request.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderAddEditClinicController extends GetxController{

  ProviderRepository repository = ProviderRepository();

  TextEditingController clinicNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();


  XFile? imageFile1;
  XFile? imageFile2;
  XFile? imageFile3;


  var compressedImage1 = ''.obs;
  var compressedImage2 = ''.obs;
  var compressedImage3 = ''.obs;


  var isClinicNameEmpty = false.obs;
  var isAddressEmpty = false.obs;
  var isCityNameEmpty = false.obs;
  var isCountryEmpty = false.obs;
  var isZipCodeEmpty = false.obs;
  var isStateEmpty = false.obs;

  var isLoadImg1 = false.obs;
  var isLoadImg2 = false.obs;
  var isLoadImg3 = false.obs;


  var imageUrl1 = ''.obs;
  var imageUrl2 = ''.obs;
  var imageUrl3 = ''.obs;

  String clinicId = '';
  String callFrom = '';

  bool isBack = false;

  ///*
  ///
  /// check validations for required field
  void isDataValid(){

    if(clinicNameController.text.isEmpty){
      setAllErrorToFalse();
      isClinicNameEmpty.value = true;

    }else if(addressController.text.isEmpty){
      setAllErrorToFalse();
      isAddressEmpty.value = true;

    }else if(cityController.text.isEmpty){
      setAllErrorToFalse();
      isCityNameEmpty.value = true;

    /*}else if(stateController.text.isEmpty){
      setAllErrorToFalse();
      isStateEmpty.value = true;
*/
    }else if(zipCodeController.text.isEmpty){
      setAllErrorToFalse();
      isZipCodeEmpty.value = true;

    }else if(countryController.text.isEmpty){
      setAllErrorToFalse();
      isCountryEmpty.value = true;

    }else {
      setAllErrorToFalse();
      if(callFrom == 'Add'){
        getAddClinicResponse();
      }else{
        getEditClinicResponse();
      }
    }
  }

  ///*
  ///
  ///
  void setAllErrorToFalse(){
    isClinicNameEmpty.value = false;
    isAddressEmpty.value = false;
    isCityNameEmpty.value = false;
    isCountryEmpty.value = false;
    isZipCodeEmpty.value = false;
    isStateEmpty.value = false;

  }


  ///*
  ///
  /// use Clinics/saveClinicInformation Api to save Clinic Data
  void getAddClinicResponse() async{
    ProviderAddClinicRequest requestModel = ProviderAddClinicRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.name = clinicNameController.text.trim();
    requestModel.currentAddress = addressController.text.trim();
    requestModel.city = cityController.text.trim();
    requestModel.postalCode = zipCodeController.text.trim();
    requestModel.state = '';
    requestModel.country = countryController.text.trim();

    if(compressedImage1.value != ''){
      requestModel.file1 = compressedImage1.value;
    }else{
      requestModel.file1 = "";
    }

    if(compressedImage2.value != ''){
      requestModel.file2 = compressedImage2.value;
    }else{
      requestModel.file2 = "";
    }

    if(compressedImage3.value != ''){
      requestModel.file3 = compressedImage3.value;
    }else{
      requestModel.file3 = "";
    }


    bool isAdded = await repository.hitAddClinicApi(requestModel);

    if(isAdded){
      isBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Clinic Details Added Successfully',
                buttonText: 'Ok',
                okBtnFunction: clearAll
            ),
      );

    }
  }


  ///*
  ///
  /// use Clinics/updateClinicInformation Api to Update Clinic Data
  void getEditClinicResponse() async{
    ProviderEditClinicRequest requestModel = ProviderEditClinicRequest();
    requestModel.id = clinicId;
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.name = clinicNameController.text.trim();
    requestModel.currentAddress = addressController.text.trim();
    requestModel.city = cityController.text.trim();
    requestModel.postalCode = zipCodeController.text.trim();
    requestModel.state = '';
    requestModel.country = countryController.text.trim();

    if(compressedImage1.value != ''){
      requestModel.file1 = compressedImage1.value;
      requestModel.isImageURLOptionalOne = '1';
    }else{
      requestModel.file1 = "";
      requestModel.isImageURLOptionalOne = '0';
    }

    if(compressedImage2.value != ''){
      requestModel.file2 = compressedImage2.value;
      requestModel.isImageURLOptionalTwo = '1';
    }else{
      requestModel.file2 = "";
      requestModel.isImageURLOptionalTwo = '0';
    }

    if(compressedImage3.value != ''){
      requestModel.file3 = compressedImage3.value;
      requestModel.isImageURLOptionalThree = '1';
    }else{
      requestModel.file3 = "";
      requestModel.isImageURLOptionalThree = '0';
    }



    bool isAdded = await repository.hitEditClinicApi(requestModel);

    if(isAdded){
      isBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Clinic Details Updated Successfully',
                buttonText: 'Ok',
                okBtnFunction: dismiss
            ),
      );
    }
  }

  ///*
  ///
  ///
  clearAll() {
    clinicNameController.clear();
    addressController.clear();
    cityController.clear();
    countryController.clear();
    zipCodeController.clear();
    stateController.clear();

    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;

    isLoadImg1.value = false;
    isLoadImg2.value = false;
    isLoadImg3.value = false;

    imageUrl1.value = '';
    imageUrl2.value = '';
    imageUrl3.value = '';

  }

  ///*
  ///
  ///
  dismiss() {
  }
}