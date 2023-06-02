import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/screen/provider_add_edit_schedule_screen.dart';
import 'package:soowgood/provider/tab/provider_clinic_schedule_tab.dart';
import 'package:soowgood/provider/tab/provider_inperson_schedule_tab.dart';
import 'package:soowgood/provider/tab/provider_online_schedule_tab.dart';

import '../controller/provider_clinic_schedule_controller.dart';
import '../controller/provider_inperson_schedule_controller.dart';
import '../controller/provider_online_schedule_controller.dart';

class ProviderScheduleScreen extends StatefulWidget {
  const ProviderScheduleScreen({Key? key}) : super(key: key);

  @override
  _ProviderScheduleScreenState createState() => _ProviderScheduleScreenState();
}

class _ProviderScheduleScreenState extends State<ProviderScheduleScreen> {

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.5,
            backgroundColor: Colors.white,
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image(
                  image: backArrowWhiteIcon,
                  color: Colors.black,
                )),
            centerTitle: true,
            title: const Text('Schedule'),
            actions: [
              InkWell(
                  onTap: () async {
                    await Get.to(() =>  ProviderAddEditScheduleScreen(
                        callFrom: 'Add',
                        scheduleId: '',
                        ));

                    /*if(nav){
                      getXController.getClinicListResponse();
                    }*/
                  },
                  child: const Icon(
                    Icons.add,
                    color: MyColor.themeSkyBlue,
                  )),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: customTabWidget(),
              )
            ],
          ),
        ));
  }

  ///*
  ///
  ///
  Widget customTabWidget() {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: MyColor.black05,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
              backgroundColor: Colors.black12,
              elevation: 0,
              bottom: TabBar(
                padding: const EdgeInsets.only(left: 0, right: 0, bottom: 5, top: 5),
                isScrollable: true,
                labelColor: Colors.black,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(0.0),
                indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                tabs: const [
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      child: Text('Clinic'),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      child: Text(
                        'Online',
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      child: Text('Physical'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              ProviderClinicScheduleTab(), 
              ProviderOnlineScheduleTab(), 
              ProviderInPersonScheduleTab()
            ],
          ),
        ));
  }
}
