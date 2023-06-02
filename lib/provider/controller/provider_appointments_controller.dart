import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/provider/model/request/provider_consultancy_type_request.dart';
import 'package:soowgood/provider/model/response/provider_consultancy_type_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderAppointmentsController extends GetxController{

  ProviderRepository repository = ProviderRepository();
  var consultancyTypeList = <ProviderConsultancyTypeResponse>[].obs;


  ///*
  ///
  /// get AppointmentTypes/AppointmentType Api Response
  /// to get types of consultancy like - Clinic, Online, and PhysicalVisit of particular provider
  void getConsultancyTypeResponse() async{

    ProviderConsultancyTypeRequest requestModel = ProviderConsultancyTypeRequest();
    requestModel.id =   MySharedPreference.getString(KeyConstants.keyUserId);

    List<ProviderConsultancyTypeResponse>? responseModel = await repository.hitConsultancyTypeApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      consultancyTypeList.value = responseModel;
    }else{
      consultancyTypeList.clear();
    }
  }

}