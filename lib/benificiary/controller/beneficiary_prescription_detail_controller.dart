import 'package:get/get.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_advice_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_drug_list_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_medical_test_request.dart';
import 'package:soowgood/benificiary/model/request/beneficiary_prescription_data_request.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_advice_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_drug_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_medical_test_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_prescription_data_response.dart';
import 'package:soowgood/benificiary/repository/beneficiary_repository.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';

class BeneficiaryPrescriptionDetailController extends GetxController{

  BeneficiaryRepository repository = BeneficiaryRepository();
  var name = ''.obs;
  var age = ''.obs;
  var gender = ''.obs;
  var date = ''.obs;
  var diagnosis = ''.obs;

  var drugList = <BeneficiaryDrugListResponse>[].obs;
  var medicalTestList = <BeneficiaryMedicalTestResponse>[].obs;
  var adviceList = <BeneficiaryAdviceListResponse>[].obs;

  var providerId = ''.obs;
  var prescriptionId = ''.obs;

  ///*
  ///
  /// get Bookings/getprescriptiondurgdetails Api response
  /// to get prescription drug details
  void getDrugListResponse()async{
    BeneficiaryDrugListRequest requestModel = BeneficiaryDrugListRequest();
    requestModel.id = prescriptionId.value;

    List<BeneficiaryDrugListResponse>? responseModel = await repository.hitDrugListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      drugList.clear();
      drugList.value = responseModel;
      getMedicalTestListResponse();
    }else{
      drugList.clear();
      getMedicalTestListResponse();
    }
  }


  ///*
  ///
  /// get Bookings/getprescriptionmedicaltestdetails Api response
  /// to get prescription Medical history
  void getMedicalTestListResponse()async{
    BeneficiaryMedicalTestRequest requestModel = BeneficiaryMedicalTestRequest();
    requestModel.id = prescriptionId.value;

    List<BeneficiaryMedicalTestResponse>? responseModel = await repository.hitMedicalTestListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      medicalTestList.clear();
      medicalTestList.value = responseModel;
      getAdviceListResponse();
    }else{
      medicalTestList.clear();
      getAdviceListResponse();
    }
  }

  ///*
  ///
  ///  get Bookings/getprescriptionadvicetestdetails api response
  ///  to get prescription AdviceList
  void getAdviceListResponse()async{
    BeneficiaryAdviceListRequest requestModel = BeneficiaryAdviceListRequest();
    requestModel.id = prescriptionId.value;

    List<BeneficiaryAdviceListResponse>? responseModel = await repository.hitAdviceListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      adviceList.clear();
      adviceList.value = responseModel;
    }else{
      adviceList.clear();
    }
  }


  ///*
  ///
  ///  get Bookings/getServiceReceiverForPrescription Api response
  ///  to get patient data
  void getPrescriptionData()async{
    BeneficiaryPrescriptionDataRequest requestModel = BeneficiaryPrescriptionDataRequest();
    requestModel.serviceReceiverId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.serviceProviderId = providerId.value;
    List<BeneficiaryPrescriptionDataResponse>? responseModel = await repository.hitPrescriptionDataApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      name.value = getData(responseModel[0].serviceReceiver);
      age.value = getData(responseModel[0].age.toString());
      gender.value = getData(responseModel[0].gender);
    }

    getDrugListResponse();
  }

  ///*
  ///
  ///
  String getData(String? data) {

    if(data != null){
      return data;
    }else{
      return '';
    }
  }

}