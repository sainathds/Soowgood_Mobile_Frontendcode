import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:soowgood/benificiary/model/other/gender_model.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_search_providers_request.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_search_providers_response.dart';
import 'package:soowgood/benificiary/repository/beneficiary_repository.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/provider/model/request/dropdown_list_request.dart';
import 'package:soowgood/provider/model/request/provider_consultancy_type_request.dart';
import 'package:soowgood/provider/model/request/provider_schedule_type_request.dart';
import 'package:soowgood/provider/model/response/provider_consultancy_type_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_type_response.dart';

class BeneficiaryDoctorsController extends GetxController{

  BeneficiaryRepository repository = BeneficiaryRepository();
  var searchController = TextEditingController();

  var providerList = <BeneficiarySearchProvidersResponse>[].obs;

  var specializationList = <String>[].obs;
  var multiSpecializationList = <MultiSelectItem<String>>[].obs;
  var selectedSpecializationList = <Object?>[].obs;

  var appointmentTypeList = <ProviderConsultancyTypeResponse>[].obs;
  var selectedAppointmentType = ProviderConsultancyTypeResponse().obs;

  var genderList = <GenderModel>[].obs;
  var selectedGender = GenderModel().obs;

  List<String> weekDays = <String>[];
  List<MultiSelectItem<String>> multiWeekDayList = <MultiSelectItem<String>>[];
  List<Object?> selectedWeekDayList = <Object?>[];

  var isSheetDismissible = true.obs;

  ///*
  ///
  ///
  void getSearchedProvidersResponse() async{

    BeneficiarySearchProvidersRequest requestModel = BeneficiarySearchProvidersRequest();

    if(selectedGender.value.name.isNotEmpty){
      requestModel.gender = selectedGender.value.name;
    }else{
      requestModel.gender = "";
    }

    if(selectedAppointmentType.value.name != null && selectedAppointmentType.value.name!.isNotEmpty){
      requestModel.appointmentType = selectedAppointmentType.value.name;
    }else{
      requestModel.appointmentType = "";
    }

    if(selectedWeekDayList.isNotEmpty){
      requestModel.availability = selectedWeekDayList.join(',');
    }else{
      requestModel.availability = "";
    }

    if(selectedSpecializationList.isNotEmpty){
      requestModel.providerSpeciality = selectedSpecializationList.join(',');
    }else{
      requestModel.providerSpeciality = "";
    }

    requestModel.consultationFees = 0;
    requestModel.dayEndTime = "2003-12-31T12:00:00.000Z";
    requestModel.dayStartingTime = "2003-12-31T12:00:00.000Z";
    requestModel.location = "";
    requestModel.pageNumber = 0;
    requestModel.pageSize = 1000;
    requestModel.providerType = "";
    requestModel.searchKeyword = searchController.text;
    requestModel.serviceType = "";


    List<BeneficiarySearchProvidersResponse>? responseModel = await repository.hitSearchProvidersApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      providerList.clear();
      providerList.value = responseModel;
    }else{
      providerList.clear();
    }

  }


  ///*
  ///
  ///
  void getSpecializationListResponse() async{

    DropdownListRequest requestModel = DropdownListRequest();
    requestModel.searchKeyword = '';

    List<String>? responseModel = await repository.hitSpecializationTypeListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      specializationList.value = responseModel;
      multiSpecializationList.value = specializationList.map((e) => MultiSelectItem(e, e)).toList();
    }else{
      specializationList.clear();
      multiSpecializationList.clear();

    }
  }


  ///*
  ///
  ///
  void getAppointmentTypeResponse() async{

    ProviderConsultancyTypeRequest requestModel = ProviderConsultancyTypeRequest();
    requestModel.id =   MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderConsultancyTypeResponse>? responseModel = await repository.hitAppointmentTypeApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      appointmentTypeList.value = responseModel;
    }else{
      appointmentTypeList.clear();

    }
  }

  ///*
  ///
  ///
  getWeekdaysList(){
    weekDays.add('Sunday');
    weekDays.add('Monday');
    weekDays.add('Tuesday');
    weekDays.add('Wednesday');
    weekDays.add('Thursday');
    weekDays.add('Friday');
    weekDays.add('Saturday');

    multiWeekDayList = weekDays.map((e) => MultiSelectItem(e, e)).toList();
  }

  ///*
  ///
  ///
  clearAll(){
    searchController.clear();
    providerList.clear();
    specializationList.clear();
    multiSpecializationList.clear();
    selectedSpecializationList.clear();
    appointmentTypeList.clear();
    selectedAppointmentType.value.name = "";
    genderList.clear();
    selectedGender.value.name = "";
    weekDays.clear();
    multiWeekDayList.clear();
    selectedWeekDayList.clear();

  }


}