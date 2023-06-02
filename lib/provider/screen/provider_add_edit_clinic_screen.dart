import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/common/resources/my_string.dart';
import 'package:soowgood/provider/controller/provider_add_edit_clinic_controller.dart';

class ProviderAddEditClinicScreen extends StatefulWidget {

  String callFrom;
  String clinicId;
  String name;
  String address;
  String country;
  // String state;
  String city;
  String zipCode;
  String imgOne;
  String imgTwo;
  String imgThree;

  ProviderAddEditClinicScreen({Key? key,
    required this.callFrom,
    required this.clinicId,
    required this.name,
    required this.address,
    required this.country,
    // required this.state,
    required this.city,
    required this.zipCode,
    required this.imgOne,
    required this.imgTwo,
    required this.imgThree,

  }) : super(key: key);

  @override
  _ProviderAddEditClinicScreenState createState() => _ProviderAddEditClinicScreenState();
}

class _ProviderAddEditClinicScreenState extends State<ProviderAddEditClinicScreen> {

  ProviderAddEditClinicController getXController = Get.put(ProviderAddEditClinicController());

  @override
  void initState() {
    // TODO: implement initState
    getXController.clearAll();
    getXController.isBack  = false;

    getXController.callFrom = widget.callFrom;

    log('IMG_ ONE ${widget.imgOne}');
    log('IMG_ TWO ${widget.imgTwo}');
    log('IMG_ THREE ${widget.imgThree}');

    if(widget.callFrom == 'Edit'){
      setData();
    }


    ///initialize Google PlacePicker
    PluginGooglePlacePicker.initialize(
        androidApiKey: MyString.googleApiKey,
        iosApiKey: MyString.googleApiKey);
    // setData();
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
              backgroundColor: Colors.white,
              centerTitle: true,

              leading: InkWell(
                  onTap: (){
                    // Navigator.pop(context,getXController.isBack);

                    Get.back(result: getXController.isBack);
                  },
                  child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
              title: Text('${widget.callFrom} Clinic'),
              actions: const [
                Icon(Icons.notifications_none_rounded),
                SizedBox(width: 20,)
              ],
            ),

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    getStarLabel('Clinic Name'),
                    const SizedBox(height: 5.0,),
                    clinicField(),

                    const SizedBox(height: 20.0,),
                    getStarLabel('Clinic Address'),
                    const SizedBox(height: 5.0,),
                    addressField(),

                    const SizedBox(height: 20.0,),
                    getStarLabel('City'),
                    const SizedBox(height: 5.0,),
                    cityField(),

                    /*const SizedBox(height: 20.0,),
                    getStarLabel('State'),
                    const SizedBox(height: 5.0,),
                    stateField(),
*/
                    const SizedBox(height: 20.0,),
                    getStarLabel('Zip Code'),
                    const SizedBox(height: 5.0,),
                    zipCodeField(),

                    const SizedBox(height: 20.0,),
                    getStarLabel('Country'),
                    const SizedBox(height: 5.0,),
                    countryField(),

                    const SizedBox(height: 20.0,),
                    getLabel('Upload Your Photo'),
                    const SizedBox(height: 5.0,),
                    imageWidget(),

                    const SizedBox(height: 30.0,),
                    buttonWidget()

                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );

  }

  ///*
  ///
  ///
  getStarLabel(String label) {
    return Row(
      children: [
        Text(label, style: const TextStyle(
            fontSize: 13.0,
            color: MyColor.themeTealBlue,
            fontFamily: 'poppins_semibold'
        ),),
        const Padding(
          padding: EdgeInsets.all(3.0),
        ),
        const Text('*', style: const TextStyle(color: Colors.red)),

      ],
    );

  }

  ///*
  ///
  ///
  clinicField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.clinicNameController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_medium'
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0),
          hintText: 'Clinic Name',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isClinicNameEmpty.value? "Please Enter Name Of Clinic" : null
      ),
    );

  }

  ///*
  ///
  ///
  addressField() {
    return TextFormField(
      onTap: () async {
          getXController.setAllErrorToFalse();
          Place place = await showPlacePicker();
          getXController.addressController.text = place.address!;
          log("SelectedLocation Name: ${place.name!}");
          log("SelectedLocation Address: ${place.address!}");
        },
      controller: getXController.addressController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_medium'
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0),
          hintText: 'Address',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isAddressEmpty.value? "Please Add Address" : null
      ),
    );

  }

  ///*
  ///
  /// to use Google Place picker follow below step
  /// enable Places Api from Google Developer Console
  /// use to search address
  /// use google_places_picker: ^3.0.2 dependency
  static Future<Place> showPlacePicker() async{
    return await PluginGooglePlacePicker.showAutocomplete(
        mode: PlaceAutocompleteMode.MODE_OVERLAY,
        typeFilter: TypeFilter.ESTABLISHMENT);

  }

  ///*
  ///
  ///
  cityField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.cityController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_medium'
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0),
          hintText: 'City',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isCityNameEmpty.value? "Please Enter Name Of City" : null
      ),
    );

  }

  ///*
  ///
  ///
  stateField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.stateController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_medium'
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0),
          hintText: 'State',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isStateEmpty.value? "Please Enter Name Of State" : null
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
          fontFamily: 'poppins_medium'
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0),
          hintText: 'Zip Code',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isZipCodeEmpty.value? "Please Enter Zip Code" : null
      ),
    );

  }

  ///*
  ///
  ///
  countryField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.countryController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_medium'
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0),
          hintText: 'Country',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isZipCodeEmpty.value? "Please Enter Country Name" : null
      ),
    );

  }

  ///*
  ///
  ///
  buttonWidget() {
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
          child:  Text(
            widget.callFrom == 'Edit'? 'Update Clinic' : '${widget.callFrom} Clinic',
            style: const TextStyle(
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
  imageWidget() {

    return Row(
      children: [

        Expanded(
          flex: 1,
          child: imageContainer1(),),


        const SizedBox(width: 10,),
        Expanded(
          flex: 1,
          child: imageContainer2(),),

        const SizedBox(width: 10,),
        Expanded(
          flex: 1,
          child: imageContainer3(),)


      ],
    );

  }

  ///*
  ///
  ///
  imageContainer1() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: MyColor.themeTealBlue)
      ),
      child: Stack(children: [
        ClipRRect(
          child: !getXController.isLoadImg1.value && getXController.imageUrl1.value == ''?

          Image(image:  noImage,
            width: 120.0, height: 120.0, fit: BoxFit.fill,)

              : getXController.isLoadImg1.value && getXController.compressedImage1.value == ''? Center(child: CircularProgressIndicator(color: MyColor.themeTealBlue,),)
              : getXController.compressedImage1.value != '' ?

          Image(
            image: FileImage(
                File(getXController.imageFile1!.path)),
            width: 120.0, height: 120.0, fit: BoxFit.fill,)

              :  Image.network(getXController.imageUrl1.value,
            width: 120.0, height: 120.0, fit: BoxFit.fill,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Image(
                  image: noImage, width: 120, height: 120, fit: BoxFit.fill);
            },
          ),

        ),

        Positioned(
            top: 0,
            right: 0,
            child: InkWell(
                onTap: (){
                  showImageOptionDialog('image1');
                },
                child: Container(
                  width: 35,
                  height: 35,
                  color: MyColor.themeTealBlue,
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white,),
                )))
      ],),
    );
  }


  ///*
  ///
  ///
  imageContainer2() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          border: Border.all(color: MyColor.themeTealBlue)
      ),
      child: Stack(children: [
        ClipRRect(
          child: !getXController.isLoadImg2.value && getXController.imageUrl2.value == ''?
          Image(image:  noImage,
            width: 120.0, height: 120.0, fit: BoxFit.fill,)

              : getXController.isLoadImg2.value && getXController.compressedImage2.value == ''? Center(child: CircularProgressIndicator(color: MyColor.themeTealBlue,),)
              : getXController.compressedImage2.value != '' ?
          Image(
            image: FileImage(
                File(getXController.imageFile2!.path)),
            width: 120.0, height: 120.0, fit: BoxFit.fill,)

              :  Image.network(getXController.imageUrl2.value,
            width: 120.0, height: 120.0, fit: BoxFit.fill,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Image(
                  image: noImage, width: 120, height: 120, fit: BoxFit.fill);
            },
          ),

        ),

        Positioned(
            top: 0,
            right: 0,
            child: InkWell(
                onTap: (){
                  showImageOptionDialog('image2');
                },
                child: Container(
                  width: 35,
                  height: 35,
                  color: MyColor.themeTealBlue,
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white,),
                )))
      ],),
    );
  }


  ///*
  ///
  ///
  imageContainer3() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          border: Border.all(color: MyColor.themeTealBlue)
      ),
      child: Stack(children: [
        ClipRRect(
          child: !getXController.isLoadImg3.value && getXController.imageUrl3.value == ''? Image(image:  noImage,
            width: 120.0, height: 120.0, fit: BoxFit.fill,)

              : getXController.isLoadImg3.value && getXController.compressedImage3.value == ''? Center(child: CircularProgressIndicator(color: MyColor.themeTealBlue,),)
              : getXController.compressedImage3.value != '' ?
          Image(
            image: FileImage(
                File(getXController.imageFile3!.path)),
            width: 120.0, height: 120.0, fit: BoxFit.fill,)

              :  Image.network(getXController.imageUrl3.value,
            width: 120.0, height: 120.0, fit: BoxFit.fill,
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return Image(
                  image: noImage, width: 120, height: 120, fit: BoxFit.fill);
            },
          ),

        ),

        Positioned(
            top: 0,
            right: 0,
            child: InkWell(
                onTap: (){
                  showImageOptionDialog('image3');
                },
                child: Container(
                  width: 35,
                  height: 35,
                  color: MyColor.themeTealBlue,
                  child: Icon(Icons.camera_alt_outlined, color: Colors.white,),
                )))
      ],),
    );
  }

  ///*
  ///
  ///
  void showImageOptionDialog(String callFrom) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 30.0, top: 10, left: 20.0, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.cancel_outlined, color: Colors.grey, size: 25.0,),
                        SizedBox(width: 5.0,),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          imageSelector(context, "gallery", callFrom);
                          Get.back();
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.image, color: MyColor.tealBlueDark, size: 40.0,),
                            SizedBox(width: 5.0,),
                            Text('Gallery',style: TextStyle(fontSize: 16.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold')),
                          ],
                        ),
                      ),

                      SizedBox(width: 50,),

                      InkWell(
                        onTap: (){
                          imageSelector(context, "camera", callFrom);
                          Get.back();
                        },
                        child: Row(
                          children:  const [
                            Icon(Icons.add_a_photo, color: MyColor.tealBlueDark, size: 40.0,),
                            SizedBox(width: 5.0,),
                            Text('Camera',style: TextStyle(fontSize: 16.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold')),
                          ],
                        ),
                      ),


                    ],
                  ),
                ],
              )
          );
        });
  }


  ///*
  ///
  ///
  Future imageSelector(BuildContext context, String pickerType, String clickType) async {
    switch (pickerType) {
      case "gallery":

      /// GALLERY IMAGE PICKER
        if(clickType == 'image1'){
          getXController.isLoadImg1.value = true;
          getXController.compressedImage1.value = '';
          getXController.imageFile1 = (await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 90))!;
          compressImage('image1');

        }else if(clickType == 'image2'){
          getXController.isLoadImg2.value = true;
          getXController.compressedImage2.value = '';
          getXController.imageFile2 = (await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 90))!;
          compressImage('image2');

        }else if(clickType == 'image3'){
          getXController.isLoadImg3.value = true;
          getXController.compressedImage3.value = '';
          getXController.imageFile3 = (await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 90))!;
          compressImage('image3');

        }

        refreshPage();
        break;

      case "camera": // CAMERA CAPTURE CODE

        if(clickType == 'image1'){
          getXController.isLoadImg1.value = true;
          getXController.compressedImage1.value = '';
          getXController.imageFile1 = (await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 90))!;
          compressImage('image1');

        }else if(clickType == 'image2'){
          getXController.isLoadImg2.value = true;
          getXController.compressedImage2.value = '';
          getXController.imageFile2 = (await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 90))!;
          compressImage('image2');

        }else if(clickType == 'image3'){
          getXController.isLoadImg3.value = true;
          getXController.compressedImage3.value = '';
          getXController.imageFile3 = (await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 90))!;
          compressImage('image3');

        }

        refreshPage();
        break;
    }

    /*if (getXController.imageFile != null) {
      log("You selected  image : ${getXController.imageFile!.path}");
      setState(() {
        debugPrint("SELECTED IMAGE PICK   ${getXController.imageFile}");
      });
    } else {
      log("You have not taken image");
    }*/
  }


  ///*
  ///
  ///
  refreshPage(){
    setState(() {});
  }

  ///*
  ///
  ///
  void setData() {

      getXController.isLoadImg3.value = true;

      getXController.imageUrl1.value = '';
      getXController.imageUrl2.value = '';
      getXController.imageUrl3.value = '';


      getXController.clinicId = widget.clinicId;
    getXController.clinicNameController.text = widget.name;
    getXController.addressController.text = widget.address;
    getXController.countryController.text = widget.country;
    // getXController.stateController.text = widget.state;
    getXController.cityController.text = widget.city;
    getXController.zipCodeController.text = widget.zipCode;

    if(widget.imgOne == ''){
      getXController.isLoadImg1.value = false;
    }else {
      getXController.isLoadImg1.value = false;
      getXController.imageUrl1.value = getImageUrl(widget.imgOne);
    }

      if(widget.imgTwo == ''){
        getXController.isLoadImg2.value = false;
      }else {
        getXController.isLoadImg2.value = false;
        getXController.imageUrl2.value = getImageUrl(widget.imgTwo);
      }

      if(widget.imgTwo == ''){
        getXController.isLoadImg3.value = false;
      }else {
        getXController.isLoadImg3.value = false;
        getXController.imageUrl3.value = getImageUrl(widget.imgThree);
      }




  }

  ///*
  ///
  ///
  String getImageUrl(String img){
    if(img != ''){
      String url = ApiConstant.fileBaseUrl + ApiConstant.clinicImgFolder + img;
      log('IMGURL $url');
      return url;
    }else{
      return '';
    }
  }

  ///*
  ///
  ///
  Future<bool> _onWillPop() async{
    Get.back(result: getXController.isBack);
    return getXController.isBack;
  }

  ///*
  ///
  ///
  getLabel(String label) {
    return Row(
      children: [
        Text(label, style: const TextStyle(
            fontSize: 13.0,
            color: MyColor.themeTealBlue,
            fontFamily: 'poppins_semibold'
        ),),
      ],
    );

  }



  ///*
  ///
  ///
  void compressImage(String callFrom) async{

    if(callFrom == 'image1'){
      getXController.isLoadImg1.value = true;

      final dir = await getTemporaryDirectory();
      final targetPath = '${dir.absolute.path}/temp1.jpg';

      var result = await FlutterImageCompress.compressAndGetFile(
        getXController.imageFile1!.path, targetPath,
        quality: 88,
        // rotate: 90,
      );

      if(result != null){
        getXController.compressedImage1.value = result.path;
        log('IMAGE 1 COMPRESS');

      }

    }else if(callFrom == 'image2'){
      getXController.isLoadImg2.value = true;

      final dir = await getTemporaryDirectory();
      final targetPath = '${dir.absolute.path}/temp2.jpg';

      var result = await FlutterImageCompress.compressAndGetFile(
        getXController.imageFile2!.path, targetPath,
        quality: 88,
        // rotate: 90,
      );

      if(result != null){
        getXController.compressedImage2.value = result.path;
        log('IMAGE 2 COMPRESS');
      }

    }else if(callFrom == 'image3'){
      getXController.isLoadImg3.value = true;

      final dir = await getTemporaryDirectory();
      final targetPath = '${dir.absolute.path}/temp3.jpg';

      var result = await FlutterImageCompress.compressAndGetFile(
        getXController.imageFile3!.path, targetPath,
        quality: 88,
        // rotate: 90,
      );

      if(result != null){
        getXController.compressedImage3.value = result.path;
        log('IMAGE 3 COMPRESS');

      }

    }


  }

}
