import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:soowgood/benificiary/model/request/add_edit_booking_doc_request.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_drug_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_add_edit_booking_responset.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_cancel_appointment_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_data_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_providers_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_search_providers_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_specialization_response.dart';
import 'package:soowgood/benificiary/model/response/booking_summary_response.dart';
import 'package:soowgood/benificiary/model/response/appointment_list_response.dart';
import 'package:soowgood/benificiary/model/response/cancel_appointment_by_patient_response.dart';
import 'package:soowgood/benificiary/model/response/check_appointment_cancel_response.dart';
import 'package:soowgood/benificiary/model/response/update_patient_data_response.dart';
import 'package:soowgood/common/model/response/notification_list_response.dart';
import 'package:soowgood/common/model/response/read_all_notification_response.dart';
import 'package:soowgood/common/model/response/verify_user_response.dart';
import 'package:soowgood/provider/model/request/provider_add_clinic_request.dart';
import 'package:soowgood/provider/model/request/provider_add_document_request.dart';
import 'package:soowgood/provider/model/request/provider_add_edit_prescription_request.dart';
import 'package:soowgood/provider/model/request/provider_clinic_list_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_clinic_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_document_request.dart';
import 'package:soowgood/provider/model/request/provider_experience_list_request.dart';
import 'package:soowgood/provider/model/request/upload_profile_pic_request.dart';
import 'package:soowgood/provider/model/response/provider_appointment_list_response.dart';
import 'package:soowgood/provider/model/response/provider_bill_information_response.dart';
import 'package:soowgood/provider/model/response/provider_billing_history_response.dart';
import 'package:soowgood/provider/model/response/provider_cancel_appointment_response.dart';
import 'package:soowgood/provider/model/response/provider_dashboard_appointments_response.dart';
import 'package:soowgood/provider/model/response/provider_award_list_response.dart';
import 'package:soowgood/provider/model/response/provider_category_type_response.dart';
import 'package:soowgood/provider/model/response/provider_clinic_list_response.dart';
import 'package:soowgood/provider/model/response/provider_consultancy_type_response.dart';
import 'package:soowgood/provider/model/response/provider_document_list_response.dart';
import 'package:soowgood/provider/model/response/provider_edit_specialization_response.dart';
import 'package:soowgood/provider/model/response/provider_education_list_response.dart';
import 'package:soowgood/provider/model/response/provider_experience_list_response.dart';
import 'package:soowgood/provider/model/response/provider_patient_list_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_completion_count_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_score_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_details_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_list_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_type_response.dart';
import 'package:soowgood/provider/model/response/provider_specialization_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_medical_test_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_advice_list_response.dart';
import 'package:soowgood/provider/model/response/provider_visited_doctor_response.dart';
import 'package:soowgood/provider/model/response/get_patient_document_history_response.dart';
import 'package:soowgood/provider/model/response/provider_add_edit_prescription_response.dart';




import '../../benificiary/model/response/ratings_list_response.dart';
import '../../provider/model/response/provider_profile_response.dart';
import '../dialog/custom_progress_dialog.dart';
import '../dialog/ok_dialog.dart';
import '../local_database/my_shared_preference.dart';
import '../resources/my_assets.dart';
import '../resources/my_colors.dart';
import '../resources/my_string.dart';
import '../utils/my_internet_connection.dart';



class ApiClient{

