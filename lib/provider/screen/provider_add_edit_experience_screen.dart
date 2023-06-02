import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/controller/provider_add_edit_education_controller.dart';
import 'package:soowgood/provider/controller/provider_add_edit_experience_controller.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

import '../../common/resources/my_colors.dart';

class ProviderAddEditExperienceScreen extends StatefulWidget {

  String callFrom;
  String experienceId;
  String hospital;
  String designation;
  String fromDate;
  String toDate;

  ProviderAddEditExperienceScreen({Key? key, required this.callFrom, required this.experienceId, required this.hospital, required this.designation, required this.fromDate, required this.toDate}) : super(key: key);

  @override
  _ProviderAddEditExperienceScreenState createState() => _ProviderAddEditExperienceScreenState();
}

class _ProviderAddEditExperienceScreenState extends State<ProviderAddEditExperienceScreen> {

  ProviderAddEditExperienceController getXController = Get.put(ProviderAddEditExperienceController());


  @override
  void initState() {
    // TODO: implement initState
    ProviderGlobal.isExperienceBack = false;
    setData();
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
              title: Text('${widget.callFrom} Experience'),
              leading: InkWell(
                  onTap: (){
                    Get.back(result: ProviderGlobal.isExperienceBack);
                  },
                  child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
            ),

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    getStarLabel('Hospital Name'),
                    const SizedBox(height: 5.0,),
                    hospitalField(),

                    const SizedBox(height: 20.0,),
                    getStarLabel('Designation'),
                    const SizedBox(height: 5.0,),
                    designationField(),

                    const SizedBox(height: 20.0,),
                    getDateField(),

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
  hospitalField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.hospitalController,
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
          hintText: 'Hospital Name',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isHospitalEmpty.value? "Please Enter Name Of Hospital" : null
      ),
    );
  }


  ///*
  ///
  ///
  designationField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.designationController,
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
          hintText: 'Designation',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isDesignationEmpty.value? "Please Enter Designation" : null
      ),
    );
  }

  ///*
  ///
  ///
  fromDateField() {
    return TextFormField(
      readOnly: true,
      controller: getXController.fromDateController,
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
                selectDate(getXController.fromDateController);
              });
            },
            child: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        hintText: 'From Date',
        hintStyle: const TextStyle(
            fontSize: 13.0,
            color: MyColor.hintColor,
            fontFamily: 'poppins_regular'
        ),
        errorText: getXController.isFromDateEmpty.value ? "Please Select From Date" :  null ,
      ),

    );

  }

  ///*
  ///
  ///
  toDateField() {
    return TextFormField(
      readOnly: true,
      controller: getXController.toDateController,
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
                selectDate(getXController.toDateController);
              });
            },
            child: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
        const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0),
        hintText: 'To Date',
        hintStyle: const TextStyle(
            fontSize: 13.0,
            color: MyColor.hintColor,
            fontFamily: 'poppins_regular'
        ),
        errorText: getXController.isToDateEmpty.value ? "Please Select To Date" :  null ,
      ),

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
            widget.callFrom == 'Edit' ?  'Update Experience' : '${widget.callFrom} Experience',
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
  getDateField() {

    return Row(
      children: [

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('From Date'),
                fromDateField()
              ],
            )
        ),

        const SizedBox(width: 25,),

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('To Date'),
                toDateField()
              ],
            )
        ),
      ],
    );

  }


  ///*
  ///
  ///
  void selectDate(TextEditingController dateController) async {

    DateTime selectedDate = DateTime.now();

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1901),
      lastDate: DateTime.now(),
    );
    if (selected != null) {
      setState(() {
        selectedDate = selected;
        dateController.text =
        "${selectedDate.month.toString().padLeft(2, "0")}-${selectedDate.day.toString().padLeft(2, "0")}-${selectedDate.year}";
      });
    }
  }

  ///*
  ///
  ///
  void setData() {

    getXController.callFrom = widget.callFrom;
    getXController.experienceId = widget.experienceId;
    getXController.hospitalController.text = widget.hospital;
    getXController.designationController.text = widget.designation;
    getXController.fromDateController.text = widget.fromDate;
    getXController.toDateController.text = widget.toDate;
  }

  ///*
  ///
  ///
  Future<bool> _onWillPop() async{
    Get.back(result: ProviderGlobal.isExperienceBack);
    return false;
  }

}
