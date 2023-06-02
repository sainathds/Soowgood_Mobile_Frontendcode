import 'dart:convert';

import 'package:soowgood/common/model/request/confirm_verification_request.dart';
import 'package:soowgood/common/model/request/fcm_data_request.dart';
import 'package:soowgood/common/model/request/forgot_password_request.dart';
import 'package:soowgood/common/model/request/login_request.dart';
import 'package:soowgood/common/model/request/set_changed_password_request.dart';
import 'package:soowgood/common/model/request/verify_user_request.dart';
import 'package:soowgood/common/model/response/confirm_verification_response.dart';
import 'package:soowgood/common/model/response/fcm_data_response.dart';
import 'package:soowgood/common/model/response/forgot_password_response.dart';
import 'package:soowgood/common/model/response/login_response.dart';
import 'package:soowgood/common/model/response/set_changed_password_response.dart';
import 'package:soowgood/common/model/response/verify_user_response.dart';
import 'package:soowgood/common/network/api_client.dart';
import 'package:soowgood/common/network/api_constant.dart';

class CommonRepository{


  ApiClient apiClient = ApiClient() ;


  ///*
  ///
  /// call Users/verifyuser Api to get otp on email for both beneficiary and provider
  Future<VerifyUserResponse?> hitVerifyUserApi(VerifyUserRequest requestModel) async{
    VerifyUserResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.verifyUserApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = VerifyUserResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  /// call Users/confirmverification Api confirm verification i.e otp is valid or not
  Future<ConfirmVerificationResponse?> hitConfirmVerificationApi(ConfirmVerificationRequest requestModel) async{
    ConfirmVerificationResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.confirmVerificationApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ConfirmVerificationResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  /// call Users/changePassword Api to set password
  Future<SetChangedPasswordResponse?> hitSetChangedPasswordApi(SetChangedPasswordRequest requestModel) async{
    SetChangedPasswordResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.setChangedPasswordApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = SetChangedPasswordResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  /// call Users/login Api to login into application for both beneficiary and provider
  Future<LoginResponse?> hitLoginApi(LoginRequest requestModel) async{
    LoginResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.loginApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = LoginResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  /// verify user while signup
  Future<ForgotPasswordResponse?> hitForgotPasswordApi(ForgotPasswordRequest requestModel) async{
    ForgotPasswordResponse? responseModel ;

    final results = await apiClient.requestPost(
        url: ApiConstant.forgotPasswordApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = ForgotPasswordResponse.fromJson(results);
    }
    return responseModel;

  }


  ///*
  ///
  ///call Users/AddUpdateDeviceInformation Api to save fcm token against particular user for both beneficiary and provider
  Future<FcmDataResponse?> hitFcmDataApi(FcmDataRequest requestModel) async{
    FcmDataResponse? responseModel;

    final results = await apiClient.requestPostCreate(
        url: ApiConstant.saveUpdateFcmDataApi,
        parameters: json.encode(requestModel));

    if(results != null){
      responseModel = FcmDataResponse.fromJson(results);
    }
    return responseModel;
  }




}