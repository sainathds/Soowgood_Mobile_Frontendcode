import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soowgood/benificiary/repository/beneficiary_repository.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/model/response/verify_user_response.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/screen/login_screen.dart';
import 'package:soowgood/provider/model/request/provider_profile_request.dart';
import 'package:soowgood/provider/model/request/upload_profile_pic_request.dart';
import 'package:soowgood/provider/model/response/provider_profile_response.dart';

class BeneficiaryProfileController extends GetxController {
  BeneficiaryRepository repository = BeneficiaryRepository();

  var profileImageName = ''.obs;
  var profileImageUrl = ''.obs;
  var userName = ''.obs;
  var email = ''.obs;
  var isLoad = false.obs;
  XFile? imageFile;
  var compressedImage = ''.obs;

  List<ProviderProfileResponse> profileData = <ProviderProfileResponse>[];

  var isSwitchToBeneficial = false.obs;

  ///*
  ///
  /// get Users/getuserdatabyid Api response
  /// to get beneficiary ProfileData
  void getProfileResponse() async {
    ProviderProfileRequest requestModel = ProviderProfileRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderProfileResponse>? responseModel =
        await repository.hitProfileDataApi(requestModel);

    if (responseModel != null && responseModel.isNotEmpty) {
      profileData = responseModel;
      userName.value = getData(profileData[0].fullname);
      email.value = getData(profileData[0].email);
      if (profileData[0].profilephoto != null) {
        profileImageName.value = profileData[0].profilephoto!;
      }

      compressedImage.value = '';
      if (profileImageName.value != "") {
        imageFile = null;
        isLoad.value = false;
        profileImageUrl.value = ApiConstant.fileBaseUrl +
            ApiConstant.profilePicFolder +
            profileImageName.value;
        log('ProfileImageUrl : ${profileImageUrl.value}');
      }

      log('UserName : ${userName.value}');
    }
  }

  ///*
  ///
  ///
  void deleteAccountResponse() async {
    ProviderProfileRequest requestModel = ProviderProfileRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<VerifyUserResponse>? responseModel =
        await repository.hitDeleteAccountApi(requestModel);

    if (responseModel != null) {
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (BuildContext context1) => CustomDialog(
            my_context: Get.context!,
            img: successImage,
            title: "",
            description: 'Account Deleted Successfully',
            buttonText: 'Ok',
            okBtnFunction: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();
              Get.offAll(const LoginScreen());
            }),
      );
    }
  }

  ///*
  ///
  ///
  void uploadProfilePic() async {
    UploadProfilePicRequest requestModel = UploadProfilePicRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);
    if (compressedImage.value != '') {
      requestModel.file = compressedImage.value;
    } else {
      requestModel.file = "";
    }

    bool isUploadedSuccessfully =
        await repository.hitUploadProfilePicApi(requestModel);

    if (isUploadedSuccessfully) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => CustomDialog(
            my_context: Get.context!,
            img: successImage,
            title: "",
            description: "Profile Picture Updated Successfully",
            buttonText: 'Ok',
            okBtnFunction: getProfileResponse),
      );
    }
  }

  ///
  ///
  ///
  String getData(String? data) {
    if (data == null) {
      return '';
    } else {
      return data;
    }
  }
}
