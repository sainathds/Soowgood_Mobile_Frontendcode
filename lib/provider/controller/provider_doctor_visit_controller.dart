import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/provider/model/request/get_patient_document_history_request.dart';
import 'package:soowgood/provider/model/request/provider_visited_doctor_request.dart';
import 'package:soowgood/provider/model/response/get_patient_document_history_response.dart';
import 'package:soowgood/provider/model/response/provider_visited_doctor_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderDoctorVisitController extends GetxController{


  ProviderRepository repository = ProviderRepository();
  var doctorVisitList = <ProviderVisitedDoctorListResponse>[].obs;


  ///*
  ///
  /// get Bookings/getDoctorVisitForPatient api response to get doctor visited list
  void getDoctorVisitResponse(String serviceReceiverId) async{

    ProviderVisitedDoctorListRequest requestModel = ProviderVisitedDoctorListRequest();
    requestModel.serviceProviderId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.serviceReceiverId = serviceReceiverId;

    List<ProviderVisitedDoctorListResponse>? responseModel = await repository.hitVisitedDoctorApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      doctorVisitList.clear();
      doctorVisitList.value = responseModel;
    }else{
      doctorVisitList.clear();
    }
  }



}