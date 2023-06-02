import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/common/screen/open_in_browser_screen.dart';
import 'package:soowgood/provider/controller/provider_prescription_controller.dart';
import 'package:soowgood/provider/screen/provider_add_edit_prescription_screen.dart';

class ProviderPrescriptionTab extends StatefulWidget {

  String serviceReceiverId;

  ProviderPrescriptionTab({Key? key, required this.serviceReceiverId}) : super(key: key);

  @override
  _ProviderPrescriptionTabState createState() => _ProviderPrescriptionTabState();
}

class _ProviderPrescriptionTabState extends State<ProviderPrescriptionTab> {

  ProviderPrescriptionController getXController = Get.put(ProviderPrescriptionController());

  @override
  void initState() {
    // TODO: implement initState

    getXController.prescriptionList.clear();
    getXController.serviceReceiverId.value = widget.serviceReceiverId;
    Future.delayed(Duration(), (){
      getXController.getPrescriptionPatientData();
    });

    Future.delayed(Duration(), (){
      getXController.getPrescriptionListResponse();
    });
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
            body: Column(
              children: [

                getPatientDetail(),

                getXController.prescriptionList.isNotEmpty?
                Expanded(
                  child: ListView.builder(
                      itemCount: getXController.prescriptionList.length,
                      itemBuilder: (context, index){
                        return getPrescriptionList(index);
                      }),
                ): const SizedBox()

              ],
            ),

          );
        })
    );

  }

  ///*
  ///
  ///
  Widget getPrescriptionList(int index) {

    String prescriptionDate = '';
    prescriptionDate = getUiDate(getData(getXController.prescriptionList[index].prescriptiondate));

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                  getRowData('Appointment Id', getData(getXController.prescriptionList[index].appointmentNo)),
                  getRowData('Date', prescriptionDate),

                ],),
                PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Colors.black,),
                    // add this line
                    itemBuilder: (_) => <PopupMenuItem<String>>[
                      const PopupMenuItem<String>(
                          value: 'Edit',
                          child: Text(
                            "Edit",
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'popins_regular',
                            ),
                          )),
/*                      const PopupMenuItem<String>(
                          value: 'Delete',
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'popins_regular',
                            ),
                          )),*/
                      const PopupMenuItem<String>(
                          value: 'View',
                          child: Text(
                            "View",
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'popins_regular',
                            ),
                          )),
                    ],
                    onSelected: (value) async {
                      switch (value) {
                        case 'Edit':
                          await Get.to(() => ProviderAddEditPrescriptionScreen(
                              receiverId: widget.serviceReceiverId,
                              bookingId: getXController.prescriptionList[index].bookingId!,
                              callFrom: 'Edit',
                             prescriptionId: getXController.prescriptionList[index].id!,
                             diagnosis: getXController.prescriptionList[index].diognosis!,))!.then((value) => getXController.getPrescriptionListResponse());

                          break;
                        case 'Delete':
                          // getXController.getDeleteDocumentResponse(getXController.documentList[index].id.toString());
                          break;

                        case 'View':

                          log('VIEW_PDF:  https://api.soowgood.com/prescriptionpdf/${getData(getXController.prescriptionList[index].id)}.pdf');
                          Get.to(() => OpenInBrowserScreen(url: 'https://api.soowgood.com/prescriptionpdf/${getData(getXController.prescriptionList[index].id)}.pdf')); //view prescription in pdf format
                          break;

                      }
                    })

              ],
            ),
            getRowData('Diagnosis', getData(getXController.prescriptionList[index].diognosis)),


          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  getRowData(String label, String value) {
    return  Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${label} :",
          style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'poppins_regular'
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              ' $value',
              // maxLines: 1,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontFamily: 'poppins_regular'
              ),
            ),
          ],
        )
      ],
    );
  }

  ///*
  ///
  ///
  getPatientRowData(String label, String value) {
    return  Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label :',
          style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'poppins_medium'
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              ' $value',
              // maxLines: 1,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontFamily: 'poppins_regular'
              ),
            ),
          ],
        )
      ],
    );
  }

  ///*
  ///
  /// check null data
  String getData(String? data) {

    if(data != null){
      return data;
    }else{
      return '';
    }
  }

  ///*
  ///
  /// get formatted date
  String getUiDate(String? appointmentDate) {

    log('AppointmentDate all: $appointmentDate');

    String subString = appointmentDate!.substring(0,10);

    log('AppointmentDate substring: $subString');


    DateFormat fromDateFormatter = DateFormat('yyyy/MM/dd');
    DateFormat toDateFormatter = DateFormat('dd MMM yyyy');

    String newDate = '';

    List<String> validadeSplit = subString.split('/');

    if(validadeSplit.length > 1)
    {
      int day = int.parse(validadeSplit[2].toString());
      String month = validadeSplit[1];
      int year = int.parse(validadeSplit[0].toString());

      String date = '$year/$month/$day'; //this format should be same as fromDateFormat

      DateTime appointmentDateTime = fromDateFormatter.parse(date);
      newDate = toDateFormatter.format(appointmentDateTime);
    }
    return newDate;
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
                child: getPatientRowData('Name' , getXController.name.value),),
              Expanded(child: getPatientRowData('Age' , getXController.age.value),)
            ],
          ),

          Row(
            children: [
              Expanded(
                flex: 2,
                child:
                getPatientRowData('Gender' , getXController.gender.value),
              ),
              Expanded(child: getPatientRowData('Date' , getXController.date.value),)

            ],
          ),
          Container(height: 0.5, color: MyColor.searchColor, margin: EdgeInsets.only(top: 10),),

        ],
      ),
    );

  }

}
