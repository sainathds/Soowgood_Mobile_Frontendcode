import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_add_edit_document_controler.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderAddEditDocumentScreen extends StatefulWidget {

  String callFrom;
  String documentId;
  String documentName;
  String fileName;

  ProviderAddEditDocumentScreen({
    Key? key,
    required this.callFrom,
    required this.documentId,
    required this.documentName,
    required this.fileName}) : super(key: key);

  @override
  _ProviderAddEditDocumentScreenState createState() => _ProviderAddEditDocumentScreenState();
}

class _ProviderAddEditDocumentScreenState extends State<ProviderAddEditDocumentScreen> {

  ProviderAddEditDocumentController getXController = Get.put(ProviderAddEditDocumentController());
  var documentList = [
    '',
    'Govt Id Poof',
    'Education Certificate',
    'License',
    'Others'
  ];
  @override
  void initState() {
    // TODO: implement initState
    ProviderGlobal.isDocumentBack = false;
    getXController.clearAll();
    setData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child:  Obx((){
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,

              leading: InkWell(
                  onTap: (){
                    Get.back(result: ProviderGlobal.isDocumentBack);
                  },
                  child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
              title: Text('${widget.callFrom} Document'),
            ),

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [


                      getStarLabel('Document Name'),
                      documentDropdown(),
                      // documentNameField(),

                      const SizedBox(height: 20.0,),
                      getStarLabel('Choose File'),
                      fileField(),

                      const SizedBox(height: 30.0,),
                      buttonWidget()


                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      })
    );

  }

  ///*
  ///
  ///
  fileField() {
    return TextFormField(
      readOnly: true,
      controller: getXController.fileController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style:  const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration: InputDecoration(
        suffixIcon: InkWell(
            onTap: (){
              setState(() {
                getXController.setAllErrorToFalse();
                selectDocFile();
              });
            },
            child: const Icon(Icons.file_upload, color: Colors.grey,)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        hintText: 'Choose File',
        hintStyle: const TextStyle(
            fontSize: 13.0,
            color: MyColor.hintColor,
            fontFamily: 'poppins_regular'
        ),
        errorText: getXController.isFileEmpty.value ? "Please Select File" :  null ,
      ),

    );

  }

  ///*
  ///
  ///
  documentNameField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.documentNameController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_medium'
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0),
          hintText: 'Document Name',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isDocNameEmpty.value? "Please Enter Name Of Document" : null
      ),
    );
  }


  ///*
  ///
  /// select file using file_picker
  void selectDocFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile platformFile = result.files.first;
      getXController.fileController.text = platformFile.name;
      // getXController.filetype = file.extension!;
      if(platformFile.path != null){
        getXController.file = platformFile.path!;
      }

      log(platformFile.name);
      log(platformFile.bytes.toString());
      log(platformFile.size.toString());
      log(platformFile.extension.toString());
      log(platformFile.path.toString());
    } else {
      // User canceled the picker
    }

  }


  ///*
  ///
  ///
  getStarLabel(String label) {
    return Row(
      children: [
        Text(label, style: const TextStyle(
            fontSize: 13.0,
            color: MyColor.themeTealBlue,
            fontFamily: 'poppins_semibold'
        ),),
        const Padding(
          padding: EdgeInsets.all(3.0),
        ),
        const Text('*', style: const TextStyle(color: Colors.red)),

      ],
    );

  }


  ///*
  ///
  ///
  buttonWidget() {
    return SizedBox(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: (){
            getXController.isDataValid();
          },
          style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),),
          child:  Text(
             widget.callFrom == 'Edit'? 'Update Document':'${widget.callFrom} Document',
            style: const TextStyle(
                color: MyColor.offWhite,
                fontSize: 16.0,
                fontFamily: 'poppins_semibold'
            ),
          )),
    );

  }

  ///*
  ///
  ///
  void setData() {

    getXController.callFrom = widget.callFrom;
    getXController.documentId = widget.documentId;
    getXController.documentName = widget.documentName;
    getXController.fileController.text = widget.fileName;
    getXController.selectedDocument.value = widget.documentName;

    getXController.fileName = widget.fileName;

  }

  ///*
  ///
  ///
  Future<bool> _onWillPop() async{
    Get.back(result: ProviderGlobal.isDocumentBack);
    return false;
  }

  ///*
  ///
  ///
  Widget documentDropdown(){
    return DropdownButton(
      isExpanded: true,
      underline: Container(height: 1, color: Colors.grey,),
      value: getXController.selectedDocument.value,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: documentList.map((String gender){
        return DropdownMenuItem(
            value: gender,
            child: Text(gender, style: const TextStyle(
                fontSize: 14.0,
                color: MyColor.themeTealBlue,
                fontFamily: 'poppins_semibold'
            ),)
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          getXController.selectedDocument.value = newValue!;
        });
      },
    );
  }

}
