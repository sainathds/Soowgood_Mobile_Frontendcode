import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_skills_pricing_controller.dart';
import 'package:soowgood/provider/screen/provider_add_edit_specialization_screen.dart';

class ProviderSkillPricingTab extends StatefulWidget {
  const ProviderSkillPricingTab({Key? key}) : super(key: key);

  @override
  _ProviderSkillPricingTabState createState() => _ProviderSkillPricingTabState();
}

class _ProviderSkillPricingTabState extends State<ProviderSkillPricingTab> {

  ProviderSkillsPricingController getXController = Get.put(ProviderSkillsPricingController());

  @override
  void initState() {
    // TODO: implement initState
    getXController.clearAll();
    getXController.refreshPage = refreshPage;
    Future.delayed(const Duration(), (){
      getXController.getSpecializationListResponse();
    });
    super.initState();
  }


  ///*
  ///
  ///
  refreshPage(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(

        children: [

          getTitle('Specializations'),
          getXController.specializationList.isNotEmpty?
          Expanded(child: getSpecializationListWidget())
              : const SizedBox( height: 100, child: Center(child: Text('Education details are not available')),),


        ],
      ),
    );
  }


  ///*
  ///
  ///
  getSpecializationListWidget() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: getXController.specializationList.length,
              itemBuilder: (context , index){
                return Card(
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                getData(getXController.specializationList[index].type),
                                style: const TextStyle(
                                    color: MyColor.themeTealBlue,
                                    fontSize: 15.0,
                                    fontFamily: 'poppins_semibold'
                                ),
                              ),
                            ),

                            PopupMenuButton(
                                icon: Icon(Icons.more_vert, color: Colors.black,),
                                // add this line
                                itemBuilder: (_) => <PopupMenuItem<String>>[
                                  const PopupMenuItem<String>(
                                      value: 'Edit',
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'popins_regular',
                                        ),
                                      )),
                                  const PopupMenuItem<String>(
                                      value: 'Delete',
                                      child: Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'popins_regular',
                                        ),
                                      )),
                                ],
                                onSelected: (value) async {
                                  switch (value) {
                                    case 'Edit':
                                      var result = await Get.to(() =>  ProviderAddEditSpecializationScreen(
                                        callFrom: 'Edit',
                                        specializationId: getXController.specializationList[index].id.toString(),
                                        categoryId: getXController.specializationList[index].typeId!,
                                        categoryName: getXController.specializationList[index].type!,
                                        services: getXController.specializationList[index].serviceName!,
                                        specializations: getXController.specializationList[index].specializationName!,
                                      ),);

                                      if(result){
                                        getXController.getSpecializationListResponse();
                                      }
                                      break;
                                    case 'Delete':
                                      getXController.getDeleteSpecializationResponse(getXController.specializationList[index].id.toString());
                                      break;
                                  }
                                })

                          ],
                        ),

                        // const SizedBox(height: 1,),
                        Text(
                          getXController.specializationList[index].serviceName!,
                          style: const TextStyle(
                            color: MyColor.themeTealBlue,
                              fontSize: 14.0,
                              fontFamily: 'poppins_medium'
                          ),
                        ),

                        const SizedBox(height: 3,),
                        Text(
                          getData(getXController.specializationList[index].specializationName),
                          style: const TextStyle(
                              color: MyColor.themeTealBlue,
                              fontSize: 12.0,
                              fontFamily: 'poppins_regular'
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text(
          title,
          style: const TextStyle(
              color: MyColor.themeSkyBlue,
              fontSize: 17.0,
              fontFamily: 'poppins_semibold'
          ),
        ),

        InkWell(
          onTap: () async{
            var result = await Get.to(() =>  ProviderAddEditSpecializationScreen(
              callFrom: 'Add',
              specializationId: '',
              categoryId: '',
              categoryName: '',
              services: '',
              specializations: '',
            ),);


            if(result){
              getXController.getSpecializationListResponse();
            }
          },
          child: Container(
            padding: const EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: MyColor.themeSkyBlue,
            ),
            child: const Text(
              '+ Add Specialization',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'poppins_medium'
              ),
            ),
          ),
        ),
      ],
    );

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

  ///*
  ///
  ///
/*  String getListData(String data) {

  }*/

}
