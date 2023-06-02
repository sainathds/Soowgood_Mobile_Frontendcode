import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/model/request/provider_add_document_request.dart';
import 'package:soowgood/provider/model/request/provider_edit_document_request.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderAddEditDocumentController extends GetxController{

  ProviderRepository repository = ProviderRepository();

  TextEditingController fileController = TextEditingController();
  TextEditingController documentNameController = TextEditingController();

  var isDocNameEmpty = false.obs;
  var isFileEmpty = false.obs;

  String callFrom = '';
  String documentId = '';
  String file = "";
  String documentName = "";
  String fileName = "";


  var selectedDocument = ''.obs;

  ///*
  ///
  /// check validations for required field
  void isDataValid(){
    if(selectedDocument.value.isEmpty) {
      setAllErrorToFalse();
      isDocNameEmpty.value = true;

   /* } else if(documentName.isNotEmpty && (documentName != selectedDocument.value && fileName == fileController.text)){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            OKDialog(
                title: '',
                descriptions: 'Please add ${selectedDocument.value} document',
                img: errorImage)
      );*/
    }else if(fileController.text.isEmpty){
      setAllErrorToFalse();
      isFileEmpty.value = true;

    }else {
      setAllErrorToFalse();

      if(callFrom == 'Add'){
        getUploadDocumentResponse();
      }else{
        getUpdateDocumentResponse();
      }
    }
  }

  ///*
  ///
  /// use ProviderDocuments/saveProviderDocument Api to upload document
  void getUploadDocumentResponse() async{
    ProviderAddDocumentRequest requestModel = ProviderAddDocumentRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.documentname = selectedDocument.value;
    requestModel.filetype = 'noturl';
    if(file != null){
      requestModel.file = file;
    }else{
      requestModel.file = "";
    }


    bool isUploadedSuccessfully = await repository.hitUploadDocumentApi(requestModel);

    if(isUploadedSuccessfully){
      ProviderGlobal.isDocumentBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Document Uploaded Successfully',
                buttonText: 'Ok',
                okBtnFunction: clearAll
            ),
      );
    }
  }

  ///*
  ///
  /// use ProviderDocuments/updateProviderDocument api to update Document
  void getUpdateDocumentResponse() async{
    ProviderEditDocumentRequest requestModel = ProviderEditDocumentRequest();
    requestModel.userId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.id = documentId;
    requestModel.documentname = selectedDocument.value;
    requestModel.documentfilename = fileController.text;

    if(file != ''){
      requestModel.file = file;
      requestModel.filetype = 'noturl';

    }else{
      requestModel.filetype = 'url';

    }
    bool isUploadedSuccessfully = await repository.hitUpdateDocumentApi(requestModel);

    if(isUploadedSuccessfully){
      ProviderGlobal.isDocumentBack = true;
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: 'Document Updated Successfully',
                buttonText: 'Ok',
                okBtnFunction: dismiss
            ),
      );
    }
  }


  ///*
  ///
  ///
  clearAll() {
    callFrom = '';
    file = '';
    documentName = '';
    fileController.clear();
    selectedDocument.value = '';

  }

  ///*
  ///
  ///
  void setAllErrorToFalse() {
    isDocNameEmpty.value = false;
    isFileEmpty.value = false;
  }

  ///*
  ///
  ///
  dismiss() {
  }
}