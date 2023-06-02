import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/tab/all_appointment_tab.dart';
import 'package:soowgood/benificiary/tab/previous_appointment_tab.dart';
import 'package:soowgood/benificiary/tab/recent_appointment_tab.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';

class BeneficiaryAppointmentsScreen extends StatefulWidget {

  String callFrom;

   BeneficiaryAppointmentsScreen({Key? key, required this.callFrom}) : super(key: key);

  @override
  _BeneficiaryAppointmentsScreenState createState() => _BeneficiaryAppointmentsScreenState();
}

class _BeneficiaryAppointmentsScreenState extends State<BeneficiaryAppointmentsScreen> {
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
            leading: widget.callFrom == 'Dashboard' ? InkWell(
                onTap: (){
                  Get.back();
                },
                child: Image(image: backArrowWhiteIcon, color: Colors.black,)):SizedBox(),
            centerTitle: true,
            title: const Text('Appointments'),
          ),
          body: Column(
            children: [

              Expanded(
                flex: 1,
                child: customTabWidget(),
              )

            ],
          ),

        )
    );
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

                tabs: const [
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      child: Text(
                          'All'
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      child: Text(
                        'Recent',

                      ),
                    ),
                  ),

                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      child: Text(
                          'Previous'
                      ),
                    ),
                  ),

                ],

              ),
            ),
          ),
          body:  const TabBarView(
            children: [


              AllAppointmentTab(),
              RecentAppointmentTab(),
              PreviousAppointmentTab()

            ],
          ),
        ));
  }

}
