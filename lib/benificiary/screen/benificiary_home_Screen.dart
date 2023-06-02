import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soowgood/benificiary/controller/beneficiary_home_controller.dart';
import 'package:soowgood/benificiary/model/other/beneficiary_address_model.dart';
import 'package:soowgood/benificiary/screen/beneficiary_book_appointment_Screen.dart';
import 'package:soowgood/benificiary/screen/beneficiary_payment_screen.dart';
import 'package:soowgood/benificiary/screen/beneficiry_doctors_screen.dart';
import 'package:soowgood/benificiary/screen/booking_summary_screen.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/common/screen/login_screen.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:soowgood/common/screen/notification_list_screen.dart';

import 'beneficiary_main_screen.dart';

class BeneficiaryHomeScreen extends StatefulWidget {

  BeneficiaryAddressModel addressModel ;
  BeneficiaryHomeScreen({Key? key, required this.addressModel }) : super(key: key);

  @override
  _BeneficiaryHomeScreenState createState() => _BeneficiaryHomeScreenState();
}

class _BeneficiaryHomeScreenState extends State<BeneficiaryHomeScreen> {
  BeneficiaryHomeController getXController = Get.put(BeneficiaryHomeController());
  final BeneficiaryMainScreen beneficiaryMainScreen = new BeneficiaryMainScreen();


  @override
  void initState() {
    // TODO: implement initState

    getXController.refreshPage = refreshPage;
    getXController.providerList.clear();
    Future.delayed(const Duration(), (){
      getXController.getProvidersResponse();
    });
    Future.delayed(const Duration(), (){
      getXController.getNotificationListResponse();
    });
    super.initState();
  }


  refreshPage(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Obx((){
        return Scaffold(
          extendBodyBehindAppBar: true, //use to transparent color of appBar
          appBar: AppBar(
            elevation: 0,
/*
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
*/

            backgroundColor: MyColor.teal,
            shadowColor: Colors.transparent,
            title: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BeneficiaryMainScreen()), (route) => false);
                  // Get.off(const BeneficiaryMainScreen());
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_sharp,
                    color: Colors.teal,
                  ),
                  Expanded(child: Text(widget.addressModel.address,
                    style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.white70,
                        fontFamily: 'poppins_regular'), maxLines: 1,)),
                ],
              ),
            ),
            actions: [


              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  notificationCountWidget(),
                ],
              ),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              children: [
                getHeader(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Text('Our Providers',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'poppins_medium',
                          color: MyColor.themeTealBlue,
                        ),),

                      InkWell(
                        onTap: (){
                          Get.to(() => BeneficiaryDoctorsScreen(searchText: '',fromHome: 'true',));
                        },
                        child: const Text('View All',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'poppins_medium',
                            color: MyColor.themeTealBlue,
                          ),),
                      )
                    ],),
                ),
                getProviders(),


