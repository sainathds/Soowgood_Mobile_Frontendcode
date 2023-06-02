import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_advice_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_drug_list_response.dart';
import 'package:soowgood/benificiary/model/response/beneficiary_medical_test_response.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_add_edit_prescription_controller.dart';

import '../../common/resources/my_assets.dart';

class ProviderAddEditPrescriptionScreen extends StatefulWidget {

  String receiverId;
  String bookingId;
  String callFrom;
  String prescriptionId;
  String diagnosis;

  ProviderAddEditPrescriptionScreen({Key? key, required this.receiverId, required this.bookingId , required this.callFrom,
  required this.prescriptionId, required this.diagnosis}) : super(key: key);

  @override
  _ProviderAddEditPrescriptionScreenState createState() => _ProviderAddEditPrescriptionScreenState();
}

class _ProviderAddEditPrescriptionScreenState extends State<ProviderAddEditPrescriptionScreen> {
  ProviderAddEditPrescriptionController getXController = Get.put(ProviderAddEditPrescriptionController());

  @override
  void initState() {
    // TODO: implement initState
    getXController.receiverId.value = widget.receiverId;
    getXController.bookingId.value = widget.bookingId;
    getXController.callFrom.value = widget.callFrom;
    getXController.prescriptionId.value = widget.prescriptionId;
    getXController.diagnosisController.text = widget.diagnosis;

    Future.delayed(Duration(), (){
      getXController.getPrescriptionPatientData();
    });

    getXController.getWeekdaysList();
    getXController.getTimingList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child: Obx((){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
              centerTitle: true,
              title: const Text('Prescription Detail'),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      getPatientDetail(),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 0.5,
                        color:  Colors.grey,),


                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          getDrugInputs(),

                          getXController.drugList.isNotEmpty?
                          getDrugTableTitle() :SizedBox(),
                          getXController.drugList.isNotEmpty?
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: getXController.drugList.length,
                              itemBuilder: (context, index){
                                return drugDetailWidget(index);
                              })
                              :SizedBox(),
                        ],
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 0.5,
                        color:  Colors.grey,),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          getMedicalTestField(),
                          getXController.medicalTestList.isNotEmpty?
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: getXController.medicalTestList.length,
                              itemBuilder: (context, index){
                                return medicalTestWidget(index);
                              }): SizedBox()
                        ],
                      ) ,


                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 0.5,
                        color:  Colors.grey,),



                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          getAdviceField(),
                          getXController.adviceList.isNotEmpty?
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: getXController.adviceList.length,
                              itemBuilder: (context, index){
                                return adviceWidget(index);
                              }): SizedBox(),
                        ],
                      ),


                      SizedBox(height: 10,),

                      widget.callFrom == 'Add'?
                      getSignatureWidget(): SizedBox(),

                      SizedBox(height: 20,),
                      buttonWidget()
                    ],
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
  getPatientDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: getRowData('Name' , getXController.name.value),),
              Expanded(child: getRowData('Age' , getXController.age.value),)
            ],
          ),

          Row(
            children: [
              Expanded(
                flex: 2,
                child:
                getRowData('Gender' , getXController.gender.value),
              ),
              Expanded(child: getRowData('Date' , getXController.date.value),)

            ],
          ),

          SizedBox(height: 15,),
          Row(
            children: [
              Expanded(
                child:
                diagnosisField()
              )
            ],
          )
        ],
      ),
    );

  }

  ///*
  ///
  ///
  getRowData(String label, String value) {
    return Row(
      children: [
        Text(
          '$label :',
          style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'poppins_medium'
          ),
        ),

        Text(
          value,
          style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'poppins_regular'
          ),
        )

      ],
    );
  }


  ///*
  ///
  ///
  diagnosisField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.diagnosisController,
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
          EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Diagnosis',
          hintText: 'Diagnosis',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isDiagnosisNameEmpty.value? "Please Enter Name Of Diagnosis" : null
      ),
    );

  }

  ///*
  ///
  ///
  medicalTestWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      child: Table(
        border: TableBorder.symmetric(
            inside: const BorderSide(width: 1, color: Colors.black)),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,

        columnWidths: const {
          0: FlexColumnWidth(0.5),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(0.5)
        },
        children: [
          index == 0 ? getMedicalTestTableTitleRow(): TableRow(children: [SizedBox(), SizedBox(), SizedBox()]),
          getMedicalTestTableRow((index+1).toString(),getXController.medicalTestList[index].medicaltest!, index),

        ],
      ),

    );
  }




  ///*
  ///
  ///
  tableHeadingData(String data){
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontFamily: 'poppins_semibold'
          ),),
      );
  }

  ///*
  ///
  ///
  tableValueData(String data){
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'poppins_regular'
          ),),
      );
  }

  ///*
  ///
  ///
  getMedicalTestTableRow(String srNo,String testName, int index){
    return TableRow(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.5,
          ),),
        children: [
          tableValueData(srNo),
          InkWell(
            onTap: (){
              getXController.selectedTest.value = getXController.medicalTestList[index];
              getXController.testNameIndex.value = index;
              getXController.testNameController.text = testName;
              getXController.isTestSelect.value = true;
            },
            child: tableValueData(testName),
          ),
          InkWell(
              onTap: (){
                getXController.medicalTestList.removeAt(index);
              },
              child: Icon(Icons.delete_outline_outlined, size: 20,))
        ]

    );

  }

  ///*
  ///
  ///
  getMedicalTestTableTitleRow(){
    return TableRow(
        decoration: BoxDecoration(
          color: MyColor.lightGreenBlue,
          border: Border.all(
            width: 0.5,
          ),),
        children: [
          tableHeadingData('Sr.no'),
          tableHeadingData('Name of Medical Test'),
          tableHeadingData('Action'),

        ]

    );

  }


  ///*
  ///
  ///
  getMedicalTestField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('RX',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'poppins_semibold'
            ),),
          SizedBox(height: 10,),
          TextFormField(
            onTap: () {
              getXController.setAllErrorToFalse();
            },
            controller: getXController.testNameController,
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
                EdgeInsets.symmetric(horizontal: 10),
                labelText: 'Medical Test',
                hintText: 'Medical Test',
                hintStyle: const TextStyle(
                    fontSize: 13.0,
                    color: MyColor.hintColor,
                    fontFamily: 'poppins_regular'
                ),
                // errorText: getXController.isDiagnosisNameEmpty.value? "Please Enter Name Of Diagnosis" : null
            ),
          ),

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              getXController.isTestSelect.value?
              InkWell(
                onTap: (){
                  if(getXController.testNameController.text.trim().isNotEmpty){
                    getXController.selectedTest.value.medicaltest = getXController.testNameController.text.trim();
                    for(int index = 0; index < getXController.medicalTestList.length ; index++){
                      if(getXController.selectedTest.value.testid == getXController.medicalTestList[index].testid){
                        getXController.medicalTestList.removeAt(index);
                        getXController.medicalTestList.insert(getXController.testNameIndex.value, getXController.selectedTest.value);
                        break;
                      }
                    }
                  }
                  getXController.testNameController.clear();
                  getXController.isTestSelect.value = false;
                },
                child: Text(
                  'Update Item',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'poppins_medium',
                      color: Colors.black
                  ),),
              )


              :InkWell(
              onTap: (){
                if(getXController.testNameController.text.trim().isNotEmpty){
                  BeneficiaryMedicalTestResponse data = BeneficiaryMedicalTestResponse();
                  data.testid = (getXController.medicalTestList.length + 1).toString();
                  data.prescriptionid = (getXController.medicalTestList.length + 1).toString();
                  data.medicaltest = getXController.testNameController.text.trim();
                  getXController.medicalTestList.add(data);
                  getXController.testNameController.clear();

                  log('MedicalTestList ${json.encode(getXController.medicalTestList.toString())}');
                }
                },
              child: Text(
                  'Add ',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'poppins_semibold',
                    color: Colors.black
                  ),),
            ),
          ],)

      ],
      ),
    );
  }

  /****************************************************************************/


  ///*
  ///
  ///
  adviceWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      child: Table(
        border: TableBorder.symmetric(
            inside: const BorderSide(width: 1, color: Colors.black)),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,

        columnWidths: const {
          0: FlexColumnWidth(0.5),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(0.5)
        },
        children: [
          index == 0 ? getAdviceTableTitleRow(): TableRow(children: [SizedBox(), SizedBox(), SizedBox()]),
          getAdviceTableRow((index+1).toString(),getXController.adviceList[index].advice!, index),

        ],
      ),

    );
  }


  ///*
  ///
  ///
  getAdviceTableRow(String srNo,String adviceName, int index){
    return TableRow(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.5,
          ),),
        children: [
          tableValueData(srNo),

          InkWell(
            onTap: (){
              getXController.selectedAdvice.value = getXController.adviceList[index];
              getXController.adviceIndex.value = index;
              getXController.adviceController.text = adviceName;
              getXController.isAdviceSelect.value = true;
            },
            child: tableValueData(adviceName),
          ),

          InkWell(
              onTap: (){
                getXController.adviceList.removeAt(index);
              },
              child: Icon(Icons.delete_outline_outlined, size: 20,))
        ]

    );

  }

  ///*
  ///
  ///
  getAdviceTableTitleRow(){
    return TableRow(
        decoration: BoxDecoration(
          color: MyColor.lightGreenBlue,
          border: Border.all(
            width: 0.5,
          ),),
        children: [
          tableHeadingData('Sr.no'),
          tableHeadingData('Advice'),
          tableHeadingData('Action'),

        ]

    );

  }


  ///*
  ///
  ///
  getAdviceField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 10,),
          TextFormField(
            onTap: () {
              getXController.setAllErrorToFalse();
            },
            controller: getXController.adviceController,
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
              EdgeInsets.symmetric(horizontal: 10),
              labelText: 'Advice',
              hintText: 'Advice',
              hintStyle: const TextStyle(
                  fontSize: 13.0,
                  color: MyColor.hintColor,
                  fontFamily: 'poppins_regular'
              ),
              // errorText: getXController.isDiagnosisNameEmpty.value? "Please Enter Name Of Diagnosis" : null
            ),
          ),

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              getXController.isAdviceSelect.value?
              InkWell(
                onTap: (){
                  if(getXController.adviceController.text.trim().isNotEmpty){
                    getXController.selectedAdvice.value.advice = getXController.adviceController.text.trim();

                    for(int index = 0; index < getXController.adviceList.length ; index++){
                      if(getXController.selectedAdvice.value.adviceid == getXController.adviceList[index].adviceid){
                        getXController.adviceList.removeAt(index);
                        getXController.adviceList.insert(getXController.adviceIndex.value, getXController.selectedAdvice.value);
                        break;
                      }
                    }
                  }
                  getXController.adviceController.clear();
                  getXController.isAdviceSelect.value = false;
                },
                child: Text(
                  'Update Item',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'poppins_medium',
                      color: Colors.black
                  ),),
              )


                  :InkWell(
                onTap: (){
                  if(getXController.adviceController.text.trim().isNotEmpty){

                    BeneficiaryAdviceListResponse data = BeneficiaryAdviceListResponse();
                    data.adviceid = (getXController.adviceList.length + 1).toString();
                    data.prescriptionid = (getXController.adviceList.length + 1).toString();
                    data.advice = getXController.adviceController.text.trim();
                    getXController.adviceList.add(data);
                    getXController.adviceController.clear();

                  }
                },
                child: Text(
                  'Add ',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'poppins_semibold',
                      color: Colors.black
                  ),),
              ),
            ],)

        ],
      ),
    );
  }

  ///*
  ///
  ///
  getDrugInputs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: getDrugField(),),

              Expanded(child: getDoseField()),

            ],
          ),

          SizedBox(height: 10,),
          weekDaysDropdown(),
          SizedBox(height: 10,),
          timingDropdown(),

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              getXController.isDrugSelect.value?
              InkWell(
                onTap: (){
                  if(getXController.isDrugValid()){
                    getXController.selectedDrug.value.durgname = getXController.drugController.text.trim();
                    getXController.selectedDrug.value.dose = getXController.doseController.text.trim();
                    getXController.selectedDrug.value.weeklyschedule = getXController.selectedWeekDayList.join(',');
                    getXController.selectedDrug.value.timing = getXController.selectedTimingList.join(',');

                    for(int index = 0; index < getXController.drugList.length ; index++){
                      if(getXController.selectedDrug.value.durgId == getXController.drugList[index].durgId){
                        getXController.drugList.removeAt(index);
                        getXController.drugList.insert(getXController.drugIndex.value, getXController.selectedDrug.value);
                        break;
                      }
                    }
                  }
                  getXController.clearDrugData();
                  getXController.getWeekdaysList();
                  getXController.getTimingList();
                  getXController.isDrugSelect.value = false;
                },
                child: Text(
                  'Update Item',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'poppins_medium',
                      color: Colors.black
                  ),),
              )


                  :InkWell(
                onTap: (){
                  if(getXController.isDrugValid()){

                    BeneficiaryDrugListResponse data = BeneficiaryDrugListResponse();
                    data.durgId = (getXController.adviceList.length + 1).toString();
                    data.prescriptionid = (getXController.adviceList.length + 1).toString();
                    data.durgname = getXController.drugController.text.trim();
                    data.dose = getXController.doseController.text.trim();
                    data.weeklyschedule = getXController.selectedWeekDayList.join(',');
                    data.timing = getXController.selectedTimingList.join(',');

                    getXController.drugList.add(data);
                    getXController.clearDrugData();
                    getXController.getWeekdaysList();
                    getXController.getTimingList();
                  }
                },
                child: Text(
                  'Add ',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'poppins_semibold',
                      color: Colors.black
                  ),),
              ),
            ],)

        ],
      ),
    );
  }

  ///*
  ///
  ///
  getDrugField() {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 46,
      child: TextFormField(
        onTap: () {
          getXController.setAllErrorToFalse();
        },
        controller: getXController.drugController,
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
          EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Drug Name',
          hintText: 'Drug Name',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isDrugEmpty.value? "Please Enter Name Of Drug" : null
        ),
      ),
    );

  }


    ///*
  ///
  ///
  weekDaysDropdown() {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: MultiSelectDialogField(
        initialValue: getXController.selectedWeekDayList,
        items: getXController.multiWeekDayList,
        listType: MultiSelectListType.LIST,
        buttonText: const Text('Weekly Schedule', style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
            fontFamily: 'poppins_medium'
        ),),
        buttonIcon:  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
        searchable: true,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black54,),
          borderRadius: BorderRadius.circular(6.0),
        ),
        onConfirm: (values) {
          getXController.selectedWeekDayList = values;
          log('TEST--- ${getXController.selectedWeekDayList}');
        },

      ),
    );

  }


  ///*
  ///
  ///
  timingDropdown() {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: MultiSelectDialogField(
        initialValue: getXController.selectedTimingList,
        items: getXController.multiTimingList,
        listType: MultiSelectListType.LIST,
        buttonText: const Text('Timing',
        style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
            fontFamily: 'poppins_medium'
        ),),
        buttonIcon:  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
        searchable: true,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black54,),
          borderRadius: BorderRadius.circular(6.0),
        ),
        onConfirm: (values) {
          getXController.selectedTimingList = values;
          log('SelectedTiming--- ${getXController.selectedTimingList}');
        },
      ),
    );

  }

  ///*
  ///
  ///
  getDoseField() {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      height: 46,
      child: TextFormField(
        onTap: () {
          getXController.setAllErrorToFalse();
        },
        controller: getXController.doseController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        style: const TextStyle(
            fontSize: 14.0,
            color: MyColor.themeTealBlue,
            fontFamily: 'poppins_medium'
        ),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
            EdgeInsets.symmetric(horizontal: 10),
            labelText: 'Dose',
            hintText: 'Dose',
            hintStyle: const TextStyle(
                fontSize: 13.0,
                color: MyColor.hintColor,
                fontFamily: 'poppins_regular'
            ),
            errorText: getXController.isDoseEmpty.value? "Please Enter No. Of Dose" : null
        ),
      ),
    );

  }



  ///*
  ///
  ///
  drugDetailWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Table(
            border: TableBorder.symmetric(
                inside: const BorderSide(width: 1, color: Colors.black)),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,

            columnWidths: const {
              0: FlexColumnWidth(0.5),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(0.7),
              5: FlexColumnWidth(0.5)
            },
            children: [
/*              index == 0?
              getDrugTableTitleRow(): TableRow(),*/
              getDrugTableRow((index+1).toString(), getXController.drugList[index].durgname!, getXController.drugList[index].weeklyschedule!, getXController.drugList[index].timing!, getXController.drugList[index].dose!, index),

            ],
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getDrugTableRow(String srNo,String drugName, String schedule, String timing, String dose, int index){
    return TableRow(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.5,
          ),),
        children: [
          tableValueData(srNo),
          InkWell(
            child: tableValueData(drugName),
            onTap: (){
              setState(() {
                getXController.selectedDrug.value = getXController.drugList[index];
                getXController.drugIndex.value = index;
                getXController.drugController.text = getXController.selectedDrug.value.durgname!;
                getXController.doseController.text = getXController.selectedDrug.value.dose!;
                log('WEEKDAYS ${getXController.selectedDrug.value.weeklyschedule!}');
                getXController.selectedWeekDayList = getList(getXController.selectedDrug.value.weeklyschedule!);
                getXController.selectedTimingList = getList(getXController.selectedDrug.value.timing!);

                getXController.isDrugSelect.value = true;
              });
            },
          ),

          tableValueData(schedule),
          tableValueData(timing),
          tableValueData(dose),
          InkWell(
              onTap: (){
                getXController.drugList.removeAt(index);
              },
              child: const Icon(Icons.delete_outline_outlined))

        ]

    );

  }


  ///*
  ///
  ///
  getDrugTableTitleRow(){
    return TableRow(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          border: Border.all(
            width: 0.5,
          ),),
        children: [
          tableHeadingData('Sr.no'),
          tableHeadingData('Drug Name'),
          tableHeadingData('Weekly Schedule'),
          tableHeadingData('Timing'),
          tableHeadingData('Dose'),
          tableHeadingData('Action')
        ]

    );

  }

  ///*
  ///
  ///
  getDrugTableTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,),
      child: Table(
        border: TableBorder.symmetric(
            inside: const BorderSide(width: 1, color: Colors.black)),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,

        columnWidths: const {
          0: FlexColumnWidth(0.5),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(0.7),
          5: FlexColumnWidth(0.5)
        },
        children: [
          getDrugTableTitleRow(),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  List<String> getList(String data) {
    List<String> stringList = data.split(",");
    return stringList;

  }


  ///*
  ///
  /// upload signature
  getSignatureWidget() {
    return Column(
      children: [
        InkWell(
          onTap: (){
            showImageOptionDialog();
          },
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 1),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: !getXController.isLoad.value ? const SizedBox(height: 150, width: 150,)

                    : getXController.isLoad.value && getXController.compressedImageFilePath.value == ''? Center(child: CircularProgressIndicator(color: MyColor.themeTealBlue,),)

                    : getXController.compressedImageFilePath.value != '' ?

                Image(
                  image: FileImage(
                      File(getXController.imageFile!.path)),
                  width: 150.0, height: 150.0, fit: BoxFit.fill,)

                    :  Image.network(getXController.signatureImageUrl.value,
                  width: 150.0, height: 150.0, fit: BoxFit.fill,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image(
                        image: noImage, width: 150, height: 150, fit: BoxFit.fill);
                  },
                ),

              ),

              Positioned(
                  right: 0,
                  bottom: 0,
                  left: 0,
                  top: 0,
                  child: InkWell(
                      onTap: (){
                        showImageOptionDialog();
                      },
                      child: Icon(Icons.cloud_upload_outlined, color: Colors.black26, size: 50,)))
            ],),
          ),
        ),


        Text(
          'Upload Your Signature',
          style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'poppins_semibold'
          ),
        ),
        Text(
          'JPG, GIF or PNG. Max size of 2MB',
          style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: 'poppins_medium'
          ),
        ),
      ],
    );
  }

  ///*
  ///
  ///
  void showImageOptionDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30.0, top: 10, left: 20.0, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(Icons.cancel_outlined, color: Colors.grey, size: 25.0,),
                      SizedBox(width: 5.0,),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        imageSelector(context, "gallery");
                        Get.back();
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.image, color: MyColor.tealBlueDark, size: 40.0,),
                          SizedBox(width: 5.0,),
                          Text('Gallery',style: TextStyle(fontSize: 16.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold')),
                        ],
                      ),
                    ),

                    SizedBox(width: 50,),

                    InkWell(
                      onTap: (){
                        imageSelector(context, "camera");
                        Get.back();
                      },
                      child: Row(
                        children:  const [
                          Icon(Icons.add_a_photo, color: MyColor.tealBlueDark, size: 40.0,),
                          SizedBox(width: 5.0,),
                          Text('Camera',style: TextStyle(fontSize: 16.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold')),
                        ],
                      ),
                    ),


                  ],
                ),
              ],
            )
          );
        });
  }

  ///*
  ///
  ///
  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

      /// GALLERY IMAGE PICKER
        getXController.isLoad.value = false;
        getXController.compressedImageFilePath.value = '';
        getXController.imageFile = (await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 90))!;
        compressImage();
        break;

      case "camera": // CAMERA CAPTURE CODE
        getXController.isLoad.value = false;
        getXController.compressedImageFilePath.value = '';
        getXController.imageFile = (await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 90))!;
        compressImage();
        break;
    }

    if (getXController.imageFile != null) {
      log("You selected  image : ${getXController.imageFile!.path}");
      setState(() {
        debugPrint("SELECTED IMAGE PICK   ${getXController.imageFile}");
      });
    } else {
      log("You have not taken image");
    }
  }


  ///*
  ///
  ///
  buttonWidget() {
    return SizedBox(
      height: 35.0,
      child: ElevatedButton(
          onPressed: (){
            getXController.isDataValid();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColor.themeTealBlue,
            shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),),
          child:  Text(
            'Send To Patient',
            style: const TextStyle(
                color: MyColor.offWhite,
                fontSize: 14.0,
                fontFamily: 'poppins_semibold'
            ),
          )),
    );

  }

  ///*
  ///
  ///
  void compressImage() async{

    getXController.isLoad.value = true;

    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(
      getXController.imageFile!.path, targetPath,
      quality: 88,
      // rotate: 90,
    );

    if(result != null){
      getXController.compressedImageFilePath.value = result.path;
      log('COMPRESSED_IMG_SIZED ${result.readAsBytes()}');
    }


  }




}
