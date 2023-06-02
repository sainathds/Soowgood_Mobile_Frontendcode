import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_appointments_controller.dart';
import 'package:soowgood/provider/tab/provider_clinic_appointment_tab.dart';
import 'package:soowgood/provider/tab/provider_online_appointment_tab.dart';
import 'package:soowgood/provider/tab/provider_physical_appointment_tab.dart';

class ProviderAppointmentsScreen extends StatefulWidget {
  const ProviderAppointmentsScreen({Key? key}) : super(key: key);

  @override
  _ProviderAppointmentsScreenState createState() => _ProviderAppointmentsScreenState();
}

class _ProviderAppointmentsScreenState extends State<ProviderAppointmentsScreen> {

  ProviderAppointmentsController getXController = Get.put(ProviderAppointmentsController());

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration(), (){
      getXController.getConsultancyTypeResponse();
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
              title: const Text('Appointments'),
            ),
            body: Column(
              children: [

                getXController.consultancyTypeList.isNotEmpty?
                Expanded(
                  flex: 1,
                  child: customTabWidget(),
                ):SizedBox()

              ],
            ),

          );
        })
    );
  }


  ///*
  ///
  ///
  Widget customTabWidget() {
    return DefaultTabController(
        length: getXController.consultancyTypeList.length,
        child: Scaffold(
          backgroundColor: MyColor.black05,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppBar(
              backgroundColor: Colors.black12,
              elevation: 0,
              bottom:  TabBar(
                padding:
                const EdgeInsets.only(left: 0, right: 0, bottom: 5, top: 5),
                isScrollable: true,
                labelColor: Colors.black,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.all(0.0),
                indicator: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),

                tabs: [
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      child: Text(
                          getXController.consultancyTypeList[0].name!,
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      child: Text(
                        getXController.consultancyTypeList[1].name!,

                      ),
                    ),
                  ),

                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      child: Text(
                        getXController.consultancyTypeList[2].name!,
                      ),
                    ),
                  ),

                ],

              ),
            ),
          ),
          body:  TabBarView(
            children: [

              ProviderClinicAppointmentTab(appointmentTypeId :getXController.consultancyTypeList[0].id!),
              ProviderOnlineAppointmentTab(appointmentTypeId :getXController.consultancyTypeList[1].id!),
              ProviderPhysicalAppointmentTab(appointmentTypeId :getXController.consultancyTypeList[2].id!)

            ],
          ),
        ));
  }

}
