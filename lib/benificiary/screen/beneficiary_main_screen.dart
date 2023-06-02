import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/model/other/beneficiary_address_model.dart';
import 'package:soowgood/benificiary/screen/beneficiary_appointments_screen.dart';
import 'package:soowgood/benificiary/screen/beneficiary_profile_screen.dart';
import 'package:soowgood/benificiary/screen/beneficiry_doctors_screen.dart';
import 'package:soowgood/benificiary/screen/benificiary_dashboard_screen.dart';
import 'package:soowgood/benificiary/screen/benificiary_home_Screen.dart';
import 'package:soowgood/common/dialog/custom_progress_dialog.dart';
import 'package:soowgood/common/dialog/permission_dialog.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart' as loc;
import 'package:soowgood/common/resources/my_string.dart';
import 'package:http/http.dart' as http;


class BeneficiaryMainScreen extends StatefulWidget {
  const BeneficiaryMainScreen({Key? key}) : super(key: key);

  @override
  _BeneficiaryMainScreenState createState() => _BeneficiaryMainScreenState();
}

class _BeneficiaryMainScreenState extends State<BeneficiaryMainScreen> {

  CustomProgressDialog progressDialog = CustomProgressDialog();

  int currentPageNumber = 0;
  List<Widget> pages = <Widget>[];
  late Widget currentPage;
  final PageStorageBucket bucket = PageStorageBucket();

  late geo.LocationPermission permission;
  loc.Location location =  loc.Location();

  BeneficiaryAddressModel addressModel = BeneficiaryAddressModel();

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration.zero, () async {
      checkAndRequestPermissions(); //check location service is enable or not
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: MyColor.themeTealBlue,
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
                  icon: Image(image: dashboardIcon, color: currentPageNumber == 1 ?  MyColor.themeTealBlue : MyColor.hintColor, width: 40.0, height: 40.0,),
                  label: ""),

              BottomNavigationBarItem(
                  icon: Image(image: appointmentBarIcon, color: currentPageNumber == 2 ?  MyColor.themeTealBlue : MyColor.hintColor, width: 40.0, height: 40.0,),
                  // icon: Icon(Icons.pa, color: currentPageNumber == 2 ? MyColor.themeTealBlue : MyColor.inactiveOtp),
                  label: ""),

              BottomNavigationBarItem(
                  icon: Image(image: doctorIcon, color: currentPageNumber == 3 ?  MyColor.themeTealBlue : MyColor.hintColor, width: 40.0, height: 40.0,),
                  // icon: Icon(Icons.favorite, color: currentPageNumber == 3 ? MyColor.themeTealBlue : MyColor.inactiveOtp),
                  label: ""),

