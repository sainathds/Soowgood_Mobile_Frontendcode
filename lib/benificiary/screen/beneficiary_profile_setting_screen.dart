import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:soowgood/benificiary/controller/beneficiary_profile_setting_controller.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/common/resources/my_string.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class BeneficiaryProfileSettingScreen extends StatefulWidget {
  const BeneficiaryProfileSettingScreen({Key? key}) : super(key: key);

  @override
  _BeneficiaryProfileSettingScreenState createState() => _BeneficiaryProfileSettingScreenState();
}

class _BeneficiaryProfileSettingScreenState extends State<BeneficiaryProfileSettingScreen> {

  BeneficiaryProfileSettingController getXController = Get.put(BeneficiaryProfileSettingController());
  var genderList = [
    '',
    'Male',
    'Female',
    'Other',
  ];
  var  bloodGroupList = <String>[
    '',
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',];

  @override
  void initState() {
    // TODO: implement initState
    getXController.isUpdated = false;

    ProviderGlobal.isBeneficiarySettingBack = false;

    PluginGooglePlacePicker.initialize(
        androidApiKey: MyString.googleApiKey,iosApiKey: MyString.googleApiKey);
    ProviderGlobal.isBasicInfoBack = false;

    Future.delayed(const Duration(), (){
      getXController.getProfileScoreResponse();
    });
    Future.delayed(const Duration(), (){
      getXController.getProfileResponse();
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
                      Get.back(result: ProviderGlobal.isBeneficiarySettingBack);
                    },
                    child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
              ),

              body: Column(
                children: [

                  getScoreWidget(),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children: [
                          getTitle('Personal Details'),

                          const SizedBox(height: 15,),
                          getStarLabel('Full Name'),
                          fullNameField(),

                          const SizedBox(height: 15,),
                          getStarLabel('User Name'),
                          userNameField(),

                          const SizedBox(height: 15,),
                          dobAndGenderWidget(),

                          const SizedBox(height: 15,),
                          bloodGroupWidget(),

                          const SizedBox(height: 20,),
                          getTitle('Contact Details'),

                          const SizedBox(height: 15,),
                          getStarLabel('Email Address'),
                          emailField(),


                          const SizedBox(height: 15,),
                          getStarLabel('Mobile Number'),
                          mobileNumberField(),


                          const SizedBox(height: 15,),
                          getStarLabel('Address'),
                          addressField(),

                          const SizedBox(height: 15,),
                          getStarLabel('Zip Code'),
                          zipCodeField(),

                          const SizedBox(height: 30,),
                          updateButtonWidget()

                        ],
                      ),
                    ),
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
  getTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:  [
        Text(
          title,
          style: const TextStyle(
              color: MyColor.themeSkyBlue,
              fontSize: 17.0,
              fontFamily: 'poppins_semibold'
          ),
        ),
      ],
    );

  }


  ///*
  ///
  ///
  Widget genderDropdown(){
    return DropdownButton(
      isExpanded: true,
      underline: Container(height: 1, color: Colors.grey,),
      value: getXController.selectedGender.value,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: genderList.map((String gender){
        return DropdownMenuItem(
            value: gender,
            child: Text(gender, style: const TextStyle(
                fontSize: 14.0,
                color: MyColor.themeTealBlue,
                fontFamily: 'poppins_semibold'
            ),)
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          getXController.selectedGender.value = newValue!;
        });
      },
    );
  }


  ///*
  ///
  ///
  Widget bloodGroupDropdown(){
    return DropdownButton(
      isExpanded: true,
      underline: Container(height: 1, color: Colors.grey,),
      value: getXController.selectedBloodGroup.value,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: bloodGroupList.map((String bloodGroup){
        return DropdownMenuItem(
            value: bloodGroup,
            child: Text(bloodGroup,
              style: const TextStyle(
                  fontSize: 14.0,
                  color: MyColor.themeTealBlue,
                  fontFamily: 'poppins_semibold'
              ),)
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          getXController.selectedBloodGroup.value = newValue!;
        });
      },
    );
  }


  ///*
  ///
  ///
  dobAndGenderWidget() {

    return Row(
      children: [

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('Date Of Birth'),
                dobField()
              ],
            )
        ),

