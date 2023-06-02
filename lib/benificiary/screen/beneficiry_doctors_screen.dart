import 'dart:async';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:soowgood/benificiary/controller/beneficiary_doctors_controller.dart';
import 'package:soowgood/benificiary/model/other/gender_model.dart';
import 'package:soowgood/benificiary/screen/beneficiary_book_appointment_Screen.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';

import '../../provider/model/response/provider_consultancy_type_response.dart';

class BeneficiaryDoctorsScreen extends StatefulWidget {

  String? searchText,fromHome;
  BeneficiaryDoctorsScreen({Key? key, required this.searchText, required this.fromHome}) : super(key: key);

  @override
  _BeneficiaryDoctorsScreenState createState() => _BeneficiaryDoctorsScreenState();
}

class _BeneficiaryDoctorsScreenState extends State<BeneficiaryDoctorsScreen> {

  BeneficiaryDoctorsController getXController = Get.put(BeneficiaryDoctorsController());
  late Size size;


  @override
  void initState() {
    // TODO: implement initState
    getXController.clearAll();

    getXController.searchController.text = widget.searchText!;
    GenderModel g1 = GenderModel();
    g1.name = 'Male';
    GenderModel g2 = GenderModel();
    g2.name = 'Female';
    GenderModel g3 = GenderModel();
    g3.name = 'Other';
    getXController.genderList.add(g1);
    getXController.genderList.add(g2);
    getXController.genderList.add(g3);

    getXController.getWeekdaysList();

    Future.delayed(const Duration(), (){
      getXController.getSearchedProvidersResponse();
    });

    Future.delayed(const Duration(), (){
      getXController.getSpecializationListResponse();
    });

    Future.delayed(const Duration(), (){
      getXController.getAppointmentTypeResponse();
    });
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Obx((){
      return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0), // here the desired height
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.fromHome == "true" ?
                      Container(
                        width: 28,
                        child: IconButton(
                          splashRadius: 20,
                            onPressed: (){
                              Navigator.pop(context);
                            }, 
                            icon: const Icon(Icons.arrow_back_ios)),
                      )
                      : const SizedBox(width: 40,),
                      const Text('Our Providers', style: TextStyle(
                          fontSize: 17.0,
                          color: MyColor.themeTealBlue,
                          fontFamily: 'poppins_Semibold'
                      ),),

                      InkWell(
                        onTap: (){
                          filterBottomSheetWidget();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(Icons.filter_list_alt, color: MyColor.themeTealBlue,),
                        ),
                      ),
                      // SizedBox(width: 20,)
                    ],
                  ),