/*              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Specialities',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'poppins_medium',
                      color: MyColor.themeTealBlue,
                    ),),

                  getXController.specializationList.length > 2?
                  const Text('View All',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'poppins_medium',
                      color: MyColor.themeTealBlue,
                    ),): SizedBox()
                ],),
              getSpecialization()*/
                // Expanded(child: Container(color: Colors.green,))

              ],
            ),
          ),

        );
      })
    );

  }

  ///*
  ///
  ///
  getHeader() {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: patientBgImg,
                    fit: BoxFit.cover
                )
            ),
          ),

          Container(
            color: MyColor.teal,
          ),

          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Digital health services \n at your doorstep',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white54,
                      fontFamily: 'poppins_regular'
                    ),),
                ],
              ),

                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 19.0),
                  child: Container(
                    height: 50,
                    child: TextFormField(
                      controller: getXController.searchEditController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (query) async{
                        Get.to(() => BeneficiaryDoctorsScreen(searchText: getXController.searchEditController.text,fromHome: 'false',));
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 15.0),
                        hintText: 'Search by Doctors',
                        hintStyle: const TextStyle(
                            fontSize: 13.0,
                            color: MyColor.searchColor,
                            fontFamily: 'poppins_medium'),
                        suffixIcon: InkWell(
                          onTap: (){
                            Get.to(() => BeneficiaryDoctorsScreen(searchText: getXController.searchEditController.text,fromHome: 'false',));
                            },
                          child: Icon(
                            Icons.search,
                            size: 30,
                            color: MyColor.tealBlueLight,
                          ),
                        ),
                      ),


                    ),
                  ),
                )

              ],),
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


        var result  = await Get.to(() => NotificationListScreen());
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
                color: Colors.white,
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
                  getXController.notiCount.value.toString(),
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
  getProviders() {
    return Container(
      height: 270,
      child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: getXController.providerList.length > 5 ? 5 : getXController.providerList.length,
              itemBuilder: (context, index){
                return Card(
                  elevation: 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 180,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        getProviderImgPath(getXController.providerList[index].providerImage) != ''?
                        Image.network(getProviderImgPath(getXController.providerList[index].providerImage),
                            width: 110.0, height: 110.0, fit: BoxFit.fill,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Image(
                                  image: noImage, width: 110, height: 110, fit: BoxFit.fill);})
                             : Image(image: noImage, width: 110, height: 110, fit: BoxFit.fill),

                        Text(getName(getXController.providerList[index].name),
                        style: const TextStyle(
                          fontSize: 13,
                          color: MyColor.tealBlueDark,
                          fontFamily: 'poppins_semibold'
                        ),),

                        // const SizedBox(height: 5,),
                        Text(getData(getXController.providerList[index].service),
                          style: const TextStyle(
                              fontSize: 10,
                              color: MyColor.tealBlueDark,
                              fontFamily: 'poppins_medium'
                          ),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                '(${getData(
                              getXController.providerList[index].appointmentType,
                            )})',
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.green,
                                    fontFamily: 'poppins_semibold'
                                ),),
                            ),
                          ],
                        ),

                        // const SizedBox(height: 5,),
                        Row(
                          children: [
                            Image(image: homeAddressIc , height: 15, width: 15,),
                            const SizedBox(width: 5,),
                            Expanded(
                              child: Text(
                                getData(getXController.providerList[index].clinicAddress,),
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: MyColor.tealBlueDark,
                                    fontFamily: 'poppins_medium'
                                ),),
                            ),
                          ],
                        ),

                        bookNowButton(index)
                      ],
                    ),
                  ),
                );
              }),
    );
  }

  ///*
  ///
  ///
  String getProviderImgPath(image) {
                if(image != null && image != ''){
   return ApiConstant.fileBaseUrl + ApiConstant.profilePicFolder + image;

                }else{
         return '';
    }
    }

    ///*
  ///
  ///
  String getName(String? name) {
    if(name != null && name.isNotEmpty){
      return "Dr.$name";
    }else{
      return '';
    }
  }

  ///*
  ///
  ///
  String getData(String? data) {
    if(data != null && data.isNotEmpty){
      return "$data";
    }else{
      return '';
    }
  }


  ///*
  ///
  ///
  bookNowButton(int index) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      // width: MediaQuery.of(context).size.width,
      height: 30,
      child: ElevatedButton(
          onPressed: (){

            Get.to(() => BeneficiaryBookAppointmentScreen(providerId: getXController.providerList[index].providerId!,
              appointmentType: getXController.providerList[index].appointmentType != null ? getXController.providerList[index].appointmentType! : '' , ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColor.themeSkyBlue,
            shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),),
          child: const Text(
            'Book Now',
            style: TextStyle(
                color: MyColor.offWhite,
                fontSize: 13.0,
                fontFamily: 'poppins_semibold'
            ),
          )),
    );

  }

  ///*
  ///
  ///
/*  getSpecialization() {

  }*/



}