        const SizedBox(width: 25,),

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('Gender'),
                genderDropdown()
              ],
            )
        ),
      ],
    );
  }


  ///*
  ///
  ///
  bloodGroupWidget() {

    return Row(
      children: [

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('Blood Group'),
                bloodGroupDropdown()
              ],
            )
        ),

        const SizedBox(width: 25,),

        const Expanded(
            flex: 1,
            child: SizedBox()
        )
      ],
    );
  }


  ///*
  ///
  ///
  updateButtonWidget() {
    return SizedBox(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: (){
            getXController.isDataValid();
          },
          style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),),
          child: const Text(
            'Update Info',
            style: TextStyle(
                color: MyColor.offWhite,
                fontSize: 16.0,
                fontFamily: 'poppins_semibold'
            ),
          )),
    );

  }

  ///*
  ///
  ///
  dobField() {
    return TextFormField(
      readOnly: true,
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.dobController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style:  const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration: InputDecoration(
        suffixIcon: InkWell(
            onTap: (){
              setState(() {
                getXController.setAllErrorToFalse();
                selectDate();
              });
            },
            child: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,)),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: MyColor.themeSkyBlue),
        ),

        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 10.0),
        errorText: getXController.isDobEmpty.value ? "Please Select Date Of Birth" :  null ,
      ),

    );

  }


  ///*
  ///
  ///
  void selectDate() async {

    DateTime selectedDate = DateTime.now();

    DateTime nowDate = DateTime.now();
    String inValidDate = "${nowDate.year}-${nowDate.month}-${nowDate.day}";

    DateTime expiryDate = DateTime(nowDate.year + 20);

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1901),
      lastDate: DateTime.now(),
    );
    if (selected != null) {
      setState(() {
        selectedDate = selected;
        getXController.dobController.text =
        "${selectedDate.month.toString().padLeft(2, "0")}-${selectedDate.day.toString().padLeft(2, "0")}-${selectedDate.year}";
      });
    }
  }


  ///*
  ///
  /// show google placepicker
  /// use google_places_picker: ^3.0.2 dependecy
  /// to use placepicker enable places api from googgle dev. console
  static Future<Place> showPlacePicker() async{
    return await PluginGooglePlacePicker.showAutocomplete(
        mode: PlaceAutocompleteMode.MODE_OVERLAY,
        typeFilter: TypeFilter.ESTABLISHMENT);

  }


  ///*
  ///
  ///
  getStarLabel(String label) {
    return Row(
      children: [
        Text(label, style: const TextStyle(
            fontSize: 11.0,
            color: MyColor.hintColor,
            fontFamily: 'poppins_semibold'
        ),),
        const Padding(
          padding: EdgeInsets.all(3.0),
        ),
        Text('*', style: const TextStyle(color: Colors.red)),

      ],
    );

  }

  ///*
  ///
  ///
  getLabel(String label) {
    return Row(
      children: [
        Text(label, style: const TextStyle(
            fontSize: 11.0,
            color: MyColor.hintColor,
            fontFamily: 'poppins_semibold'
        ),),
      ],
    );

  }


  ///*
  ///
  ///
  fullNameField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.fullNameController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration:  InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: MyColor.themeSkyBlue),
          ),
          errorText: getXController.isFullNameEmpty.value?  "Please Enter Full Name" : null

      ),
    );

  }

  ///*
  ///
  ///
  userNameField() {
    return TextFormField(
      readOnly: true,
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.userNameController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: MyColor.themeSkyBlue),
          ),
          errorText: getXController.isUserNameEmpty.value? "Please Enter User Name" : null
      ),
    );

  }

  ///*
  ///
  ///
  emailField() {
    return TextFormField(
      readOnly: true,
      controller: getXController.emailController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 15.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration: const InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
          BorderSide(color: MyColor.themeSkyBlue),
        ),
      ),
    );

  }

  ///*
  ///
  ///
  mobileNumberField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.mobileNoController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      // maxLength: 10,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration:  InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: MyColor.themeSkyBlue),
          ),
          errorText: getXController.isMobileNoEmpty.value? "Please Enter Mobile Number" : null
        // getXController.isMobileNoValid.value ? "Please enter valid 10 digit mobile no.": null
      ),
    );

  }

  ///*
  ///
  ///
  addressField() {
    return TextFormField(
      onTap: () {
        setState(() async{
          getXController.setAllErrorToFalse();
          Place place = await showPlacePicker(); //open google placePicker
          getXController.addressController.text = place.address!;
          getXController.latitude = place.latitude;
          getXController.longitude = place.longitude;
          log("SelectedLocation Name: ${place.name!}");
          log("SelectedLocation Address: ${place.address!}");
          log("SelectedLocation Latitude: ${place.latitude}");
          log("SelectedLocation Longitude: ${place.longitude}");

        });
      },
      controller: getXController.addressController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: MyColor.themeSkyBlue),
          ),

          errorText: getXController.isAddressEmpty.value == true? "Please Enter Address" : null
      ),
    );

  }

  ///*
  ///
  ///
  zipCodeField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.zipCodeController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: MyColor.themeSkyBlue),
          ),

          errorText: getXController.isZipCodeEmpty.value == true? "Please Enter Zip Code" : null
      ),
    );

  }


  ///*
  ///
  ///
  Future<bool> _onWillPop() async{
    Get.back(result: ProviderGlobal.isBeneficiarySettingBack);
    return false;
  }

}
