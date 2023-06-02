import 'package:get/get.dart';
import 'package:soowgood/provider/model/request/get_patient_document_history_request.dart';
import 'package:soowgood/provider/model/response/get_patient_document_history_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderMedicalDocumentController extends GetxController{

  ProviderRepository repository = ProviderRepository();
  var serviceReceiverId = ''.obs;
  var bookingId = ''.obs;
  var documentHistoryList = <GetPatientDocumentHistoryResponse>[].obs;

  ///*
  ///
  ///  get Bookings/getPatientAppointmentDocumentHistory Api Response
  ///  to get patient's document history
  void getPatientDocumentHistory() async{
    GetPatientDocumentHistoryRequest requestModel = GetPatientDocumentHistoryRequest();
    requestModel.serviceReceiverId = serviceReceiverId.value;
    requestModel.booingId = bookingId.value;


    var responseModel = await repository.hitGetDocumentHistory(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      documentHistoryList.clear();
      documentHistoryList.value = responseModel;
    }else{
      documentHistoryList.clear();
    }
    }

}