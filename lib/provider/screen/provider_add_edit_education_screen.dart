import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/controller/provider_add_edit_education_controller.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

import '../../common/resources/my_colors.dart';

class ProviderAddEditEducationScreen extends StatefulWidget {


  String callFrom;
  String educationId;
  String degree;
  String college;
  String year;

  ProviderAddEditEducationScreen({Key? key,
    required this.callFrom,
    required this.educationId,
    required this.degree,
    required this.college,
    required this.year}) : super(key: key);

  @override
  _ProviderAddEditEducationScreenState createState() => _ProviderAddEditEducationScreenState();
}

class _ProviderAddEditEducationScreenState extends State<ProviderAddEditEducationScreen> {


  ProviderAddEditEducationController getXController = Get.put(ProviderAddEditEducationController());

  late DateTime selectedYear  = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    ProviderGlobal.isEducationBack = false;
    getXController.clearAll();
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
              leading: InkWell(
                  onTap: (){
                    Get.back(result: ProviderGlobal.isEducationBack);
                  },
                  child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
              centerTitle: true,
              title: Text('${widget.callFrom} Education'),
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

                    getStarLabel('Degree Name'),
                    const SizedBox(height: 5.0,),
                    degreeField(),


                    const SizedBox(height: 20.0,),
                    getStarLabel('College/Institute'),
                    const SizedBox(height: 5.0,),
                    collegeField(),

                    const SizedBox(height: 20.0,),
                    getStarLabel('Passing Year'),
                    const SizedBox(height: 5.0,),
                    passingYearField(),


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
  degreeField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.degreeController,
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
          hintText: 'Degree',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isDegreeEmpty.value? "Please Enter Name Of Degree" : null
      ),
    );
  }

  ///*
  ///
  ///
  passingYearField() {
    return TextFormField(
      readOnly: true,
      onTap: () {
        getXController.setAllErrorToFalse();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Select Year"),
              content: Container( // Need to use container to add size constraint.
                width: 300,
                height: 300,
                child: YearPicker(
                  firstDate: DateTime(DateTime.now().year - 100, 1),
                  lastDate: DateTime(DateTime.now().year + 100, 1),
                  initialDate: DateTime.now(),
                  // save the selected date to _selectedDate DateTime variable.
                  // It's used to set the previous selected date when
                  // re-showing the dialog.
                  selectedDate: selectedYear,
                  onChanged: (value) {
                    // close the dialog when year is selected.
                    Navigator.pop(context);
                    setState(() {
                      getXController.passingYearController.text = value.year.toString();
                    });
                    // Do something with the dateTime selected.
                    // Remember that you need to use dateTime.year to get the year
                  },
                ),
              ),
            );
          },
        );
      },
      controller: getXController.passingYearController,
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
          hintText: 'Passing Year',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isPassingYearEmpty.value? "Please Enter Passing Year" : null
      ),
    );
  }




  ///*
  ///
  ///
  collegeField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.collegeController,
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
          hintText: 'College/Institute',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          errorText: getXController.isCollegeEmpty.value? "Please Enter College or Institute Name" : null
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
            widget.callFrom == 'Edit' ? 'Update Education': '${widget.callFrom} Education',
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
  void setData() async{
      getXController.callFrom =  widget.callFrom;
      getXController.educationId =   widget.educationId;
      getXController.degreeController.text = widget.degree;
      getXController.collegeController.text =  widget.college;
      getXController.passingYearController.text =   widget.year;
  }


  ///*
  ///
  ///
  Future<bool> _onWillPop() async{
    Get.back(result: ProviderGlobal.isEducationBack);
    return false;
  }
}
