import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soowgood/benificiary/controller/beneficiary_view_medical_history_controller.dart';
import 'package:soowgood/benificiary/model/response/appointment_list_response.dart';
import 'package:soowgood/benificiary/screen/beneficiary_prescription_detail_screen.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/common/screen/open_in_browser_screen.dart';

class BeneficiaryViewMedicalHistoryScreen extends StatefulWidget {

  AppointmentListResponse appointmentData;

   BeneficiaryViewMedicalHistoryScreen({Key? key, required this.appointmentData}) : super(key: key);

  @override
  _BeneficiaryViewMedicalHistoryScreenState createState() => _BeneficiaryViewMedicalHistoryScreenState();
}

class _BeneficiaryViewMedicalHistoryScreenState extends State<BeneficiaryViewMedicalHistoryScreen> {

  BeneficiaryViewMedicalHistoryController getXController = Get.put(BeneficiaryViewMedicalHistoryController());


  @override
  void initState() {
    // TODO: implement initState

    getXController.prescriptionList.clear();
    getXController.providerId.value = widget.appointmentData.serviceProviderId!;
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
            appBar: AppBar(
              elevation: 0.5,
              backgroundColor: Colors.white,
              leading: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
              centerTitle: true,
              title: const Text('Medical History'),
            ),
            body: Column(
              children: [

                getProviderWidget(),

                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  color: MyColor.themeTealBlue,
                child: Text('Prescription',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'poppins_semibold'
                ),),),


                getXController.prescriptionList.isNotEmpty?
                Expanded(
                  child: ListView.builder(
                      itemCount: 5,
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
            getRowData('Appointment Id', getData(getXController.prescriptionList[index].appointmentNo)),
            getRowData('Date', prescriptionDate),
            getRowData('Diagnosis', getData(getXController.prescriptionList[index].diognosis)),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              getIconRowData('browser',Icons.open_in_browser, getData(getXController.prescriptionList[index].id), '', '', ''),
              SizedBox(width: 10,),
              getIconRowData('view',Icons.remove_red_eye, getData(getXController.prescriptionList[index].id), widget.appointmentData.serviceProviderId!,
                prescriptionDate, getData(getXController.prescriptionList[index].diognosis),),

            ],)
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
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
  getIconRowData(String type,IconData icon, String prescriptionId, String providerId, String prescriptionDate, String diagnosis) {
    return InkWell(
      onTap: (){
        if(type == 'browser'){
          log('Prescription PDF Name $prescriptionId');
          Get.to(() => OpenInBrowserScreen(url: 'https://api.soowgood.com/prescriptionpdf/$prescriptionId.pdf')); //open pdf url
        }else{
          Get.to(() => BeneficiaryPrescriptionDetailScreen(prescriptionId: prescriptionId,  providerId: providerId, prescriptionDate: prescriptionDate, diagnosis: diagnosis,));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 7,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: type == 'browser' ? Colors.green : MyColor.themeTealBlue
          ),
          child: Icon(icon, color: Colors.white, size: 20,)),
    );


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

  ///*
  ///
  ///
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
  getProviderWidget() {

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: widget.appointmentData.providerImage == null || widget.appointmentData.providerImage!.isEmpty?
                    Image(
                      image: noProfileImage,
                    )
                        : Image.network('${ApiConstant.fileBaseUrl}${ApiConstant.profilePicFolder}${widget.appointmentData.providerImage}',
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.fill, errorBuilder: (BuildContext context,
                            Object exception, StackTrace? stackTrace) {
                          return Image(
                              image: noProfileImage,
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill);
                        }),
                  ),
                ),

                const SizedBox(width: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        widget.appointmentData.serviceProvider!,
                        maxLines: 1,
                        style: const TextStyle(
                            color: MyColor.themeTealBlue,
                            fontSize: 13.0,
                            fontFamily: 'poppins_semibold'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        widget.appointmentData.specializationName!,
                        style: const TextStyle(
                            color: MyColor.themeTealBlue,
                            fontSize: 10.0,
                            fontFamily: 'poppins_regular'),
                      ),
                    ),

                  ],
                )
              ],
            ),

            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Appointment Date',
                  style: TextStyle(
                      fontSize: 11,
                      color: MyColor.themeTealBlue,
                      fontFamily: 'poppins_medium'
                  ),),

                Text(
                  widget.appointmentData.tentativeAppointmentDate!,
                  style: const TextStyle(
                      fontSize: 10,
                      color: MyColor.themeTealBlue,
                      fontFamily: 'poppins_regular'
                  ),),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(
                'Appointment Time',
                style: TextStyle(
                    fontSize: 11,
                    color: MyColor.themeTealBlue,
                    fontFamily: 'poppins_medium'
                ),),

              Text(
                '${widget.appointmentData.scheduleStartTime!} - ${widget.appointmentData.scheduleEndTime!}',
                style: const TextStyle(
                    fontSize: 10,
                    color: MyColor.themeTealBlue,
                    fontFamily: 'poppins_regular'
                ),),
            ],)

          ],
        ),
      ),
    );

  }

}

