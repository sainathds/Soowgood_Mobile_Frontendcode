import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/controller/provider_dashboard_controller.dart';
import 'package:soowgood/provider/screen/provider_add_edit_education_screen.dart';
import 'package:soowgood/provider/screen/provider_contact_us_screen.dart';
import 'package:soowgood/provider/screen/provider_home_screen.dart';
import 'package:soowgood/provider/screen/provider_patients_screen.dart';
import 'package:soowgood/provider/screen/provider_profile_screen.dart';
import 'package:soowgood/provider/screen/provider_profile_setting_screen.dart';

import '../../common/resources/my_colors.dart';

class ProviderDashboardScreen extends StatefulWidget {
  const ProviderDashboardScreen({Key? key}) : super(key: key);

  @override
  _ProviderDashboardScreenState createState() => _ProviderDashboardScreenState();
}

class _ProviderDashboardScreenState extends State<ProviderDashboardScreen> {


  int currentPageNumber = 0;
  List<Widget> pages = <Widget>[];
  late Widget currentPage;
  final PageStorageBucket bucket = PageStorageBucket();

  ProviderDashboardController getXController = Get.put(ProviderDashboardController());

  @override
  void initState() {
    // TODO: implement initState

    setBottomNavPages();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(

          body: pages.isNotEmpty ? PageStorage(bucket: bucket, child: currentPage) : const SizedBox(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,

            items: [
              BottomNavigationBarItem(
                  icon: Image(image: homeIcon, color: currentPageNumber == 0 ?  MyColor.themeTealBlue : MyColor.hintColor, width: 40.0, height: 40.0,),
                  // icon: Icon(Icons.home, color: currentPageNumber == 0 ?  MyColor.themeTealBlue : MyColor.inactiveOtp),
                  label: ""),

              BottomNavigationBarItem(
                  icon: Icon(Icons.contact_page_outlined, color: currentPageNumber == 1 ? MyColor.themeTealBlue : MyColor.hintColor, size: 30,),
                  label: ""),

              BottomNavigationBarItem(
                  icon: Image(image: patientIcon, color: currentPageNumber == 2 ?  MyColor.themeTealBlue : MyColor.hintColor, width: 40.0, height: 40.0,),
                  // icon: Icon(Icons.pa, color: currentPageNumber == 2 ? MyColor.themeTealBlue : MyColor.inactiveOtp),
                  label: ""),

              BottomNavigationBarItem(
                  icon: Image(image: profileIcon, color: currentPageNumber == 3 ?  MyColor.themeTealBlue : MyColor.hintColor, width: 40.0, height: 40.0,),
                  // icon: Icon(Icons.favorite, color: currentPageNumber == 3 ? MyColor.themeTealBlue : MyColor.inactiveOtp),
                  label: ""),


            ],
            onTap: (int index){
              setState(() {
                currentPage = pages[index];
                currentPageNumber = index;
              });
              /*if(index == 0){
                Future.delayed(Duration.zero, () async {
                  _getXController.hitCurrentOrderApi();
                });
              }*/
            },
          ),

        ),
      ),
    );
  }

  ///*
  ///
  ///
  void setBottomNavPages() {
    pages.clear();
    currentPage = const ProviderHomeScreen();
    pages.add(const ProviderHomeScreen());
    pages.add(const ProviderContactUsScreen());
    pages.add(const ProviderPatientsScreen());
    pages.add(const ProviderProfileScreen());
    // pages.add(const ProviderProfileSettingScreen());

  }

  ///
  ///
  ///
  Future<bool> showExitPopup() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App',
            style: TextStyle(
                fontFamily: "poppins_regular",
                fontWeight: FontWeight.bold
            )),
        content: const Text('Do you want to exit SoowGood?',
            style: TextStyle(
                fontFamily: "poppins_regular",
                fontSize: 14,
                fontWeight: FontWeight.w600
            )),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:const Text('No',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "poppins_regular",
                    fontWeight: FontWeight.bold
                )),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child:const Text('Yes',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "poppins_regular",
                      fontWeight: FontWeight.bold
                  )),
            ),
          ),

        ],
      ),
    )??false;
  }
}
