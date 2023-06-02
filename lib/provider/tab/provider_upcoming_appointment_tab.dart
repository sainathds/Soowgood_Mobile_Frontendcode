import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_home_controller.dart';
import 'package:soowgood/provider/screen/provider_view_medical_history_screen.dart';

class ProviderUpcomingAppointmentTab extends StatefulWidget {
  const ProviderUpcomingAppointmentTab({Key? key}) : super(key: key);

  @override
  _ProviderUpcomingAppointmentTabState createState() => _ProviderUpcomingAppointmentTabState();
}

class _ProviderUpcomingAppointmentTabState extends State<ProviderUpcomingAppointmentTab> {

  ProviderHomeController getXController = Get.put(ProviderHomeController());

  @override
  void initState() {
    // TODO: implement initState
    getXController.upcomingAppointmentList.clear();
    Future.delayed(const Duration(), (){
      getXController.getAppointmentsResponse('Upcoming');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child:
        getXController.upcomingAppointmentList.isNotEmpty?
        ListView.builder(
            itemCount: getXController.upcomingAppointmentList.length,
            itemBuilder: (context, index){
              return getRecentAppointments(index);
            })
            : const Center(child: Text('No Data Found', style:  TextStyle(fontSize: 16, color: MyColor.searchColor, fontFamily: 'poppins_medium'),),),
      );
    });
  }


  ///*
  ///
  ///
  getRecentAppointments(int index) {
    return Card(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        // side:  BorderSide(color: MyColor.tealBlueDark, width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
        child: Column(
          children: [
            getPatientData(index),

            getAppointmentDetails(index)

          ],
        ),
      ),
    );
  }


  ///*
  ///
  ///
  getPatientData(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: getXController.upcomingAppointmentList[index].receiverImage == null || getXController.upcomingAppointmentList[index].receiverImage!.isEmpty?
                  Image(
                    image: noProfileImage,
                  )
                      : Image.network('${ApiConstant.fileBaseUrl}${ApiConstant.profilePicFolder}${getXController.upcomingAppointmentList[index].receiverImage}',
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getData(getXController.upcomingAppointmentList[index].serviceReceiver!),
                      maxLines: 1,
                      style: TextStyle(
                          color: MyColor.themeTealBlue,
                          fontSize: 13.0,
                          fontFamily: 'poppins_semibold'),
                    ),

                    getData(getXController.upcomingAppointmentList[index].age.toString()) != ''?
                    Text(
                      'Age ${getData(getXController.upcomingAppointmentList[index].age.toString())} years',
                      maxLines: 1,
                      style: TextStyle(
                          color: MyColor.themeTealBlue,
                          fontSize: 10.0,
                          fontFamily: 'poppins_medium'),
                    ):SizedBox(),

                    Row(
                      children: [

                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
                            margin: const EdgeInsets.only(top: 5, ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.orange
                            ),
                            child:  Text(
                              getData(getXController.upcomingAppointmentList[index].appointmentNo),
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'poppins_medium',
                                  color: Colors.white
                              ),
                            )
                        ),

                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.green
                            ),
                            child:  Text(
                              getData(getXController.upcomingAppointmentList[index].appointmentTypeName),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'poppins_semibold',
                                  fontSize: 10.0
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),

              // getXController.appointmentList[index].appointmentStatus != 'Cancelled'?
              Row(
                children: [

                  InkWell(
                    onTap: (){
                      compairTime(index);

                      // getXController.getTwilioAccessTokenResponse(getXController.upcomingAppointmentList[index].id!);
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black,)
                        ),
                        child: const Icon(Icons.call, size: 20,)),

                  ),

                  PopupMenuButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.more_vert, color: Colors.black,),
                      // add this line
                      itemBuilder: (_) => <PopupMenuItem<String>>[
                         const PopupMenuItem<String>(
                            padding: EdgeInsets.only(left: 10),
                            value: 'Cancel',
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'popins_regular',
                              ),
                            )),
                        const PopupMenuItem<String>(
                            padding: EdgeInsets.only(left: 10),
                            value: 'View Medical History',
                            child: Text(
                              "View Medical History",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'popins_regular',
                              ),
                            ))


                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 'Cancel':
                            getXController.getCheckCancelAppointmentResponse(index, 'Upcoming');
                            break;
                          case 'View Medical History':
                            Get.to(() => ProviderViewMedicalHistoryScreen(serviceReceiverId: getXController.upcomingAppointmentList[index].serviceReceiverId!,));
                            break;
                        }
                      }),
                ],
              )/*: SizedBox()*/
            ],
          ),

