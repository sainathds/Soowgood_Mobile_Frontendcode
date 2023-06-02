import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:soowgood/benificiary/screen/beneficiary_appointments_screen.dart';
import 'package:soowgood/common/controller/notification_list_controller.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';

import '../../provider/screen/provider_appointments_screen.dart';
import '../dialog/custom_progress_dialog.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  NotificationListController getXController = Get.put(NotificationListController());
  CustomProgressDialog progressDialog = CustomProgressDialog();
  
  @override
  void initState() {
    // TODO: implement initState
    getXController.isBack.value = false;
    Future.delayed(Duration(), () {
      getApiData();
    });
    super.initState();
  }
  getApiData()async{
    progressDialog.showProgressDialog();
   await getXController.getNotificationListResponse().then((value) => progressDialog.close());
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Obx((){
        return WillPopScope(
            onWillPop: onWillPop,
            child: Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: InkWell(
                    onTap: () {
                      Get.back(result: getXController.isBack.value);
                    },
                    child: Image(
                      image: backArrowWhiteIcon,
                      color: Colors.black,
                    )),
                title: Text('Notifications'),
                actions: [

                  getXController.notificationList.isNotEmpty?
                  InkWell(
                      onTap: () {
                        getXController.deleteAllNotifications();
                      },
                      child: Icon(Icons.delete_outline_outlined)) : SizedBox(),
                  SizedBox(
                    width: 20,
                  ),
                  getXController.notificationList.isNotEmpty && getXController.notificationList[0].isread == 0
                      ? InkWell(
                      onTap: () {
                        if (getXController.notificationList[0].isread != 1) {
                          getXController.readNotificationResponse();
                        }
                      },
                      child: Icon(Icons.mark_email_read_outlined))
                      : SizedBox(),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [getXController.notificationList.isNotEmpty ? Expanded(child: showNotifications()) : Center(child: Text('No Data Found'))],
                ),
              ),
            )
        );
      })

    );
  }

  ///*
  ///
  ///
  showNotifications() {
    return ListView.builder(
        itemCount: getXController.notificationList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              if(getXController.notificationList[index].usertype == "Provider"){
                Get.to(() => const ProviderAppointmentsScreen());
              } else {
                Get.to(() => BeneficiaryAppointmentsScreen(callFrom: "Dashboard"));
              }
            },
            child: Card(
              elevation: 0,
              color: getXController.notificationList[index].isread == 1 ? Colors.white : MyColor.skyBlueLight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getData(getXController.notificationList[index].notificationtype),
                      style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'poppins_medium'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      getData(getXController.notificationList[index].notificationtext),
                      style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'poppins_regular'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          getUiDate(getData(getXController.notificationList[index].notificationdate)),
                          style: TextStyle(color: Colors.redAccent, fontSize: 12, fontFamily: 'poppins_regular'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///*
  ///
  ///
  String getData(String? data) {
    if (data != null) {
      return data;
    } else {
      return '';
    }
  }

  ///*
  ///
  /// 2022/11/09 05:31 PM
  String getUiDate(String? date) {
    String subString = date!.substring(0, 10);
    String time = date.substring(11, date.length);

    DateFormat fromDateFormatter = DateFormat('yyyy/MM/dd');
    DateFormat toDateFormatter = DateFormat('MMMM dd, yyyy');

    String newDate = '';

    List<String> validadeSplit = subString.split('/');

    if (validadeSplit.length > 1) {
      int day = int.parse(validadeSplit[2].toString());
      String month = validadeSplit[1];
      int year = int.parse(validadeSplit[0].toString());

      String date = '$year/$month/$day'; //this format should be same as fromDateFormat

      DateTime appointmentDateTime = fromDateFormatter.parse(date);
      newDate = '${toDateFormatter.format(appointmentDateTime)} $time';
    }
    return newDate;
  }

  ///
  ///
  ///
  Future<bool> onWillPop() async{
    Get.back(result: getXController.isBack.value);
    return false;
  }
}