                  const SizedBox(height: 10.0,),
                  getSearchWidget()
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 5.0,),
                  getXController.providerList.isNotEmpty?
                  getSearchedProvidersLayout()
                      : const Center(
                    child: Text("No Data Found"),
                  )
                ],
              ),
            )),
      );
    });


  }

  ///*
  ///
  ///
  getSearchWidget() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15,),
            height: 40,
            child: TextFormField(
              controller: getXController.searchController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (query) async{
                if(getXController.searchController.text.trim().isNotEmpty){
                  // getXController.searchText.value = getXController.searchController.text;
                  getXController.getSearchedProvidersResponse();
                }
              },
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide:  BorderSide(color: MyColor.searchBgColor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),

                  ),
                  filled: true,
                  fillColor: MyColor.searchBgColor,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 15.0),
                  hintText: 'Search by Doctors',
                  hintStyle: const TextStyle(
                      fontSize: 13.0,
                      color: MyColor.searchColor,
                      fontFamily: 'poppins_medium'),
                  suffixIcon: InkWell(
                    onTap: (){
                      if(getXController.searchController.text.trim().isNotEmpty){
                        getXController.getSearchedProvidersResponse();
                      }
                    },
                    child: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.grey,
                    ),
                  )),

              onChanged: (value){
                if(value.isEmpty){
                  // getXController.searchText.value = '';
                  getXController.searchController.clear();
                  getXController.getSearchedProvidersResponse();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  ///*
  ///
  ///
  getSearchedProvidersLayout() {
    return SingleChildScrollView(
      child: LayoutGrid(
        columnSizes: [1.fr, 1.fr],
        rowSizes: List<IntrinsicContentTrackSize>.generate(
            (getXController.providerList.length / 2).round(),
                (int index) => auto),
        rowGap: 15,
        children: [
          for (var index = 0;
          index < getXController.providerList.length;
          index++)

            Center(
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 250,
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
                  ),
                ],
              ),
            )
        ],
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 5),
      // width: MediaQuery.of(context).size.width,
      height: 30,
      child: ElevatedButton(
          onPressed: (){
            log('PROVIDER_ID ${getXController.providerList[index].providerId!}' );
            Get.to(() => BeneficiaryBookAppointmentScreen(providerId: getXController.providerList[index].providerId!,
                appointmentType:getXController.providerList[index].appointmentType != null ? getXController.providerList[index].appointmentType! : ''));
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
  filterBottomSheetWidget(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return getFilterOption();
        });


  }

  ///*
  ///
  /// get filter options for
  /// gender, appointment type, weekdays, specializations
  /// use to get doctors list according for selected filter option
  getFilterOption() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
              Text('Filters', style:
                TextStyle(
                  fontSize: 20.0,
                  color: MyColor.themeTealBlue,
                  fontFamily: 'poppins_semibold'
                ),)
            ],),

            const SizedBox(height: 20,),
            genderDropdown(),
            const SizedBox(height: 20,),
            appointmentTypeDropdown(),
            const SizedBox(height: 20,),
            weekDaysDropdown(),
            const SizedBox(height: 20,),
            specializationDropdown(),


          ],
        ),
      ),
    );
  }

  ///*
  ///
  /// get doctor list for particular gender
  genderDropdown() {
    return DropdownSearch<GenderModel?>(
      dropdownBuilder: _genderTypeStyle,
      dropdownButtonProps:  const DropdownButtonProps(
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
          padding: EdgeInsets.zero
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.only(left: 10),
          label: Text('Gender', style: TextStyle(
              fontSize: 14.0,
              color: MyColor.tealBlueLight,
              fontFamily: 'poppins_medium'
          ),),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      items: getXController.genderList.value,
      itemAsString: (GenderModel? u) => u!.genderAsString(),
      selectedItem: getXController.selectedGender.value,
      onChanged: (value) {
        getXController.selectedAppointmentType.value.name = "";
        getXController.selectedWeekDayList.clear();
        getXController.selectedSpecializationList.clear();

        getXController.selectedGender.value = value!;
        if(getXController.selectedGender.value.name.isNotEmpty ){
          Get.back();
          getXController.getSearchedProvidersResponse(); //get doctor list for selected gender type

        }
      },
    );

  }


  ///*
  ///
  ///
  specializationDropdown(){
    return MultiSelectDialogField(
      onSelectionChanged: (values){
        getXController.selectedSpecializationList.value = values;
        },
      title: const Text('Provider Specialization', style: TextStyle(
          fontSize: 14.0,
          color: MyColor.tealBlueLight,
          fontFamily: 'poppins_medium'
      ),),
      initialValue: getXController.selectedSpecializationList,
      items: getXController.multiSpecializationList,
      listType: MultiSelectListType.LIST,
      buttonText: const Text('Select Specialization'),
      buttonIcon:  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey)
      ),
      searchable: true,
      onConfirm: (values) {
        getXController.selectedGender.value.name = "";
        getXController.selectedAppointmentType.value.name = "";
        getXController.selectedWeekDayList.clear();

        getXController.selectedSpecializationList.value = values;
        Get.back();
        getXController.getSearchedProvidersResponse(); //get doctor list for selected specialization
      },
    );
  }

  ///*
  ///
  ///
  appointmentTypeDropdown() {
    return DropdownSearch<ProviderConsultancyTypeResponse?>(
      dropdownBuilder: _appointmentTypeStyle,
      dropdownButtonProps:  const DropdownButtonProps(
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
          padding: EdgeInsets.zero
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.only(left: 10),
          label: Text('Appointment Type',
          style: TextStyle(
              fontSize: 14.0,
              color: MyColor.tealBlueLight,
              fontFamily: 'poppins_medium'
          ),),
          hintStyle: TextStyle(
            fontSize: 12.0,
            color: MyColor.themeTealBlue,
            fontFamily: 'poppins_medium'
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      items: getXController.appointmentTypeList,
      itemAsString: (ProviderConsultancyTypeResponse? u) => u!.consultancyAsString(),
      selectedItem: getXController.selectedAppointmentType.value,
      onChanged: (value) {
        getXController.selectedGender.value.name = "";
        getXController.selectedWeekDayList.clear();
        getXController.selectedSpecializationList.clear();

        getXController.selectedAppointmentType.value = value!;
        Get.back();
        getXController.getSearchedProvidersResponse(); //get doctor list for selected appointmentType
        },
    );

  }

  ///*
  ///
  ///
  Widget _appointmentTypeStyle(BuildContext context, ProviderConsultancyTypeResponse? selectedData) {
    return Text(
      selectedData!.name != null ? selectedData.name! : "",
      style: const TextStyle(
          fontSize: 12.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
    );
  }


  Widget _genderTypeStyle(BuildContext context, GenderModel? selectedItem) {
    return Text(
      selectedItem!.name != null ? selectedItem.name : "",
      style: const TextStyle(
          fontSize: 12.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
    );

  }


  ///*
  ///
  ///
  weekDaysDropdown() {
    return MultiSelectDialogField(
      initialValue: getXController.selectedWeekDayList,
      items: getXController.multiWeekDayList,
      listType: MultiSelectListType.LIST,
      buttonText: const Text('Availability'),
      buttonIcon:  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
      searchable: true,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey)
      ),
      onConfirm: (values) {
        getXController.selectedGender.value.name = "";
        getXController.selectedAppointmentType.value.name = "";
        getXController.selectedSpecializationList.clear();

        getXController.selectedWeekDayList = values;
        log('TEST--- ${getXController.selectedWeekDayList}');
        Get.back();
        getXController.getSearchedProvidersResponse(); //get doctor list for selected weekday
      },
    );

  }

}
