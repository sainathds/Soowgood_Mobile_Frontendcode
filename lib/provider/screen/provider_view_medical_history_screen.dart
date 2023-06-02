import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/tab/provider_doctor_visit_tab.dart';
import 'package:soowgood/provider/tab/provider_prescription_tab.dart';

class ProviderViewMedicalHistoryScreen extends StatefulWidget {

  String serviceReceiverId;
   ProviderViewMedicalHistoryScreen({Key? key, required this.serviceReceiverId}) : super(key: key);

  @override
  _ProviderViewMedicalHistoryScreenState createState() => _ProviderViewMedicalHistoryScreenState();
}

class _ProviderViewMedicalHistoryScreenState extends State<ProviderViewMedicalHistoryScreen> {



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
                onTap: (){
                  Get.back();
                },
                child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
            centerTitle: true,
            title: const Text('Medical History'),
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
        length: 2,
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
                        'Doctor Visit'
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      child: Text(
                        'Prescription'
                      ),
                    ),
                  ),

                ],

              ),
            ),
          ),
          body:  TabBarView(
            children: [

              ProviderDoctorVisitTab(serviceReceiverId: widget.serviceReceiverId,),
              ProviderPrescriptionTab(serviceReceiverId: widget.serviceReceiverId,)
            ],
          ),
        ));
  }

}
