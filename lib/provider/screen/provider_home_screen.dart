import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/conference/conference_page.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/common/screen/login_screen.dart';
import 'package:soowgood/common/screen/notification_list_screen.dart';
import 'package:soowgood/common/screen/video_call_test_screen.dart';
import 'package:soowgood/provider/controller/provider_home_controller.dart';
import 'package:soowgood/provider/tab/provider_recent_appointment_tab.dart';
import 'package:soowgood/provider/tab/provider_upcoming_appointment_tab.dart';

class ProviderHomeScreen extends StatefulWidget {
  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  _ProviderHomeScreenState createState() => _ProviderHomeScreenState();
}

class _ProviderHomeScreenState extends State<ProviderHomeScreen> {

  ProviderHomeController getXController = Get.put(ProviderHomeController());
  late Size size;

  @override
  void initState() {

    // TODO: implement initState

    Future.delayed(const Duration(), (){
      getXController.getNotificationListResponse();
    });

    Future.delayed(const Duration(), (){
      getXController.getProfileApprovedResponse();
    });

    Future.delayed(const Duration(), (){
      getXController.getTodayAppointmentCount();
    });

    Future.delayed(const Duration(), (){
      getXController.getProfileResponse();
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Obx((){
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text('Soowgood'),
            actions: [

              notificationCountWidget(),
              /*InkWell(
                  onTap: (){
                    Get.to(() => NotificationListScreen());
                  },
                  child: const Icon(Icons.notifications_none_rounded)),*/
              const SizedBox(width: 20,)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            child: Column(
              children: [

                getWelcomeWidget(),

                !getXController.isProfileApproved.value?
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Your Profile Is Under Approval',
                    style: TextStyle(
                        color: MyColor.themeTealBlue,
                        fontSize: 18.0,
                        fontFamily: 'poppins_semibold'
                    ),
                  ),
                ): const SizedBox(),

                getCountWidget(),

                Expanded(child: getTabWidget())

                // getOnGoingAppointments(),

              ],
            ),
          )
      );
    });
  }

  ///*
  ///
  ///
  getWelcomeWidget() {

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      width: size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: MyColor.darkPink
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
  getCountWidget(){
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: MyColor.teal50
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child:getCount(todayAppointmentIc, 'Today Appointments', getXController.todayAppointmentCount.value),

              ),

              const SizedBox(width: 10,),
              Expanded(
                child: getCount(nextScheduleIc, 'Next Schedule', getXController.nextScheduleCount.value),
              ),

              /*Expanded(
                child: getCount(totalDoctorIc, 'Your Clinics', getXController.yourClinicsCount.value),
              ),*/
            ],
          ),

          const SizedBox(height: 5,),
          Row(
            children: [
              Expanded(
                child: getCount(yourClinicsIc, 'Your Clinics', getXController.yourClinicsCount.value),
              ),

              const SizedBox(width: 10,),
              Expanded(
                child: getCount(todayBillIc, 'Today Bill', getXController.todayBillCount.value),
              ),

            ],
          ),

          const SizedBox(height: 5,),
          getProfileCount(profileCompleteIc, 'Profile Complete',
              '${getXController.profileCompleteCount.value}%'),
        ],
      ),
    );

  }




  ///*
  ///
  /// common widget to show count of
  /// Today Appointments, Next schedule, clinics, and today bill
  getCount(AssetImage image, String label, String value) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white
      ),
      child: Row(
        children: [
          Image(image: image, height: 30, width: 30,),

          const SizedBox(width: 5,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 10,
                      color: MyColor.themeTealBlue,
                      fontFamily: 'poppins_semibold'
                  ),
                ),

                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      color: MyColor.themeTealBlue,
                      fontFamily: 'poppins_semibold'
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }



  ///*
  ///
  ///
  getTabWidget() {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: MyColor.black05,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom:   const TabBar(
                labelColor: Colors.blue,
                labelStyle: TextStyle(
                  fontFamily: 'poppins_semibold',
                  fontSize: 14
                ),
                indicatorColor: Colors.blue,
                // indicatorSize: TabBarIndicatorSize.label,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorWeight: 2,
                unselectedLabelColor: Colors.black,


                tabs: [
                  Tab(
                    height: 38,
                    child: Text(
                        'Recent',

                    ),
                  ),
                  Tab(
                    height: 38,
                    child: Text(
                      'Upcoming',

                    ),
                  ),

                ],

              ),
            ),
          ),
          body:   const TabBarView(
            children: [


              ProviderRecentAppointmentTab(),
              ProviderUpcomingAppointmentTab(),

            ],
          ),
        ));

  }

  ///*
  ///
  ///
  getProfileCount(AssetImage totalDoctorIc, String label, String value) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image(image: totalDoctorIc, height: 30, width: 30,),

          const SizedBox(width: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10,
                    color: MyColor.themeTealBlue,
                    fontFamily: 'poppins_semibold'
                ),
              ),

              Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 15,
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
  Widget notificationCountWidget() {
    return InkWell(
      onTap: () async{
           var result = await Get.to(() => const NotificationListScreen());
           if(result){
             getXController.getNotificationListResponse();
           }
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
                color: Colors.black,
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
                child:  Text(
                  getXController.notificationCount.value.toString(),
                  style: const TextStyle(
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

}
