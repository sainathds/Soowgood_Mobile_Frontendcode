import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_profile_setting_controller.dart';
import 'package:soowgood/provider/screen/provider_add_edit_education_screen.dart';
import 'package:soowgood/provider/tab/provider_award_memebership_tab.dart';
import 'package:soowgood/provider/tab/provider_basic_info_tab.dart';
import 'package:soowgood/provider/tab/provider_educational_experience_tab.dart';
import 'package:soowgood/provider/tab/provider_skills_pricing_tab.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderProfileSettingScreen extends StatefulWidget {
  const ProviderProfileSettingScreen({Key? key}) : super(key: key);

  @override
  _ProviderProfileSettingScreenState createState() => _ProviderProfileSettingScreenState();
}

class _ProviderProfileSettingScreenState extends State<ProviderProfileSettingScreen> {

  ProviderProfileSettingController getXController = Get.put(ProviderProfileSettingController());
  late Size size;



  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(const Duration(), (){
      getXController.getProfileScoreResponse();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child: Obx((){
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              appBar: AppBar(
                elevation: 1.0,
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text('Profile Settings'),
                leading: InkWell(
                    onTap: (){
                      Get.back(result: ProviderGlobal.isBasicInfoBack);
                    },
                    child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
              ),

              body: Column(
                children: [

                  getScoreWidget(),

                  Expanded(
                    flex: 1,
                    child: customTabWidget(),
                  )
                ],
              ),
            ),
          );
        }));
  }

  ///*
  ///
  ///
  Widget customTabWidget() {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: AppBar(
              backgroundColor: Colors.black12,
              elevation: 0,
              bottom:  TabBar(
                padding:
                const EdgeInsets.only(left: 0, right: 0, bottom: 10, top: 10),
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
                      padding: EdgeInsets.symmetric(horizontal: 15.0,),
                      child: Text(
                        'Basic Info'
                      ),
                    ),
                  ),
                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0,),
                      child: Text(
                          'Educational&Experience',

                      ),
                    ),
                  ),

                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0,),
                      child: Text(
                          'Awards & Membership'
                      ),
                    ),
                  ),

                  Tab(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0,),
                      child: Text(
                          'Skills & Pricing'
                      ),
                    ),
                  ),
                ],

              ),
            ),
          ),
          body: const TabBarView(
            children: [

              ProviderBasicInfoTab(),
              ProviderEducationalExperienceTab(),
              ProviderAwardMembershipTab(),
              ProviderSkillPricingTab(),


            ],
          ),
        ));
  }


  ///*
  ///
  ///
  getScoreWidget() {
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: MyColor.lightPink,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text( "You have only completed ${getXController.profileScore.value}% of your profile.Please Update your details to go smoothly while booking appointment",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'poppins_medium',
                  fontWeight: FontWeight.normal,
                  fontSize: 12.0,
                  color: Colors.red,
                ),),
            ),
          ],
        ),);

  }

  ///*
  ///
  ///
  Future<bool> _onWillPop() async{
    Get.back(result: ProviderGlobal.isBasicInfoBack);
    return false;
  }
}