              BottomNavigationBarItem(
                  icon: Image(image: profileIcon, color: currentPageNumber == 4 ?  MyColor.themeTealBlue : MyColor.hintColor, width: 40.0, height: 40.0,),
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
  getHeader() {
    return SizedBox(
      height: 300,
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
       /* var nav = await Get.to(() => NotificationListScreen(userType: 'Customer',));
        if(nav == null){
          _getXController.hitNotificationCountApi();
        }*/
      },
      child: Container(
        width: 50,
        child: Stack(
          children: [
            Positioned(
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
                child: Text(
                  '0',
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
  /// check location permission is enable or not
  /// if not then request for location permission
  void checkAndRequestPermissions() async{
    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied ) {
      permission = await geo.Geolocator.requestPermission();

      if (permission == geo.LocationPermission.denied) { //if permission denied by user then show dialog , why permission is required
        log('Location_Permission : LocationPermission.denied');
        showLocationPermssionDialog("denied");
        pages.clear();
        currentPage = BeneficiaryHomeScreen(addressModel: addressModel,);
        pages.add(BeneficiaryHomeScreen(addressModel: addressModel,));
        pages.add(const BeneficiaryDashboardScreen());
        pages.add( BeneficiaryAppointmentsScreen(callFrom: 'Main',));
        pages.add( BeneficiaryDoctorsScreen(searchText: '',fromHome: 'false',));
        pages.add(const BeneficiaryProfileScreen());
        setState(() {});

      }
      else if(permission == geo.LocationPermission.deniedForever){
        log('Location_Permission : $permission');
        showLocationPermssionDialog("deniedForever"); //if permission deniedForever by user then show dialog , why permission is required
        pages.clear();
        currentPage = BeneficiaryHomeScreen(addressModel: addressModel,);
        pages.add(BeneficiaryHomeScreen(addressModel: addressModel,));
        pages.add(const BeneficiaryDashboardScreen());
        pages.add( BeneficiaryAppointmentsScreen(callFrom: 'Main',));
        pages.add( BeneficiaryDoctorsScreen(searchText: '',fromHome: 'false',));
        pages.add(const BeneficiaryProfileScreen());
        setState(() {});

      }
      else if(permission == geo.LocationPermission.always || permission == geo.LocationPermission.whileInUse){
        log('Location_Permission : $permission');
        checkLocationService(); //if location is allow then check further permission i.e location service permission
        pages.clear();
        currentPage = BeneficiaryHomeScreen(addressModel: addressModel,);
        pages.add(BeneficiaryHomeScreen(addressModel: addressModel,));
        pages.add(const BeneficiaryDashboardScreen());
        pages.add( BeneficiaryAppointmentsScreen(callFrom: 'Main',));
        pages.add( BeneficiaryDoctorsScreen(searchText: '',fromHome: 'false',));
        pages.add(const BeneficiaryProfileScreen());
        setState(() {});

      }
    }else{
      checkLocationService();
      pages.clear();
      currentPage = BeneficiaryHomeScreen(addressModel: addressModel,);
      pages.add(BeneficiaryHomeScreen(addressModel: addressModel,));
      pages.add(const BeneficiaryDashboardScreen());
      pages.add( BeneficiaryAppointmentsScreen(callFrom: 'Main',));
      pages.add( BeneficiaryDoctorsScreen(searchText: '',fromHome: 'false',));
      pages.add(const BeneficiaryProfileScreen());
      setState(() {});
    }
  }

  ///*
  ///
  /// check location service permission
  void checkLocationService() async{
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        log("checkLocationService 1$_serviceEnabled" );
        showLocationServiceDialog(); //if permission not given then show dialog with msg
      }else{
        log("checkLocationService 2$_serviceEnabled" );
        setInitialLocation(); //if permission is given then get user current location
      }
    }else{
      setInitialLocation();

    }

  }

  ///*
  ///
  ///
  void showLocationServiceDialog() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => PermissionDialog(
            my_context: Get.context!,
            msg: "To see near by Providers you have to turn On Location",
            okFunction: checkLocationService,
            cancelFunction: noFunction));

  }

  ///*
  ///
  ///
  void noFunction(){
    Navigator.pop(Get.context!);
  }



  ///*
  ///
  ///
  void showLocationPermssionDialog(String permission) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context1) => PermissionDialog(
            my_context: Get.context!,
            msg: "To use this App, required location permission. \n please allow location permission",
            okFunction: permission == "deniedForever" ? checkLocationService : checkAndRequestPermissions,
            cancelFunction: noFunction));

  }

  ///*
  ///
  /// use to get user current location using geolocator: ^7.1.0 Dependency
  void setInitialLocation() async {
    // progressDialog.showProgressDialog();

    await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.best)
        .then((geo.Position position) {

      setState(() {
        addressModel.latitude = position.latitude;
        addressModel.longitude = position.longitude;

        // log("Main latitude ---" + _customerAddressModel.latitude.toString());
        // log("Main longitude ---" + _customerAddressModel.longitude.toString());
        // log("Main Address ---" + position.toJson().toString());

        // _currentPosition = value,
        // latitude = _currentPosition.latitude;
        // longitude = _currentPosition.longitude;
        getAddress(); //get address from latitude and longitude


      });
    }).catchError((e) {
      print(e);
      // progressDialog.close();

    });
  }


  ///*
  ///
  /// Enable geocoding,  api from google developer console
  /// get address from latitude and longitude using
  /// https://maps.google.com/maps/api/geocode/json?key=replace_your_map_key&language=en&latlng=latitude,longitude (complete url of Geocoding api calling)
  void getAddress() async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=${MyString.googleApiKey}&language=en&latlng=${addressModel.latitude},${addressModel.longitude}';
    log("URL ADDR$url");

    if(addressModel.latitude != null && addressModel.longitude != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];

        List<dynamic> addressComponents =
        data['results'][0]['address_components'];

        List<dynamic> countries = addressComponents
            .where((entry) => entry['types'].contains('country'))
            .toList()
            .map((entry) => entry['long_name'])
            .toList();
        List<dynamic> localities = addressComponents
            .where((entry) => entry['types'].contains('locality'))
            .toList()
            .map((entry) => entry['long_name'])
            .toList();
        List<dynamic> postalCode = addressComponents
            .where((entry) => entry['types'].contains('postal_code'))
            .toList()
            .map((entry) => entry['long_name'])
            .toList();

        addressModel.address = _formattedAddress;
        addressModel.countryName = countries[0];
        addressModel.city = localities[0];
        addressModel.zipCode = postalCode[0];


        log("Main Address : ${addressModel.address}");
        log("Main Country : ${addressModel.countryName}");
        log("Main City : ${addressModel.city}");
        log("Main ZipCode : ${addressModel.zipCode}");

        // progressDialog.close();
        pages.clear();
        currentPage = BeneficiaryHomeScreen(addressModel: addressModel,);
        pages.add(BeneficiaryHomeScreen(addressModel: addressModel,));
        pages.add(const BeneficiaryDashboardScreen());
        pages.add( BeneficiaryAppointmentsScreen(callFrom: 'Main',));
        pages.add( BeneficiaryDoctorsScreen(searchText: '',fromHome: 'false',));
        pages.add(const BeneficiaryProfileScreen());
        setState(() {});
      }
    }
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App',
            style: TextStyle(
                fontFamily: "poppins_regular",
                fontWeight: FontWeight.bold
            )),
        content: Text('Do you want to exit SoowGood?',
            style: TextStyle(
                fontFamily: "poppins_regular",
                fontSize: 14,
                fontWeight: FontWeight.w600
            )),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:Text('No',
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
              child:Text('Yes',
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