/*
          Row(
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 10, top: 5, bottom: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.orangeAccent
                    ),
                    child:  Text(
                      getData(getXController.upcomingAppointmentList[index].appointmentNo),
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins_medium'
                      ),
                    )
                ),
              ),

              Expanded(
                child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only( top: 5, bottom: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: MyColor.selectedOtp
                    ),
                    child: const Text(
                      'New Patient',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'poppins_medium'
                      ),
                    )
                ),
              ),

            ],
          )
*/
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getAppointmentDetails(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          getRowData('Clinic Name', getData(getXController.upcomingAppointmentList[index].clinicName)),
          getRowData('Appointment Date', getData(getXController.upcomingAppointmentList[index].scheduleAppointmentDate)),
          getRowData('Appointment Time', getData(getXController.upcomingAppointmentList[index].scheduleStartTime)),
          getRowData('Paid Amount', getData(getXController.upcomingAppointmentList[index].appointmentFees.toString())),
          getRowData('Payment Status', getData(getXController.upcomingAppointmentList[index].userPaymentStatus)),
          getRowData('Status', getData(getXController.upcomingAppointmentList[index].appointmentStatus)),
          getRowData('Last Visit', getData(getXController.upcomingAppointmentList[index].lastApointmentDate)),


        ],
      ),
    );
  }


  ///*
  ///
  ///
  getRowData(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
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

          Text(
            value,
            style: TextStyle(
                fontSize: 12,
                color: label == 'Status' ? Colors.deepOrangeAccent : Colors.black,
                fontFamily: label == 'Status' ? 'poppins_semibold' : 'poppins_regular'
            ),
          )

        ],
      ),
    );
  }

  ///*
  ///
  ///
  String getData(String? data) {
    if(data != null && data != ''){
      return data;
    }else{
      return '';
    }
  }

  ///*
  ///
  ///
  void compairTime(int index) {

    DateTime nowTime = DateTime.now();

    log('DATE_TIME ${nowTime.toString()}');

    String appointmentDate = getXController.upcomingAppointmentList[index].scheduleAppointmentDate!;

    if(appointmentDate == 'Today'){
      appointmentDate = '${nowTime.year}-${nowTime.month}-${nowTime.day}';
    }else {
      appointmentDate = getFormattedDate(appointmentDate);
      log('FormatedAppDate $appointmentDate');
    }

    DateTime fromTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse("$appointmentDate ${getXController.upcomingAppointmentList[index].scheduleStartTime!}"); //10am
    DateTime toTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse("$appointmentDate ${getXController.upcomingAppointmentList[index].scheduleEndTime!}"); //10am


    if(nowTime == fromTime || (nowTime.isAfter(fromTime) && nowTime.isBefore(toTime))){

      getXController.getTwilioAccessTokenResponse(getXController.upcomingAppointmentList[index].id!);

    }else if(nowTime.isBefore(fromTime)){
      log('Check Schedule');
      showDialog(context: context,
          builder: (BuildContext context){
            return OKDialog(
                title: '',
                descriptions: 'Please check Appointment Schedule',
                img: errorImage);
          });

    }else if(nowTime.isAfter(toTime)){
      log('Appointment schedule is over, you can'+"'"+'t call your Patient ');
      showDialog(context: context,
          builder: (BuildContext context){
            return OKDialog(
                title: '',
                descriptions: 'Appointment schedule is over, you can'+"'"+'t call your Patient',
                img: errorImage);
          });
    }


  }

  ///*
  ///
  ///
  String getFormattedDate(String appointmentDate) {

    DateFormat fromDateFormatter = DateFormat('dd MMM yyyy');
    DateFormat toDateFormatter = DateFormat('yyyy-MM-dd');

    String newDate = '';

    List<String> validadeSplit = appointmentDate.split(' ');

    if(validadeSplit.length > 1)
    {
      int day = int.parse(validadeSplit[0].toString());
      String month = validadeSplit[1];
      int year = int.parse(validadeSplit[2].toString());

      String date = '$day $month $year'; //this format should be same as fromDateFormat

      DateTime appointmentDateTime = fromDateFormatter.parse(date);
      newDate = toDateFormatter.format(appointmentDateTime);
    }
    return newDate;
  }


}
