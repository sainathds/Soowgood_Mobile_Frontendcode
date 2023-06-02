import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_clinics_controller.dart';

import 'provider_add_edit_clinic_screen.dart';

class ProviderClinicsScreen extends StatefulWidget {


  const ProviderClinicsScreen({Key? key}) : super(key: key);

  @override
  _ProviderClinicsScreenState createState() => _ProviderClinicsScreenState();
}

class _ProviderClinicsScreenState extends State<ProviderClinicsScreen> {


  ProviderClinicsController getXController = Get.put(ProviderClinicsController());
  late Size size;

  @override
  void initState() {
    // TODO: implement initState
    getXController.clearAll();
    getXController.refreshPage = refreshPage;
    Future.delayed(const Duration(), (){
      getXController.getClinicListResponse();
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
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
          centerTitle: true,
          title: const Text('Clinics'),
          actions: [
            InkWell(
                onTap: () async{
                  var nav =  await Get.to(() =>  ProviderAddEditClinicScreen(
                      callFrom: 'Add',
                      clinicId: '',
                      name: '',
                      address: '',
                      country: '',
                      // state: '',
                      city: '',
                      zipCode: '',
                      imgOne: '',
                      imgTwo: '',
                      imgThree: '') );

                  log('TEST $nav');

                  if(nav){
                    getXController.getClinicListResponse();
                  }
                  },
                child: const Icon(Icons.add, color: MyColor.themeSkyBlue,)),
            const SizedBox(width: 20,)
          ],
        ),

        body: Container(
          height: size.height,
          width: size.width,
          child: clinicListWidget(),
        ),
      )
    );
  }

  ///*
  ///
  ///
  clinicListWidget() {
    return ListView.builder(
        itemCount: getXController.clinicList.length,
        itemBuilder: (context , index){
          return Card(
            elevation: 0.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Row(
                children: [

                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child : getXController.clinicList[index].imageUrl != null ?  Image.network(getImageUrl(getXController.clinicList[index].imageUrl!),
                      width: 60.0, height: 60.0, fit: BoxFit.fill,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image(
                            image: noImage, width: 60, height: 60, fit: BoxFit.fill);
                      },
                    )
                    : Image(image:  noImage,
                      width: 60.0, height: 60.0, fit: BoxFit.fill,),
                  ),


                  const SizedBox(width: 10,),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                getData(getXController.clinicList[index].name),
                                style: const TextStyle(
                                    color: MyColor.themeTealBlue,
                                    fontSize: 13.0,
                                    fontFamily: 'poppins_medium'
                                ),
                              ),
                            ),

                            PopupMenuButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.more_vert, color: Colors.black,),
                                // add this line
                                itemBuilder: (_) => <PopupMenuItem<String>>[
                                  const PopupMenuItem<String>(
                                    padding: EdgeInsets.only(left: 10),
                                      value: 'Edit',
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'popins_regular',
                                        ),
                                      )),
                                  const PopupMenuItem<String>(
                                      padding: EdgeInsets.only(left: 10),
                                      value: 'Delete',
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'popins_regular',
                                        ),
                                      )),
                                ],
                                onSelected: (value) {
                                  switch (value) {
                                    case 'Edit':
                                      navigateToEditScreen(index);
                                      break;
                                    case 'Delete':
                                    getXController.getDeleteClinicResponse(getXController.clinicList[index].id.toString());
                                      break;
                                  }
                                })

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Text(
                            getData(getXController.clinicList[index].currentAddress),
                            style: const TextStyle(
                                color: MyColor.themeTealBlue,
                                fontSize: 11.0,
                                fontFamily: 'poppins_medium'
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });


  }

   refreshPage(){
    setState(() {

    });
  }

  ///*
  ///
  ///
  String getData(String? data) {

    if(data != null){
      return data;
    }else{
      return data = '';
    }
  }


  String getImageUrl(String img){
    return ApiConstant.fileBaseUrl + ApiConstant.clinicImgFolder + img;
  }

  ///*
  ///
  ///
  void navigateToEditScreen(int index) async{
    var data =  await Get.to(() => ProviderAddEditClinicScreen(
      callFrom: 'Edit',
      clinicId: getXController.clinicList[index].id.toString(),
      name: getXController.clinicList[index].name!,
      address: getXController.clinicList[index].currentAddress!,
      country: getXController.clinicList[index].country!,
      // state: getXController.clinicList[index].state!,
      city: getXController.clinicList[index].city!,
      zipCode: getXController.clinicList[index].postalCode!,
      imgOne: getData(getXController.clinicList[index].imageUrl),
      imgTwo: getData(getXController.clinicList[index].imageUrlOptionalTwo),
      imgThree: getData(getXController.clinicList[index].imageUrlOptionalThree),));

    if(data){
      getXController.getClinicListResponse();
    }

  }
}