  ///*
  ///
  ///
  Future<Map?> requestGet({required String url}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.get(uri,
            headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          final jsonObject = json.decode(results.body);
          log("Response : $jsonObject");
          return jsonObject;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }

  ///*
  ///
  ///
  Future<Map?> requestPost({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          final jsonObject = json.decode(results.body);
          log("Response : $jsonObject");
          return jsonObject;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<Map?> requestPostCreate({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 201) {
          progressDialog.close();
          final jsonObject = json.decode(results.body);
          log("Response : $jsonObject");
          return jsonObject;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }
  

  ///*
  ///
  ///
  Future<List<VerifyUserResponse>?> requestDeleteAccount({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          List<VerifyUserResponse> jsonObject = VerifyUserResponseFromJson(results.body);
          log("Response : $jsonObject");
          return jsonObject;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }

  ///*
  ///
  ///
  Future<List<ProviderProfileResponse>?> requestProviderProfile({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderProfileResponse> jsonList =
          ProviderProfileResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }

  ///*
  ///
  ///
  Future<List<dynamic>?> requestGetRating({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          final jsonList = jsonDecode(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }

  ///*
  ///
  ///
  Future<List<getRatingDataListResponse>?> requestGetRatingList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      // try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          List<getRatingDataListResponse> jsonList =
          getRatingDataListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      // }catch(exception){
      //   log("Request API Exception: $exception.toString()");
      //   progressDialog.close();
      //   showDialog(
      //     context: Get.context!,
      //     builder: (BuildContext context1) => OKDialog(
      //       title: "",
      //       descriptions: MyString.errorMessage,
      //       img: errorImage,
      //     ),
      //   );
      //   return null;
      //
      // }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }



  ///*
  ///
  ///
  Future<StreamedResponse> requestUploadProfilePic({required String url, required UploadProfilePicRequest requestModel}) async{
    MySharedPreference.getInstance();

    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if(flagNet){
      try{
        var headers = {
          "Content-Type": "multipart/form-data",
        };

        final data = {
          'Id': requestModel.id,
        };

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request = jsonToFormData(request, data);

        if(requestModel.file != ""){
          log("ProfilePicFile : ${requestModel.file!}");
          request.files.add(await http.MultipartFile.fromPath('File', requestModel.file!));
        }
        request.headers.addAll(headers);

        log("CustomServiceRequest :" + request.fields.toString());
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          progressDialog.close();
          return response;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          throw '';
        }
      }catch(exception){
        log("Request API Exception:  ${exception.toString()}");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        throw '';

      }

    }else{
      progressDialog.close();
      log("Request API : No Net ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      throw '';
    }
  }

  ///*
  ///
  ///
  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }




  ///*
  ///
  ///
  Future<List<ProviderProfileScoreResponse>?> requestProviderProfileScore({required String url, required String parameters}) async {
    // CustomProgressDialog progressDialog = CustomProgressDialog();

    // progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          // progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderProfileScoreResponse> jsonList =
          ProviderProfileScoreResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          // progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        //progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      // progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderEducationListResponse>?> requestProviderEducationList({required String url, required String parameters}) async {
    // CustomProgressDialog progressDialog = CustomProgressDialog();

    // progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          // progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderEducationListResponse> jsonList =
          ProviderEducationListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          // progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        // progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      // progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderExperienceListResponse>?> requestProviderExperienceList({required String url, required String parameters}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderExperienceListResponse> jsonList =
          ProviderExperienceListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderAwardListResponse>?> requestProviderAwardList({required String url, required String parameters}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderAwardListResponse> jsonList =
          ProviderAwardListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderCategoryTypeResponse>?> requestCategoryTypeList({required String url, required String parameters}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderCategoryTypeResponse> jsonList =
          ProviderCategoryTypeResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }



  ///*
  ///
  ///
  Future<List<String>?> requestStringList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<String> jsonList = getStringFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderSpecializationListResponse>?> requestProviderSpecializationList({required String url, required String parameters}) async{
    // CustomProgressDialog progressDialog = CustomProgressDialog();

    // progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          // progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderSpecializationListResponse> jsonList =
          ProviderSpecializationListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          // progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        // progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      // progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<StreamedResponse> requestUploadDocumentFormData({required String url, required ProviderAddDocumentRequest requestModel}) async{
    MySharedPreference.getInstance();

    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if(flagNet){
      try{
        var headers = {
          "Content-Type": "multipart/form-data",
        };

        final data = {
          'UserId': requestModel.userId,
          'documentname': requestModel.documentname,
          'filetype': requestModel.filetype

        };

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request = jsonToFormData(request, data);

        if(requestModel.file != ""){
          log("UploadDocumentFile : ${requestModel.file!}");
          request.files.add(await http.MultipartFile.fromPath('File', requestModel.file!));
        }
        request.headers.addAll(headers);

        log("ProviderUploadDocumentRequest :${request.fields}");
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          progressDialog.close();
          return response;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          throw '';
        }
      }catch(exception){
        log("Request API Exception:  ${exception.toString()}");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        throw '';

      }

    }else{
      progressDialog.close();
      log("Request API : No Net ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      throw '';
    }
  }

  ///*
  ///
  ///
  Future<StreamedResponse> requestUpdateDocumentFormData({required String url, required ProviderEditDocumentRequest requestModel}) async{
    MySharedPreference.getInstance();

    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if(flagNet){
      try{
        var headers = {
          "Content-Type": "multipart/form-data",
        };

        final data = {
          'Id': requestModel.id,
          'UserId': requestModel.userId,
          'documentname': requestModel.documentname,
          'filetype': requestModel.filetype,
          'documentfilename': requestModel.documentfilename

        };

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request = jsonToFormData(request, data);

        if(requestModel.file != null && requestModel.file != ""){
          log("EditDocumentFile : ${requestModel.file!}");
          request.files.add(await http.MultipartFile.fromPath('File', requestModel.file!));
        }
        request.headers.addAll(headers);

        log("ProviderEditDocumentRequest :${request.fields}");
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 201) {
          progressDialog.close();
          return response;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          throw '';
        }
      }catch(exception){
        log("Request API Exception:  ${exception.toString()}");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        throw '';

      }

    }else{
      progressDialog.close();
      log("Request API : No Net ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      throw '';
    }
  }


  ///*
  ///
  ///
  Future<List<ProviderDocumentListResponse>?> requestProviderDocumentList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderDocumentListResponse> jsonList =
          ProviderDocumentListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderClinicListResponse>?> requestProviderClinicList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderClinicListResponse> jsonList =
          ProviderClinicListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }

  ///*
  ///
  ///
  Future<List<ProviderScheduleTypeResponse>?> requestScheduleTypeList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderScheduleTypeResponse> jsonList =
          ProviderScheduleTypeResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderConsultancyTypeResponse>?> requestConsultancyTypeList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderConsultancyTypeResponse> jsonList =
          ProviderConsultancyTypeResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<StreamedResponse> requestAddClinicFormData({required String url, required ProviderAddClinicRequest requestModel}) async{
    MySharedPreference.getInstance();

    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if(flagNet){
      try{
        var headers = {
          "Content-Type": "multipart/form-data",
        };

        final data = {
          'UserId': requestModel.userId,
          'Name': requestModel.name,
          'CurrentAddress': requestModel.currentAddress,
          'City':requestModel.city,
          'PostalCode':requestModel.postalCode,
          'State':requestModel.state,
          'Country':requestModel.country,
        };

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request = jsonToFormData(request, data);

        if(requestModel.file1 != ""){
          log("ClinicFile-1 : ${requestModel.file1!}");
          request.files.add(await http.MultipartFile.fromPath('File1', requestModel.file1!));
        }

        if(requestModel.file2 != ""){
          log("ClinicFile-2 : ${requestModel.file2!}");
          request.files.add(await http.MultipartFile.fromPath('File2', requestModel.file2!));
        }

        if(requestModel.file3 != ""){
          log("ClinicFile-3 : ${requestModel.file3!}");
          request.files.add(await http.MultipartFile.fromPath('File3', requestModel.file3!));
        }


        request.headers.addAll(headers);

        log("AddClinicRequest :${request.fields}");
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          progressDialog.close();
          return response;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          throw '';
        }
      }catch(exception){
        log("Request API Exception:  ${exception.toString()}");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        throw '';

      }

    }else{
      progressDialog.close();
      log("Request API : No Net ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      throw '';
    }
  }

  ///*
  ///
  ///
  Future<StreamedResponse> requestEditClinicFormData({required String url, required ProviderEditClinicRequest requestModel}) async{
    MySharedPreference.getInstance();

    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if(flagNet){
      try{
        var headers = {
          "Content-Type": "multipart/form-data",
        };

        final data = {
          'Id':requestModel.id,
          'UserId': requestModel.userId,
          'Name': requestModel.name,
          'CurrentAddress': requestModel.currentAddress,
          'City':requestModel.city,
          'PostalCode':requestModel.postalCode,
          'State':requestModel.state,
          'Country':requestModel.country,
          'IsImageURLOptionalOne':requestModel.isImageURLOptionalOne,
          'IsImageURLOptionalTwo':requestModel.isImageURLOptionalTwo,
          'IsImageURLOptionalThree':requestModel.isImageURLOptionalThree
        };

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request = jsonToFormData(request, data);

        if(requestModel.file1 != ""){
          log("ClinicFile-1 : ${requestModel.file1!}");
          request.files.add(await http.MultipartFile.fromPath('File1', requestModel.file1!));
        }

        if(requestModel.file2 != ""){
          log("ClinicFile-2 : ${requestModel.file2!}");
          request.files.add(await http.MultipartFile.fromPath('File2', requestModel.file2!));
        }

        if(requestModel.file3 != ""){
          log("ClinicFile-3 : ${requestModel.file3!}");
          request.files.add(await http.MultipartFile.fromPath('File3', requestModel.file3!));
        }


        request.headers.addAll(headers);

        log("AddClinicRequest :${request.fields}");
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          progressDialog.close();
          return response;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          throw '';
        }
      }catch(exception){
        log("Request API Exception:  ${exception.toString()}");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        throw '';

      }

    }else{
      progressDialog.close();
      log("Request API : No Net ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      throw '';
    }
  }

  ///*
  ///
  ///
  List<String> getStringFromJsonList(dynamic str) {
    return List<String>.from(json.decode(str).map((x) => x));
  }


  ///*
  ///
  ///
  Future<List<ProviderScheduleListResponse>?> requestProviderScheduleList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderScheduleListResponse> jsonList =
          ProviderScheduleListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderScheduleDetailResponse>?> requestScheduleDetail({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderScheduleDetailResponse> jsonList =
          ProviderScheduleDetailResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryProvidersResponse>?> requestBeneficiaryProvidersList({required String url, required String parameters}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BeneficiaryProvidersResponse> jsonList =
          BeneficiaryProvidersResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<BeneficiarySpecializationResponse>?> requestBeneficiarySpecializationList({required String url}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BeneficiarySpecializationResponse> jsonList =
          BeneficiarySpecializationResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<BeneficiarySearchProvidersResponse>?> requestSearchProvidersList({required String url, required String parameters}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters,
            headers: {"Content-Type": "application/json"});


        log('RequestSearchProvider : ${parameters.toString()}');

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BeneficiarySearchProvidersResponse> jsonList =
          BeneficiarySearchProvidersResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }

  ///*
  ///
  ///
  Future<List<BeneficiaryAddEditBookingResponse>?> requestAddEditBooking({required String url, required String parameters}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BeneficiaryAddEditBookingResponse> jsonList =
          BeneficiaryAddEditBookingResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }

  ///*
  ///
  ///
  Future<StreamedResponse> requestUploadPrescriptionFormData({required String url, required AddEditBookingDocRequest requestModel}) async{
    MySharedPreference.getInstance();

    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if(flagNet){
      try{
        var headers = {
          "Content-Type": "multipart/form-data",
        };

        final data = {
          'bookingId': requestModel.bookingId,
          'filetype': requestModel.filetype
        };

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request = jsonToFormData(request, data);

        if(requestModel.file != ""){
          log("UploadPrescriptionFile : ${requestModel.file!}");
          request.files.add(await http.MultipartFile.fromPath('File', requestModel.file!));
        }
        request.headers.addAll(headers);

        log("UploadPrescriptionRequest :${request.fields}");
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          progressDialog.close();
          return response;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          throw '';
        }
      }catch(exception){
        log("Request API Exception:  ${exception.toString()}");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        throw '';

      }

    }else{
      progressDialog.close();
      log("Request API : No Net ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      throw '';
    }
  }



  ///*
  ///
  ///
  Future<List<UpdatePatientDataResponse>?> requestUpdatePatientData({required String url, required String parameters}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<UpdatePatientDataResponse> jsonList =
          UpdatePatientDataResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }

  ///*
  ///
  ///
  Future<List<BookingSummaryResponse>?> requestBookingSummaryApi({required String url, required String parameters}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BookingSummaryResponse> jsonList =
          BookingSummaryResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<int?> requestIntData({required String url, required String parameters}) async {
    // CustomProgressDialog progressDialog = CustomProgressDialog();

    // progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          // progressDialog.close();
          final jsonObject = json.decode(results.body);
          log("Response : $jsonObject");
          return jsonObject;

        } else{
          // progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        // progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      // progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }

  ///*
  ///
  ///
  Future<String?> requestStringData({required String url, required String parameters}) async {
    // CustomProgressDialog progressDialog = CustomProgressDialog();

    // progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          // progressDialog.close();
          final jsonObject = json.decode(results.body).toString();
          log("Response : $jsonObject");
          return jsonObject;

        } else{
          // progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        // progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      // progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<AppointmentListResponse>?> requestAppointmentListApi({required String url, required String parameters}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<AppointmentListResponse> jsonList =
          AppointmentListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<CancelAppointmentByPatientResponse>?> requestCancelAppointmentApi({required String url, required String parameters}) async{
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<CancelAppointmentByPatientResponse> jsonList =
          CancelAppointmentByPatientResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
    Future<List<ProviderDashboardAppointmentsResponse>?> requestProviderAppointments({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderDashboardAppointmentsResponse> jsonList =
          ProviderAppointmentsResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }



  ///*
  ///
  ///
  Future<List<ProviderAppointmentListResponse>?> requestAppointmentList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderAppointmentListResponse> jsonList =
          ProviderAppointmentListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderProfileCompletionCountResponse>?> requestProfileCompletionCount({required String url, required String parameters}) async {
    // CustomProgressDialog progressDialog = CustomProgressDialog();

    // progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          // progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderProfileCompletionCountResponse> jsonList =
          ProviderProfileCompletionCountResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          // progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        // progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      // progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<CheckAppointmentCancelResponse>?> requestCheckAppointmentCancel({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<CheckAppointmentCancelResponse> jsonList =
          CheckAppointmentCancelResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryCancelAppointmentResponse>?> requestBeneficiaryAppointmentCancel({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BeneficiaryCancelAppointmentResponse> jsonList =
          BeneficiaryCancelAppointmentResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderCancelAppointmentResponse>?> requestProviderAppointmentCancel({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderCancelAppointmentResponse> jsonList =
          ProviderCancelAppointmentResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }
  }


  ///*
  ///
  ///
  Future<List<BeneficiaryPrescriptionListResponse>?> requestBeneficiaryPrescriptionList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BeneficiaryPrescriptionListResponse> jsonList =
          BeneficiaryPrescriptionListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryDrugListResponse>?> requestBeneficiaryDrugList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BeneficiaryDrugListResponse> jsonList =
          BeneficiaryDrugListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryMedicalTestResponse>?> requestBeneficiaryMedicalList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BeneficiaryMedicalTestResponse> jsonList =
          BeneficiaryMedicalTestResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryAdviceListResponse>?> requestBeneficiaryAdviceList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BeneficiaryAdviceListResponse> jsonList =
          BeneficiaryAdviceListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<BeneficiaryPrescriptionDataResponse>?> requestBeneficiaryPrescriptionData({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<BeneficiaryPrescriptionDataResponse> jsonList =
          BeneficiaryPrescriptionDataResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderVisitedDoctorListResponse>?> requestProviderVisitedDoctor({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderVisitedDoctorListResponse> jsonList =
          ProviderVisitedDoctorListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }



  ///*
  ///
  ///
  Future<List<GetPatientDocumentHistoryResponse>?> requestPatientDocumentHistory({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<GetPatientDocumentHistoryResponse> jsonList =
          GetPatientDocumentHistoryResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<StreamedResponse> requestAddEditPrescriptionFormData({required String url,required String callfrom, required ProviderAddEditPrescriptionRequest requestModel}) async{
    MySharedPreference.getInstance();

    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if(flagNet){
      try{
        var headers = {
          "Content-Type": "multipart/form-data",
        };
        final Map<String, String?> data;
        if(callfrom == "Edit") {
           data = {
            'Id': requestModel.id,
            'diognosis': requestModel.diognosis,
            'bookingId': requestModel.bookingId,
            'prescriptiondate': requestModel.prescriptiondate,
            'ServiceProviderId': requestModel.serviceProviderId,
            'ServiceReceiverId': requestModel.serviceReceiverId,
            'prescriptiondurgdetails': requestModel.prescriptiondurgdetails,
            'prescriptionmedicaltestdetails': requestModel.prescriptionmedicaltestdetails,
            'prescriptionadvicedetails': requestModel.prescriptionadvicedetails
          };
        } else {
          data = {
            'diognosis': requestModel.diognosis,
            'bookingId': requestModel.bookingId,
            'prescriptiondate': requestModel.prescriptiondate,
            'ServiceProviderId': requestModel.serviceProviderId,
            'ServiceReceiverId': requestModel.serviceReceiverId,
            'prescriptiondurgdetails': requestModel.prescriptiondurgdetails,
            'prescriptionmedicaltestdetails': requestModel.prescriptionmedicaltestdetails,
            'prescriptionadvicedetails': requestModel.prescriptionadvicedetails
          };
        }

        var request = http.MultipartRequest('POST', Uri.parse(url));
        request = jsonToFormData(request, data);

        if(requestModel.file != ""){
          log("UPLOAD_SIGNATURE : ${requestModel.file!}");
          request.files.add(await http.MultipartFile.fromPath('File', requestModel.file!));

        }
        request.headers.addAll(headers);

        log("ADD_UPDATE_PRESCRIPTION_REQUEST :${request.fields}");
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          progressDialog.close();
          return response;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          throw '';
        }
      }catch(exception){
        log("Request API Exception:  ${exception.toString()}");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        throw '';

      }

    }else{
      progressDialog.close();
      log("Request API : No Net ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      throw '';
    }
  }


  ///*
  ///
  ///
  Future<List<ProviderBillInformationResponse>?> requestProviderBillInfo({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderBillInformationResponse> jsonList =
          ProviderBillInformationResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderBillingHistoryResponse>?> requestProviderBillingHistory({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderBillingHistoryResponse> jsonList =
          ProviderBillingHistoryResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ProviderPatientListResponse>?> requestPatientList({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ProviderPatientListResponse> jsonList =
          ProviderPatientListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<NotificationListResponse>?> requestNotificationList({required String url, required String parameters}) async {
    // CustomProgressDialog progressDialog = CustomProgressDialog();

    // progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          // progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<NotificationListResponse> jsonList =
          NotificationListResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          // progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        // progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      // progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<List<ReadAllNotificationResponse>?> requestReadAllNotification({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          // final jsonObject = json.decode(results.body);
          List<ReadAllNotificationResponse> jsonList =
          ReadAllNotificationResponseFromJsonList(results.body);

          log("Response : ${json.encode(jsonList)}");
          return jsonList;

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }


  ///*
  ///
  ///
  Future<bool?> requestDeleteNotificationData({required String url, required String parameters}) async {
    CustomProgressDialog progressDialog = CustomProgressDialog();

    progressDialog.showProgressDialog();

    log("API : $url");
    log("RequestBody : $parameters");
    bool flagNet = await MyInternetConnection().isInternetAvailable();

    if (flagNet) {
      try{
        Uri uri = Uri.parse(url);
        final results = await http.post(uri,
            body: parameters, headers: {"Content-Type": "application/json"});

        if (results.statusCode == 200) {
          progressDialog.close();
          final jsonObject = json.decode(results.body);

          if(jsonObject != null){
            return true;
          }else{
            return false;
          }

        } else{
          progressDialog.close();
          log("Request API : null ");

          showDialog(
            context: Get.context!,
            builder: (BuildContext context1) => OKDialog(
              title: "",
              descriptions: MyString.errorMessage,
              img: errorImage,
            ),
          );
          return null;

        }

      }catch(exception){
        log("Request API Exception: $exception.toString()");
        progressDialog.close();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context1) => OKDialog(
            title: "",
            descriptions: MyString.errorMessage,
            img: errorImage,
          ),
        );
        return null;

      }

    } else {
      progressDialog.close();
      log("Request API : No Internet ");

      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => OKDialog(
          title: "",
          descriptions: "Please check Internet Connection",
          img: noInternetImage,
        ),
      );
      return null;
    }

  }



}
