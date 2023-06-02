import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soowgood/benificiary/controller/previous_appointment_controller.dart';
import 'package:soowgood/benificiary/model/response/appointment_list_response.dart';
import 'package:soowgood/benificiary/screen/beneficiary_view_medical_history_screen.dart';
import 'package:soowgood/common/dialog/ok_dialog.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';

class
PreviousAppointmentTab extends StatefulWidget {
  const PreviousAppointmentTab({Key? key}) : super(key: key);

  @override
  _PreviousAppointmentTabState createState() => _PreviousAppointmentTabState();
}

class _PreviousAppointmentTabState extends State<PreviousAppointmentTab> {


  PreviousAppointmentController getXController = Get.put(PreviousAppointmentController());

  @override
  void initState() {
    // TODO: implement initState
    getXController.searchController.clear();
    getXController.appointmentList.clear();
    Future.delayed(const Duration(), (){
      getXController.getAppointmentListResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            getSearchWidget(),
            getXController.appointmentList.isNotEmpty?
            getRecentAppointment():SizedBox(),
          ],
        )
      );
    });
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
                      padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                      margin: EdgeInsets.only(top: 5,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.green
                      ),
                      child: Text(
                        getXController.appointmentList[index].appointmentTypeName!,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins_semibold',
                            fontSize: 10.0
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                      margin: EdgeInsets.only(top: 5, left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: getXController.appointmentList[index].appointmentStatus! == 'Confirmed' ? MyColor.themeTealBlue :
                                 getXController.appointmentList[index].appointmentStatus! == 'Complete' ? Colors.green : MyColor.redBrown
                      ),
                      child: Text(
                        getXController.appointmentList[index].appointmentStatus!,
                        style: TextStyle(
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
                  // getXController.getTwilioAccessTokenResponse(getXController.appointmentList[index].id!);
                  compairTime(index);
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
              ): SizedBox(),


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
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Icon(Icons.calendar_today, color: Colors.green, size:18,),
                  title: Transform.translate(
                    offset: Offset(-35, 0),
                    child: Text(
                      'Appointment Date',
                      style: TextStyle(
                          fontSize: 11,
                          color: MyColor.themeTealBlue,
                          fontFamily: 'poppins_medium'
                      ),),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(-35,0),
                    child: Text(
                      getXController.appointmentList[index].tentativeAppointmentDate!,
                      style: TextStyle(
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
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    leading: Icon(Icons.access_time, color: Colors.deepOrange, size:18,),
                    title: Transform.translate(
                      offset: Offset(-35, 0),
                      child: Text(
                        'Appointment Time',
                        style: TextStyle(
                            fontSize: 11,
                            color: MyColor.themeTealBlue,
                            fontFamily: 'poppins_medium'
                        ),),
                    ),
                    subtitle: Transform.translate(
                      offset: Offset(-35, 0),
                      child: Text(
                        '${getXController.appointmentList[index].scheduleStartTime!} - ${getXController.appointmentList[index].scheduleEndTime!}',
                        style: TextStyle(
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
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.person_pin_rounded, color: Colors.orangeAccent, size:18,),
                  title: Transform.translate(
                    offset: Offset(-35, 0),
                    child: Text(
                      'Attendee Name',
                      style: TextStyle(
                          fontSize: 11,
                          color: MyColor.themeTealBlue,
                          fontFamily: 'poppins_medium'
                      ),),
                  ),
                  subtitle: Transform.translate(
                    offset: Offset(-35, 0),
                    child: Text(
                      getXController.appointmentList[index].patientName!,
                      style: TextStyle(
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
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.account_balance_wallet, color: Colors.purple, size:18,),
                    title: Transform.translate(
                      offset: Offset(-35, 0),
                      child: Text(
                        'Amount',
                        style: TextStyle(
                            fontSize: 11,
                            color: MyColor.themeTealBlue,
                            fontFamily: 'poppins_medium'
                        ),),
                    ),
                    subtitle: Transform.translate(
                      offset: Offset(-35, 0),
                      child: Text(
                        'BDT ${getXController.appointmentList[index].appointmentFees!}',
                        style: TextStyle(
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
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.home_outlined, color: Colors.redAccent, size:18,),
            title: Transform.translate(
              offset: Offset(-35, 0),
              child: Text(
                'Place',
                style: TextStyle(
                    fontSize: 11,
                    color: MyColor.themeTealBlue,
                    fontFamily: 'poppins_medium'
                ),),
            ),
            subtitle: Transform.translate(
              offset: Offset(-35, 0),
              child: Text(
                getXController.appointmentList[index].address!,
                style: TextStyle(
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
  getFilerList(){
    getXController.appointmentListNew.clear();
    getXController.appointmentListNew.addAll(getXController.appointmentList);
    getXController.appointmentList.clear();
    for (AppointmentListResponse appointment in getXController.appointmentListNew) {
      if (appointment.serviceProvider!.toLowerCase().contains(getXController.searchController.text.trim().toLowerCase())) {
        getXController.appointmentList.add(appointment);
      }
    }
  }

  ///*
  ///
  ///
  getSearchWidget() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(top: 5, left: 10),
            height: 40,
            child: TextFormField(
              controller: getXController.searchController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (query) async{
                if(getXController.searchController.text.trim().isNotEmpty){
                  getFilerList();
                }
              },
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide:  BorderSide(color: MyColor.searchBgColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:  BorderSide(color: MyColor.searchBgColor),
                  ),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: MyColor.searchBgColor,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 15.0),
                  hintText: 'Search by Doctors',
                  hintStyle: const TextStyle(
                      fontSize: 13.0,
                      color: MyColor.searchColor,
                      fontFamily: 'poppins_medium'),
                  suffixIcon: getXController.isShow.value ? InkWell(
                    onTap: (){
                      getXController.isShow.value = false;
                      getXController.searchController.clear();

                      if(getXController.appointmentListNew.isNotEmpty){
                        getXController.appointmentList.clear();
                        getXController.appointmentList.addAll(getXController.appointmentListNew);
                      }
                    },
                    child: const Icon(
                      Icons.clear,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ): const SizedBox()),

              onChanged: (value){
                if(value.isEmpty){
                  if(getXController.appointmentListNew.isNotEmpty){
                    getXController.appointmentList.clear();
                    getXController.appointmentList.addAll(getXController.appointmentListNew);
                  }
                  getXController.isShow.value = false;
                }else{
                  getXController.isShow.value = true;
                }
              },
            ),
          ),
        ),

        InkWell(
          onTap: (){
            getFilerList();
          },
          child: Container(
            height: 40,
            width: 45,
            margin: const EdgeInsets.only(top: 5, right: 10),
            decoration: const BoxDecoration(
                color: MyColor.themeSkyBlue,
                borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))
            ),
            child: const Icon(Icons.person_search_outlined, color: Colors.white,),
          ),
        )
      ],
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
