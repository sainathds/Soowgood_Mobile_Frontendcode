import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_profile_request.dart';
import 'package:soowgood/provider/model/request/upload_profile_pic_request.dart';
import 'package:soowgood/provider/model/response/provider_profile_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

import '../../common/model/response/verify_user_response.dart';
import '../../common/screen/login_screen.dart';

class ProviderProfileController extends GetxController {
  ProviderRepository providerRepository = ProviderRepository();

  var isLoad = false.obs;

  var imgFolderName = ''.obs;
  var profileImageName = ''.obs;
  var profileImageUrl = ''.obs;
  var userName = ''.obs;
  var email = ''.obs;
  XFile? imageFile;
  var compressedImage = ''.obs;

  var isSwitchToProvider = false.obs;

  List<ProviderProfileResponse> profileData = <ProviderProfileResponse>[];

  ///*
  ///
  /// get Users/getuserdatabyid Api Response to get
  /// profile data
  void getProfileResponse() async {
    ProviderProfileRequest requestModel = ProviderProfileRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderProfileResponse>? responseModel =
        await providerRepository.hitProfileDataApi(requestModel);

    if (responseModel != null && responseModel.isNotEmpty) {
      profileData = responseModel;
      userName.value = getData(profileData[0].fullname);
      email.value = getData(profileData[0].email);
      imgFolderName.value = getData(profileData[0].foldername);
      profileImageName.value = getData(profileData[0].profilephoto);
      compressedImage.value = '';

      log('PROFILE_IMAGE_NAME --- ${profileImageName.value}');

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
  /// use to delete Account using Users/deleteuserprofiledata Api
  void deleteAccountResponse() async {
    ProviderProfileRequest requestModel = ProviderProfileRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    List<VerifyUserResponse>? responseModel =
        await providerRepository.hitDeleteAccountApi(requestModel);

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
              await preferences
                  .clear(); // clear all session data from sharedPref
              Get.offAll(const LoginScreen());
            }),
      );
    }
  }

  ///*
  ///
  /// use to upload profile pic using  Users/ProfilePicture Api
  void uploadProfilePic() async {
    UploadProfilePicRequest requestModel = UploadProfilePicRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);
    if (compressedImage.value != '') {
      requestModel.file = compressedImage.value;
    } else {
      requestModel.file = "";
    }

    bool isUploadedSuccessfully =
        await providerRepository.hitUploadProfilePicApi(requestModel);

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
  /// check null data
  String getData(String? data) {
    if (data == null) {
      return '';
    } else {
      return data;
    }
  }
}
