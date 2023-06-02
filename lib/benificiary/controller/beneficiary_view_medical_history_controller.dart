import 'package:get/get.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_prescription_list_request.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_list_response.dart';
import 'package:soowgood/benificiary/repository/beneficiary_repository.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';

class BeneficiaryViewMedicalHistoryController extends GetxController{

  BeneficiaryRepository repository = BeneficiaryRepository();

  var providerId = ''.obs;
  var prescriptionList = <BeneficiaryPrescriptionListResponse>[].obs;


  ///*
  ///
  /// get Bookings/getPrescription Api response
  /// to get prescription list of particular provider
  void getPrescriptionListResponse()async{
    BeneficiaryPrescriptionListRequest requestModel = BeneficiaryPrescriptionListRequest();
    requestModel.serviceReceiverId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.serviceProviderId = providerId.value;

    List<BeneficiaryPrescriptionListResponse>? responseModel = await repository.hitPrescriptionListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      prescriptionList.clear();
      prescriptionList.value = responseModel;
    }else{
      prescriptionList.clear();
    }
  }
}