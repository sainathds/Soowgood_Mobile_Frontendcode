import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soowgood/benificiary/controller/beneficiary_dashboard_controller.dart';
import 'package:soowgood/benificiary/screen/beneficiary_appointments_screen.dart';
import 'package:soowgood/benificiary/screen/beneficiary_view_medical_history_screen.dart';
import 'package:soowgood/benificiary/screen/beneficiry_doctors_screen.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';

class BeneficiaryDashboardScreen extends StatefulWidget {
  const BeneficiaryDashboardScreen({Key? key}) : super(key: key);

  @override
  _BeneficiryDashboardScreenState createState() => _BeneficiryDashboardScreenState();
}

class _BeneficiryDashboardScreenState extends State<BeneficiaryDashboardScreen> {

  BeneficiaryDashboardController getXController =  Get.put(BeneficiaryDashboardController());

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(const Duration(), (){
      getXController.getProfileResponse();
    });

    Future.delayed(const Duration(), (){
      getXController.getDoctorCount();
    });
    Future.delayed(const Duration(), (){
      getXController.getAppointmentCount();
    });
    Future.delayed(const Duration(), (){
      getXController.getAppointmentListResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
    ),
    child: Obx((){
      return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text('Dashboard',
            style: TextStyle(
                color: MyColor.themeTealBlue,
                fontSize: 17.0,
                fontFamily: 'poppins_semibold'
            ),),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                notificationCountWidget(),
              ],
            ),
          ],
        ),


        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              getWelcomeWidget(),

              const SizedBox(height: 10,),

              getCountWidget(),

              const SizedBox(height: 10),
              Row(children: [
                const Text('Recent Appointments',
                    style: TextStyle(
                        fontSize: 16,
                        color: MyColor.themeTealBlue,
                        fontFamily: 'poppins_semibold'
                    ))
              ],),
              const SizedBox(height: 10),
              getXController.appointmentList.isNotEmpty?
              getRecentAppointment():const Text('No Data Found',
                style: TextStyle(
                fontSize: 12,
                color: Colors.black38,
                fontFamily: 'poppins_semibold'
              ),)
            ],
          ),
        ),
      );
    }));
  }


  ///*
  ///
  ///
  Widget notificationCountWidget() {
    return InkWell(
      onTap: () async{
        /* var nav = await Get.to(() => NotificationListScreen(userType: 'Customer',));
        if(nav == null){
          _getXController.hitNotificationCountApi();
        }*/
      },
      child: Container(
        width: 50,
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              bottom: 0,
              left: 5,
              child: Icon(
                Icons.notifications_none_rounded,
                color: MyColor.themeTealBlue,
              ),
            ),

            // _getXController.notificationCount != 0?
            Positioned(
              top: 10,
              right: 15,
              child: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColor.skyBlueLight,
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: const Text(
                  '0',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'poppins_medium',
                      fontSize: 10),
                ),
              ),
            )
            // SizedBox()
          ],
        ),
      ),
    );

  }


  ///*
  ///
  ///
  getWelcomeWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: MyColor.lightGreenBlue
      ),
      child: Row(
        children: [

          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const Text(
                  'Welcome',
                  style: TextStyle(
                      color: MyColor.themeTealBlue,
                      fontSize: 16.0,
                      fontFamily: 'poppins_semibold'
                  ),
                ),

                const SizedBox(height: 3,),
                Text(
                  getXController.userName.value,
                  style: const TextStyle(
                      color: MyColor.themeTealBlue,
                      fontSize: 16.0,
                      fontFamily: 'poppins_semibold'
                  ),
                ),

                const SizedBox(height: 3,),
                const Text(
                  'Welcome To Your Heath Dashboard',
                  style: TextStyle(
                      color: MyColor.themeTealBlue,
                      fontSize: 12.0,
                      fontFamily: 'poppins_regular'
                  ),
                )

              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Image(
              image: providerWelcomeDashImg,
            ),
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getCountWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: MyColor.teal50
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white
              ),
              child: getCount(totalAppointmentIc, 'All Appointments'),),
          ),

          const SizedBox(width: 10,),

          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white
              ),
              child: getCount(totalDoctorIc, 'Doctors'),),
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getCount(AssetImage image, String label) {

    return InkWell(
      onTap: (){
        if(label == 'All Appointments'){
          Get.to(() =>  BeneficiaryAppointmentsScreen(callFrom: 'Dashboard',));

        }else{
          Get.to(() => BeneficiaryDoctorsScreen(searchText: '',fromHome: 'true',));
        }
      },
      child: Row(
        children: [
          Image(image: image, height: 35, width: 35,),

          const SizedBox(width: 5,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: MyColor.themeTealBlue,
                  fontFamily: 'poppins_medium'
                ),
              ),

              Text(
                label == 'All Appointments'? getXController.appointmentCount.value : getXController.doctorCount.value,
                style: const TextStyle(
                    fontSize: 17,
                    color: MyColor.themeTealBlue,
                    fontFamily: 'poppins_semibold'
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getRecentAppointment() {
    return Expanded(
      child: ListView.builder(
        itemCount: getXController.appointmentList.length,
          itemBuilder: (context, index){
            return Card(
              child: Column(

                  children: [
                    getProviderData(index),

                    getAppointmentData(index),

                  ],
              ),
            );
          }),
    );
  }


  ///*
  ///
  ///
  getProviderData(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: getXController.appointmentList[index].providerImage == null || getXController.appointmentList[index].providerImage!.isEmpty?
                   Image(
                image: noProfileImage,
              )
                  : Image.network('${ApiConstant.fileBaseUrl}${ApiConstant.profilePicFolder}${getXController.appointmentList[index].providerImage}',
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.fill,
                  errorBuilder: (BuildContext context,
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
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getXController.appointmentList[index].serviceProvider!,
                  maxLines: 1,
                  style: const TextStyle(
                      color: MyColor.themeTealBlue,
                      fontSize: 13.0,
                      fontFamily: 'poppins_semibold'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(
                    getXController.appointmentList[index].specializationName!,
                    maxLines: 1,
                    style: const TextStyle(
                        color: MyColor.themeTealBlue,
                        fontSize: 10.0,
                        fontFamily: 'poppins_regular'),
                  ),
                ),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                      margin: const EdgeInsets.only(top: 5,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.green
                      ),
                      child: Text(
                        getXController.appointmentList[index].appointmentTypeName!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins_semibold',
                            fontSize: 10.0
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                      margin: const EdgeInsets.only(top: 5, left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: getXController.appointmentList[index].appointmentStatus! == 'Confirmed' ? MyColor.themeTealBlue :
                                 getXController.appointmentList[index].appointmentStatus! == 'Complete' ? Colors.green : MyColor.redBrown
                      ),
                      child: Text(
                        getXController.appointmentList[index].appointmentStatus!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins_semibold',
                            fontSize: 10.0
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Row(
            children: [
              getXController.appointmentList[index].appointmentTypeName == 'Online'?
              InkWell(
                onTap: (){
                  compairTime(index); //compare appointment time with current time before video call
                  // getXController.getTwilioAccessTokenResponse(getXController.appointmentList[index].id!);
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
              ): const SizedBox(),


              PopupMenuButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.more_vert, color: Colors.black,),
                  // add this line
                  itemBuilder: (_) => <PopupMenuItem<String>>[
                    getXController.appointmentList[index].appointmentStatus != 'Cancelled'? const PopupMenuItem<String>(
                        padding: EdgeInsets.only(left: 10),
                        value: 'Cancel',
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'popins_regular',
                          ),
                        ))   :const PopupMenuItem(child: SizedBox()),
                    const PopupMenuItem<String>(
                        padding: EdgeInsets.only(left: 10),
                        value: 'View Medical History',
                        child: Text(
                          "View Medical History",
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'popins_regular',
                          ),
                        )),
                  ],
                  onSelected: (value) {
                    switch (value) {
                      case 'Cancel':
                        getXController.getCheckCancelAppointmentResponse(index);
                        /*showDialog(
                        context: context,
                        builder: (context){
                          return AskDialog(msg: 'Are you sure you want to Cancel Appointment', yesFunction: yesFunction);
                        });*/
                        break;
                      case 'View Medical History':
                        Get.to(() => BeneficiaryViewMedicalHistoryScreen(appointmentData: getXController.appointmentList[index]));
                        break;
                    }
                  })
            ],
          )

        ],
      ),
    );
  }

  ///*
  ///
  ///
  getAppointmentData(int index) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  leading: const Icon(Icons.calendar_today, color: Colors.green, size:18,),
                  title: Transform.translate(
                    offset: const Offset(-35, 0),
                    child: const Text(
                      'Appointment Date',
                      style: TextStyle(
                          fontSize: 11,
                          color: MyColor.themeTealBlue,
                          fontFamily: 'poppins_medium'
                      ),),
                  ),
                  subtitle: Transform.translate(
                    offset: const Offset(-35,0),
                    child: Text(
                        getXController.appointmentList[index].tentativeAppointmentDate!,
                      style: const TextStyle(
                          fontSize: 10,
                          color: MyColor.themeTealBlue,
                          fontFamily: 'poppins_regular'
                      ),),
                  ),
                ),
              ),


              Expanded(
                child: Container(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    leading: const Icon(Icons.access_time, color: Colors.deepOrange, size:18,),
                    title: Transform.translate(
                      offset: const Offset(-35, 0),
                      child: const Text(
                        'Appointment Time',
                        style: TextStyle(
                            fontSize: 11,
                            color: MyColor.themeTealBlue,
                            fontFamily: 'poppins_medium'
                        ),),
                    ),
                    subtitle: Transform.translate(
                      offset: const Offset(-35, 0),
                      child: Text(
                        '${getXController.appointmentList[index].scheduleStartTime!} - ${getXController.appointmentList[index].scheduleEndTime!}',
                        style: const TextStyle(
                            fontSize: 10,
                            color: MyColor.themeTealBlue,
                            fontFamily: 'poppins_regular'
                        ),),
                    ),
                  ),
                ),
              ),
            ],
          ),


          Row(
            children: [
              Expanded(
                child: ListTile(
                  visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person_pin_rounded, color: Colors.orangeAccent, size:18,),
                  title: Transform.translate(
                    offset: const Offset(-35, 0),
                    child: const Text(
                      'Attendee Name',
                      style: TextStyle(
                          fontSize: 11,
                          color: MyColor.themeTealBlue,
                          fontFamily: 'poppins_medium'
                      ),),
                  ),
                  subtitle: Transform.translate(
                    offset: const Offset(-35, 0),
                    child: Text(
                     getXController.appointmentList[index].patientName!,
                      style: const TextStyle(
                          fontSize: 10,
                          color: MyColor.themeTealBlue,
                          fontFamily: 'poppins_regular'
                      ),),
                  ),
                ),
              ),


              Expanded(
                child: Container(
                  child: ListTile(
                    visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.account_balance_wallet, color: Colors.purple, size:18,),
                    title: Transform.translate(
                      offset: const Offset(-35, 0),
                      child: const Text(
                        'Amount',
                        style: TextStyle(
                            fontSize: 11,
                            color: MyColor.themeTealBlue,
                            fontFamily: 'poppins_medium'
                        ),),
                    ),
                    subtitle: Transform.translate(
                      offset: const Offset(-35, 0),
                      child: Text(
                        'BDT ${getXController.appointmentList[index].appointmentFees!}',
                        style: const TextStyle(
                            fontSize: 10,
                            color: MyColor.themeTealBlue,
                            fontFamily: 'poppins_regular'
                        ),),
                    ),
                  ),
                ),
              ),
            ],
          ),

          ListTile(
            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.home_outlined, color: Colors.redAccent, size:18,),
            title: Transform.translate(
              offset: const Offset(-35, 0),
              child: const Text(
                'Place',
                style: TextStyle(
                    fontSize: 11,
                    color: MyColor.themeTealBlue,
                    fontFamily: 'poppins_medium'
                ),),
            ),
            subtitle: Transform.translate(
              offset: const Offset(-35, 0),
              child: Text(
                getXController.appointmentList[index].address!,
                style: const TextStyle(
                    fontSize: 10,
                    color: MyColor.themeTealBlue,
                    fontFamily: 'poppins_regular'
                ),),
            ),
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  showDetails(int index){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return getAppointmentDetail(index);
        });


  }


  ///*
  ///
  ///
  getAppointmentDetail(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getProviderData(index),

            getTotalAmountDetail(index)
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  getTotalAmountDetail(int index) {
    return Column(
      children: [
        getRowData('Booking Date', getXController.appointmentList[index].bookingDate),

        getRowData('Appointment D/T', getXController.appointmentList[index].schedule!),

        getRowData('Status', getXController.appointmentList[index].status),

        getRowData('Place', getXController.appointmentList[index].clinicAddress!),

        getRowData('Total Amount \n( Doctor + Service Charge )', getXController.appointmentList[index].paidAmount.toString()),

      ],
    );
  }

  ///*
  ///
  ///
  getRowData(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 13,
                color: MyColor.themeTealBlue,
                fontFamily: 'poppins_medium'
            ),),

          Text(
            value == null ? '': value,
            style: const TextStyle(
                fontSize: 10,
                color: MyColor.themeTealBlue,
                fontFamily: 'poppins_regular'
            ),),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  void compairTime(int index) {

    DateTime nowTime = DateTime.now();

    log('DATE_TIME ${nowTime.toString()}');

    String appointmentDate = getXController.appointmentList[index].tentativeAppointmentDate!;

    if(appointmentDate == 'Today'){
      appointmentDate = '${nowTime.year}-${nowTime.month}-${nowTime.day}';
    }else {
      appointmentDate = getFormattedDate(appointmentDate);
      log('FormatedAppDate $appointmentDate');
    }

    DateTime fromTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse("$appointmentDate ${getXController.appointmentList[index].scheduleStartTime!}"); //10am
    DateTime toTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse("$appointmentDate ${getXController.appointmentList[index].scheduleEndTime!}"); //10am


    if(nowTime == fromTime || (nowTime.isAfter(fromTime) && nowTime.isBefore(toTime))){

      //get token using api to make video call
      getXController.getTwilioAccessTokenResponse(getXController.appointmentList[index].id!);

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
      log('Appointment schedule is over, you can'+"'"+'t call your Doctor ');
      showDialog(context: context,
          builder: (BuildContext context){
            return OKDialog(
                title: '',
                descriptions: 'Appointment schedule is over, you can'+"'"+'t call your Doctor',
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
