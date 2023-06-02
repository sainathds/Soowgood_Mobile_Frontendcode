import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_add_edit_schedule_controller.dart';
import 'package:soowgood/provider/model/response/provider_clinic_list_response.dart';
import 'package:soowgood/provider/model/response/provider_consultancy_type_response.dart';
import 'package:soowgood/provider/model/response/provider_schedule_type_response.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderAddEditScheduleScreen extends StatefulWidget {

  String callFrom;
  String scheduleId;

  ProviderAddEditScheduleScreen({Key? key, required this.callFrom, required this.scheduleId,}) : super(key: key);

  @override
  _ProviderAddEditScheduleScreenState createState() => _ProviderAddEditScheduleScreenState();
}

class _ProviderAddEditScheduleScreenState extends State<ProviderAddEditScheduleScreen> {

  ProviderAddEditScheduleController getXController = Get.put(ProviderAddEditScheduleController());

  @override
  void initState() {
    // TODO: implement initState

    getXController.clearAll();
    ProviderGlobal.isScheduleBack = false;

    getXController.callFrom = widget.callFrom;
    getXController.scheduleId = widget.scheduleId;

    getXController.selectedClinic.value.id = '';
    getXController.selectedClinic.value.name = '';

    getXController.selectedScheduleType.value.id = '';
    getXController.selectedScheduleType.value.name = '';

    getXController.selectedConsultancyType.value.id = '';
    getXController.selectedConsultancyType.value.name = '';

    Future.delayed(const Duration(), (){
      getXController.getClinicListResponse();
    });
    getXController.getWeekdaysList();
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
                    Get.back(result: ProviderGlobal.isScheduleBack);
                  },
                  child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
              title: Text('${widget.callFrom} Schedule'),
              /*actions: const [
                Icon(Icons.notifications_none_rounded),
                SizedBox(width: 20,)
              ],*/
            ),

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const SizedBox(height: 15,),
                    getStarLabel('Clinic Name'),
                    clinicDropdown(),

                    const SizedBox(height: 15,),
                    getStarLabel('Schedule Type'),
                    scheduleTypeDropdown(),

                    (widget.callFrom == 'Edit' && getXController.selectedWeekDayList.isNotEmpty) || widget.callFrom == 'Add'?
                        Column(children: [
                          const SizedBox(height: 15,),
                          getStarLabel('Choose Day'),
                          const SizedBox(height: 5.0,),
                          weekDaysDropdown(),
                        ],)
                        :const SizedBox(),

                    const SizedBox(height: 15,),
                    startEndTimeWidget(),

                    const SizedBox(height: 15,),
                    patientsAndSlotWidget(),

                    const SizedBox(height: 15,),
                    consultancyAndAppointmentWidget(),

                    const SizedBox(height: 15,),
                    adminAndPatientWidget(),

                    // const SizedBox(height: 15,),
                    // activeCheckbox(),

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
  weekDaysDropdown() {
    return MultiSelectDialogField(
      initialValue: getXController.selectedWeekDayList,
      items: getXController.multiWeekDayList,
      listType: MultiSelectListType.LIST,
      buttonText: const Text('Select Week Days'),
      buttonIcon:  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
      searchable: true,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.7, color: Colors.blueGrey),
        ),
      ),
      onConfirm: (values) {
        getXController.selectedWeekDayList = values;
        log('TEST--- ${getXController.selectedWeekDayList}');
      },
    );

  }


  ///*
  ///
  ///
  startEndTimeWidget() {

    return Row(
      children: [

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('Start Time'),
                startTimeWidget()
              ],
            )
        ),

        const SizedBox(width: 25,),

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('End Time'),
                endTimeWidget()
              ],
            )
        ),
      ],
    );
  }


  ///*
  ///
  ///
  startTimeWidget() {
    return TextFormField(
      readOnly: true,
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.startTimeController,
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
                selectTime(getXController.startTimeController);
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
        errorText: getXController.isStartTimeEmpty.value ? "Please Select Start Time" :  null ,
      ),

      onChanged: (value){
        if(value.isNotEmpty &&
            getXController.endTimeController.text.isNotEmpty &&
            getXController.noOfPatientsController.text.isNotEmpty){
          getXController.getTimeSlot();
        }
      },

    );

  }

  ///*
  ///
  ///
  endTimeWidget() {
    return TextFormField(
      readOnly: true,
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.endTimeController,
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
                selectTime(getXController.endTimeController);
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
        errorText: getXController.isEndTimeEmpty.value ? "Please Select End Time" :  null ,
      ),
      onChanged: (value){
        if(value.isNotEmpty &&
            getXController.startTimeController.text.isNotEmpty &&
            getXController.noOfPatientsController.text.isNotEmpty){
          getXController.getTimeSlot();
        }
      },

    );

  }


  ///*
  ///
  ///
  patientsAndSlotWidget() {

    return Row(
      children: [

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('No Of Patients'),
                numberOfPatientsField()
              ],
            )
        ),

        const SizedBox(width: 25,),

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('Time Slot'),
                timeSlotField()
              ],
            )
        ),
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
            widget.callFrom == 'Edit' ? 'Update Schedule' : '${widget.callFrom} Schedule',
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
  Future<bool> _onWillPop() async{
    Get.back(result: ProviderGlobal.isScheduleBack);
    return false;
  }

  ///*
  ///
  ///
  void selectTime(TextEditingController timeController) async{
    final TimeOfDay? result =
        await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );

    if (result != null) {
      setState(() {
        log("TIME :${result.format(context)}");

        final hour = result.hour.toString().padLeft(2, "0");
        final min = result.minute.toString().padLeft(2, "0");
        timeController.text = hour +":"+ min;

        log("TIME :$hour:$min" );

      });
    }

  }

  ///*
  ///
  ///
  Widget clinicDropdown() {
    return DropdownSearch<ProviderClinicListResponse?>(
      dropdownBuilder: _clinicDropDownStyle,
      dropdownButtonProps:  const DropdownButtonProps(
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
          padding: EdgeInsets.zero
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
        ),
      ),
      items: getXController.clinicList,
      itemAsString: (ProviderClinicListResponse? u) => u!.clinicAsString(),
      selectedItem: getXController.selectedClinic.value,
      onChanged: (value) {
        getXController.selectedClinic.value = value!;
      },
    );
  }


  ///*
  ///
  ///
  Widget scheduleTypeDropdown() {
    return DropdownSearch<ProviderScheduleTypeResponse?>(
      dropdownBuilder: _scheduleTypeDropDownStyle,
      dropdownButtonProps:  const DropdownButtonProps(
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
          padding: EdgeInsets.zero
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
        ),
      ),
      items: getXController.scheduleTypeList,
      itemAsString: (ProviderScheduleTypeResponse? u) => u!.typeAsString(),
      selectedItem: getXController.selectedScheduleType.value,
      onChanged: (value) {
        getXController.selectedScheduleType.value = value!;
      },
    );
  }

  ///*
  ///
  ///
  numberOfPatientsField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.noOfPatientsController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(3)],
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
          errorText: getXController.isNoOfPatientEmpty.value? "Please Enter Number Of Patient" : getXController.isInValidNoOfPatient.value ? 'Please Enter Valid Number Of Patient' : null
        // getXController.isMobileNoValid.value ? "Please enter valid 10 digit mobile no.": null
      ),
      onChanged: (value){
        print(value);
        if(value.isEmpty){
          getXController.isNoOfPatientEmpty.value = true;

        }else if(value == '0'){
          getXController.isInValidNoOfPatient.value = true;

        }else{
          getXController.isNoOfPatientEmpty.value = false;
          getXController.isInValidNoOfPatient.value = false;
          getXController.getTimeSlot();
        }
      },
    );

  }

  ///*
  ///
  ///
  timeSlotField() {
    return TextFormField(
      readOnly: true,
      controller: getXController.timeSlotController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      // maxLength: 10,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration:  const InputDecoration(
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
  consultancyAndAppointmentWidget() {
    return Row(
      children: [

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('Consultancy Type'),
                consultancyTypeDropdown()
              ],
            )
        ),

        const SizedBox(width: 25,),

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('Appointment Fee'),
                appointmentFeeField()
              ],
            )
        ),
      ],
    );

  }

  ///*
  ///
  ///
  consultancyTypeDropdown() {
    return DropdownSearch<ProviderConsultancyTypeResponse?>(
      dropdownBuilder: _consultancyDropDownStyle,
      dropdownButtonProps:  const DropdownButtonProps(
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
          padding: EdgeInsets.zero
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
        ),
      ),
      items: getXController.consultancyTypeList,
      itemAsString: (ProviderConsultancyTypeResponse? u) => u!.consultancyAsString(),
      selectedItem: getXController.selectedConsultancyType.value,
      onChanged: (value) {
        getXController.selectedConsultancyType.value = value!;
      },
    );

  }

  ///*
  ///
  ///
  appointmentFeeField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.appointmentFeeController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      // maxLength: 10,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      onChanged: (value){
        if(value.isNotEmpty && value != '0'){
          getXController.getPatientCharges();
        }
      },
      decoration:  InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide:
            BorderSide(color: MyColor.themeSkyBlue),
          ),
          errorText: getXController.isAppointmentFeeEmpty.value? "Please Enter Appointment Fee" : null,
      ),
    );

  }


  ///*
  ///
  ///
  adminAndPatientWidget() {
    return Row(
      children: [

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('Admin Charges'),
                adminChargesField()
              ],
            )
        ),

        const SizedBox(width: 25,),

        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getStarLabel('Patient Charges'),
                patientChargesField()
              ],
            )
        ),
      ],
    );

  }


  ///*
  ///
  ///
  activeCheckbox() {
    return ListTileTheme(
      horizontalTitleGap: 0,
      child: CheckboxListTile(
         title: const Text('Active',
         style:  TextStyle(
             fontSize: 14.0,
             color: MyColor.themeTealBlue,
             fontFamily: 'poppins_semibold'
         ),),
          value: getXController.isActive.value,
          onChanged: (value){
            getXController.isActive.value = value!;
          },
        activeColor: MyColor.themeSkyBlue,
        controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
        contentPadding: EdgeInsets.zero,
      ),
    );
  }


  ///*
  ///
  ///
  Widget _consultancyDropDownStyle(BuildContext context, ProviderConsultancyTypeResponse? selectedData) {
    return Text(
        selectedData!.name!,
        style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
    ); }

  ///*
  ///
  ///
  Widget _clinicDropDownStyle(BuildContext context, ProviderClinicListResponse? selectedData) {
    return Text(
      selectedData!.name!,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
    ); }

  ///*
  ///
  ///
  Widget _scheduleTypeDropDownStyle(BuildContext context, ProviderScheduleTypeResponse? selectedData) {
    return Text(
      selectedData!.name!,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
    ); }

  ///*
  ///
  ///
  patientChargesField() {
    return TextFormField(
      readOnly: true,
      controller: getXController.patientChargesController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      // maxLength: 10,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration:  const InputDecoration(
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
  adminChargesField() {
    return TextFormField(
      readOnly: true,
      controller: getXController.adminChargesController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      // maxLength: 10,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      decoration:  const InputDecoration(
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



}
