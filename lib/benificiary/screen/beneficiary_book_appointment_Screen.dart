import 'dart:developer';

import 'package:chip_list/chip_list.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:readmore/readmore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:soowgood/benificiary/controller/beneficiary_book_appointment_controller.dart';
import 'package:soowgood/benificiary/model/response/schedule_for_booking_response.dart';
import 'package:soowgood/common/dialog/custom_progress_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/common/resources/my_string.dart';

class BeneficiaryBookAppointmentScreen extends StatefulWidget {
  String providerId;
  String appointmentType;

  BeneficiaryBookAppointmentScreen({Key? key, required this.providerId, required this.appointmentType}) : super(key: key);

  @override
  _BeneficiaryBookAppointmentScreenState createState() => _BeneficiaryBookAppointmentScreenState();
}

class _BeneficiaryBookAppointmentScreenState extends State<BeneficiaryBookAppointmentScreen> {
  CustomProgressDialog progressDialog = CustomProgressDialog();

  BeneficiaryBookAppointmentController getXController = Get.put(BeneficiaryBookAppointmentController());
  late Size size;

  @override
  void initState() {
    // TODO: implement initState

    getXController.clearAll();
    MySharedPreference.getInstance();
    PluginGooglePlacePicker.initialize(androidApiKey: MyString.googleApiKey,iosApiKey: MyString.googleApiKey); //init google placepicker

    getXController.providerId = widget.providerId;
    Future.delayed(const Duration(), () {
      getXController.getProviderDataResponse();
      getXController.getRatingDataResponse();
    });

    Future.delayed(const Duration(), () {
      getXController.getEducationListResponse();
    });

    Future.delayed(const Duration(), () {
      getXController.getSpecializationListResponse();
    });

    getXController.showModalSheet = showUploadDocumentSheet; //init upload documentSheet use to upload doc like prescription , test report and patinet name

    log('APPOINTMENT_TYPE ${widget.appointmentType}');

    if (widget.appointmentType.isNotEmpty) {    //get provider appointment types form previous screen
      if (widget.appointmentType.contains(',')) {
        getXController.appointmentType.value = widget.appointmentType.split(',');
      } else {
        getXController.appointmentType.add(widget.appointmentType); //add appointmentType in getXController.appointmentType at 0th position
      }

      if (getXController.appointmentType[0] == 'Clinic') {
        getXController.selectedAppointmentType.value = 'Clinic';
        getXController.isOnlineSelected.value = false;
        getXController.isPhysicsSelected.value = false;
        getXController.isClinicSelected.value = !getXController.isClinicSelected.value;
        Future.delayed(const Duration(), () async {
          await getXController.getScheduleListResponse().then((value) => { //get scheduleList for 0th position of appointmentType if 'Clinic'
                getXController.selectedClinicData.value = getXController.cliniList.first,
                getClinicWiseSchedule(getXController.cliniList.first.clinicId), //get scheduleList for 0th position of clinic
              });
        });
      } else if (getXController.appointmentType[0] == 'Online') {
        getXController.selectedAppointmentType.value = 'Online';
        getXController.isClinicSelected.value = false;
        getXController.isPhysicsSelected.value = false;
        getXController.isOnlineSelected.value = !getXController.isOnlineSelected.value;
        Future.delayed(const Duration(), () {
          getXController.getScheduleListResponse().then((value) => { //get scheduleList for 0th position of appointmentType if 'Online'
                getXController.selectedClinicData.value = getXController.cliniList.first,
                getClinicWiseSchedule(getXController.cliniList.first.clinicId), //get scheduleList for 0th position of clinic
              });
        });
      } else if (getXController.appointmentType[0] == 'Physical Visit') {
        getXController.selectedAppointmentType.value = 'Physical Visit';
        getXController.isClinicSelected.value = false;
        getXController.isOnlineSelected.value = false;
        getXController.isPhysicsSelected.value = !getXController.isPhysicsSelected.value;
        Future.delayed(const Duration(), () {
          getXController.getScheduleListResponse().then((value) => { //get scheduleList for 0th position of appointmentType if 'Physical Visit'
                getXController.selectedClinicData.value = getXController.cliniList.first,
                getClinicWiseSchedule(getXController.cliniList.first.clinicId), //get scheduleList for 0th position of clinic
              });
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Obx(() {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          body: Container(
            height: size.height,
            width: size.width,
            color: MyColor.tealBlueDark,
            child: Stack(children: [
              Positioned(
                  top: 20,
                  left: 5,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ))),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: getImage(),
                    ),
                    Expanded(
                      flex: 2,
                      child: getDetail(),
                    ),

                    // getButton()
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }

  ///*
  ///
  ///
  getImage() {
    return Container(
        padding: const EdgeInsets.only(top: 30.0, left: 40, right: 40),
        child: getXController.providerImageUrl.value.isNotEmpty
            ? Image.network(
                getXController.providerImageUrl.value,
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Image(image: noImage, fit: BoxFit.fill);
                },
              )
            : Image(image: noImage, fit: BoxFit.fill));
  }

  ///*
  ///
  ///
  getDetail() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      getXController.name.value,
                      style: const TextStyle(color: MyColor.themeTealBlue, fontSize: 17, fontFamily: 'poppins_semibold'),
                    ),
                  ),
                  getXController.specializationDataList != null && getXController.specializationDataList.isNotEmpty
                      ? Text(
                          getXController.specializationDataList[0],
                          style: const TextStyle(color: MyColor.tealBlueDark, fontSize: 13, fontFamily: 'poppins_semibold'),
                        )
                      : const SizedBox()
                ],
              ),
              InkWell(
                onTap: () async {
                  await getXController.getRatingListDataResponse().then((value) => Alert(
                          context: context,
                          title: "Ratings & Reviews",
                          style: AlertStyle(titleStyle: const TextStyle(color: MyColor.themeTealBlue, fontSize: 17, fontFamily: 'poppins_semibold')),
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          buttons: [],
                          content: getXController.ratingDataList.isNotEmpty
                              ? Container(
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: getXController.ratingDataList.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                          margin: EdgeInsets.all(2),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 5),
                                            child: ListTile(
                                              title: Text(
                                                "${getXController.ratingDataList[index].serviceReceiver}",
                                                style: TextStyle(color: MyColor.themeTealBlue, fontSize: 14, fontFamily: 'poppins_medium'),
                                              ),
                                              subtitle: Text(
                                                "${getXController.ratingDataList[index].providerreview}",
                                                style: TextStyle(color: MyColor.themeTealBlue, fontSize: 14, fontFamily: 'poppins_regular'),
                                              ),
                                              trailing: Text(
                                                getXController.ratingDataList[index].ratingpoints == 5
                                                    ? "⭐⭐⭐⭐⭐"
                                                    : getXController.ratingDataList[index].ratingpoints == 4
                                                        ? "⭐⭐⭐⭐"
                                                        : getXController.ratingDataList[index].ratingpoints == 3
                                                            ? "⭐⭐⭐"
                                                            : getXController.ratingDataList[index].ratingpoints == 2
                                                                ? "⭐⭐"
                                                                : getXController.ratingDataList[index].ratingpoints == 1
                                                                    ? "⭐"
                                                                    : "",
                                                style: TextStyle(color: MyColor.themeTealBlue, fontSize: 14, fontFamily: 'poppins_medium'),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              : const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "No reviews available",
                              style: TextStyle(color: MyColor.themeTealBlue, fontSize: 15, fontFamily: 'poppins_medium'),
                            ),
                            
                          ))
                      .show());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getXController.ratingCount == "0"
                          ? ''
                          : getXController.ratingCount == "1"
                              ? '*'
                              : getXController.ratingCount == "2"
                                  ? '**'
                                  : getXController.ratingCount == "3"
                                      ? '***'
                                      : getXController.ratingCount == "4"
                                          ? '****'
                                          : '*****',
                      style: TextStyle(color: Colors.blue, fontSize: 17, fontFamily: 'poppins_semibold'),
                    ),
                    Text(
                      getXController.reviews + " reviews",
                      style: const TextStyle(color: Colors.blue, fontSize: 13, fontFamily: 'poppins_medium'),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.black12,
            height: 1.2,
          ),
          const Text(
            'About',
            style: TextStyle(color: MyColor.themeTealBlue, fontSize: 15, fontFamily: 'poppins_semibold'),
          ),
          const SizedBox(
            height: 5,
          ),
          ReadMoreText(
            getXController.aboutContent.value,
            trimLines: 2,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read More',
            trimExpandedText: ' Read Less',
            moreStyle: const TextStyle(color: Colors.blue, fontSize: 12, fontFamily: 'poppins_medium'),
            lessStyle: const TextStyle(color: Colors.blue, fontSize: 12, fontFamily: 'poppins_medium'),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Educational history',
            style: TextStyle(color: MyColor.themeTealBlue, fontSize: 15, fontFamily: 'poppins_semibold'),
          ),
          getEducationalHistory(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Specialization',
            style: TextStyle(color: MyColor.themeTealBlue, fontSize: 15, fontFamily: 'poppins_semibold'),
          ),
          getSpecializationList(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'How would you like to consult?',
            style: TextStyle(color: MyColor.themeTealBlue, fontSize: 15, fontFamily: 'poppins_semibold'),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              widget.appointmentType.contains('Clinic')
                  ? Expanded(
                      child: getClinicOption('Clinic'),
                    )
                  : const SizedBox(),
              widget.appointmentType.contains('Online')
                  ? Expanded(
                      child: getOnlineOption('Online'),
                    )
                  : const SizedBox(),
              widget.appointmentType.contains('Physical Visit') ? Expanded(child: getPhysicalOption('Physical')) : const SizedBox()
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.black12,
            height: 1.2,
          ),
          const Text(
            'Choose Clinic',
            style: TextStyle(color: MyColor.themeTealBlue, fontSize: 15, fontFamily: 'poppins_semibold'),
          ),
          getClinicList(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.black12,
            height: 1.2,
          ),
          getXController.selectedClinicData.value.clinicId != null && getXController.selectedClinicData.value.clinicId != ''
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            getXController.selectedClinicData.value.clinicname!,
                            style: const TextStyle(color: MyColor.themeTealBlue, fontSize: 12, fontFamily: 'poppins_semibold'),
                          ),
                        ),
                        Expanded(
                          child: dateFilterDropdown(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    getScheduleList(),
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getClinicOption(String callFrom) {
    return InkWell(
      onTap: () {
        setState(() {
          getXController.clinicScheduleList.clear();
          getXController.clinicWiseDateData.clear();
          getXController.selectedAppointmentType.value = 'Clinic';
          getXController.isOnlineSelected.value = false;
          getXController.isPhysicsSelected.value = false;
          getXController.isClinicSelected.value = true;
          getXController.getScheduleListResponse().then((value) => {
                getXController.selectedClinicData.value = getXController.cliniList.first,
                getClinicWiseSchedule(getXController.cliniList.first.clinicId),
                setState(() {}),
              });
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getXController.isClinicSelected.value ? MyColor.themeTealBlue : Colors.black12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Clinic',
              style: TextStyle(
                color: getXController.isClinicSelected.value ? Colors.white : MyColor.tealBlueLight,
              ),
            ),
            Icon(Icons.home_outlined, size: 30, color: getXController.isClinicSelected.value ? Colors.white : MyColor.tealBlueLight)
            /*Image(image: clinicIcon,
              color: getXController.isClinicSelected.value? Colors.white : MyColor.tealBlueLight,)*/
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  getOnlineOption(String callFrom) {
    return InkWell(
      onTap: () {
        setState(() {
          getXController.clinicScheduleList.clear();
          getXController.clinicWiseDateData.clear();
          getXController.selectedAppointmentType.value = 'Online';
          getXController.isClinicSelected.value = false;
          getXController.isPhysicsSelected.value = false;
          getXController.isOnlineSelected.value = true;
          getXController.getScheduleListResponse().then((value) => {
                getXController.selectedClinicData.value = getXController.cliniList.first,
                getClinicWiseSchedule(getXController.cliniList.first.clinicId),
                setState(() {}),
              });
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getXController.isOnlineSelected.value ? MyColor.themeTealBlue : Colors.black12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Online',
              style: TextStyle(
                color: getXController.isOnlineSelected.value ? Colors.white : MyColor.tealBlueLight,
              ),
            ),
            Icon(Icons.videocam_outlined, size: 30, color: getXController.isOnlineSelected.value ? Colors.white : MyColor.tealBlueLight)

            /*Image(image: clinicIcon,
              color: getXController.isOnlineSelected.value? Colors.white : MyColor.tealBlueLight,)*/
          ],
        ),
      ),
    );
  }

  ///*

  ///*
  ///
  ///
  getPhysicalOption(String callFrom) {
    return InkWell(
      onTap: () {
        setState(() {
          getXController.clinicScheduleList.clear();
          getXController.clinicWiseDateData.clear();
          getXController.selectedAppointmentType.value = 'Physical Visit';
          getXController.isClinicSelected.value = false;
          getXController.isOnlineSelected.value = false;
          getXController.isPhysicsSelected.value = true;
          getXController.getScheduleListResponse().then((value) => {
                getXController.selectedClinicData.value = getXController.cliniList.first,
                getClinicWiseSchedule(getXController.cliniList.first.clinicId),
                setState(() {}),
              });
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: getXController.isPhysicsSelected.value ? MyColor.themeTealBlue : Colors.black12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Physical Visit',
              style: TextStyle(
                color: getXController.isPhysicsSelected.value ? Colors.white : MyColor.tealBlueLight,
              ),
            ),
            Icon(Icons.apartment_sharp, size: 30, color: getXController.isPhysicsSelected.value ? Colors.white : MyColor.tealBlueLight)
            /*Image(image: clinicIcon,
              color: getXController.isPhysicsSelected.value? Colors.white : MyColor.tealBlueLight,)
*/
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  getClinicList() {
    return Container(
      height: 150,
      child: ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: getXController.cliniList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  getXController.selectedClinicData.value = getXController.cliniList[index];
                  getClinicWiseSchedule(getXController.cliniList[index].clinicId);
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: index % 2 == 0 ? MyColor.clinicBgColor : MyColor.searchBgColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(right: 0.0),
                            width: 18,
                            height: 18,
                            child: const Icon(
                              Icons.home,
                              color: Colors.orange,
                              size: 18,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            getData(getXController.cliniList[index].clinicname!),
                            maxLines: 3,
                            style: const TextStyle(fontSize: 13, color: MyColor.themeTealBlue, fontFamily: 'poppins_medium'),
                          ),
                        ),
                      ],
                    ),

                    /*const Padding(
                      padding: EdgeInsets.only(left:25.0),
                      child: Text(
                          getData(getXController.cliniList[index].),
                        style: TextStyle(
                            fontSize: 10,
                            color: MyColor.themeTealBlue,
                            fontFamily: 'poppins_regular'
                        ),
                      ),
                    ),*/

                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(0.0),
                            width: 18,
                            height: 18,
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 18,
                            )),
                        // Image(image: homeTkIc, height: 12, width: 12,),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            getData(getXController.cliniList[index].clinicname!),
                            maxLines: 3,
                            style: const TextStyle(fontSize: 10, color: MyColor.themeTealBlue, fontFamily: 'poppins_regular'),
                          ),
                        ),
                      ],
                    ),

                    /*const SizedBox(height: 5,),
                    Row(
                      children: [
                        const SizedBox(width: 5,),
                        Image(image: homeTkIc, height: 12, width: 12,),
                        const SizedBox(width: 10,),
                        const Text(
                            '800 TK',
                          style: TextStyle(
                              fontSize: 10,
                              color: MyColor.themeTealBlue,
                              fontFamily: 'poppins_regular'
                          ),
                        ),
                      ],
                    ),
*/
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
  getEducationalHistory() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: getXController.educationList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getData(getXController.educationList[index].yearOfCompletion.toString()),
                  style: const TextStyle(fontSize: 12.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('-'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getData(getXController.educationList[index].name),
                          style: const TextStyle(fontSize: 12.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_regular'),
                        ),
                        Text(
                          getData(getXController.educationList[index].institution),
                          style: const TextStyle(fontSize: 12.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_regular'),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  ///*
  ///
  ///
  String getData(String? data) {
    if (data != null) {
      return data;
    } else {
      return data = '';
    }
  }

  ///*
  ///
  ///
  getSpecializationList() {
    return Wrap(
      spacing: 5,
      children: List.generate(getXController.specializationDataList.length, (index) {
        return Chip(
            label: Text(
          getXController.specializationDataList[index],
          style: const TextStyle(fontSize: 11, color: MyColor.themeTealBlue, fontFamily: 'poppins_medium'),
        ));
      }),
    );
  }

  ///*
  ///
  ///
  getScheduleList() {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
        itemCount: getXController.clinicScheduleList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (getXController.clinicScheduleList[index].alreadybooked == 0) {
                getXController.selectedScheduleData.value = getXController.clinicScheduleList[index];
                getXController.isDataValid();
              }
            },
            child: Container(
              height: 40,
              color: getXController.clinicScheduleList[index].alreadybooked == 1 ? Colors.redAccent : Colors.lightGreen,
              // margin: EdgeInsets.symmetric(vertical: 2),
              padding: const EdgeInsets.symmetric(horizontal: 15),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getXController.clinicScheduleList[index].appointmentDate!,
                    style: const TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: 'poppins_medium'),
                  ),
                  Text(
                    getXController.clinicScheduleList[index].appointmentDayOfWeek!,
                    style: const TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: 'poppins_medium'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        getTime(getXController.clinicScheduleList[index].appointmentstartime!),
                        style: const TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: 'poppins_medium'),
                      ),
                      const Text(
                        ' - ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        getTime(getXController.clinicScheduleList[index].appointmentendtime!),
                        style: const TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: 'poppins_medium'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  ///*
  ///getTime
  ///
  String getTime(String? time) {
    if (time != null || time!.isNotEmpty) {
      String newTime = time.substring(0, 5);
      return newTime;
    } else {
      return time;
    }
  }

  ///*
  ///
  ///
  getButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      width: MediaQuery.of(context).size.width,
      height: 55,
      color: Colors.white,
      child: ElevatedButton(
          onPressed: () {
            getXController.isDataValid();
            /*log('PROVIDER_ID ${getXController.providerList[index].providerId!}' );
            Get.to(() => BeneficiaryBookAppointmentScreen(providerId: getXController.providerList[index].providerId!,));*/
            // showUploadDocumentSheet();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColor.themeSkyBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Book Appointment',
              style: TextStyle(color: MyColor.offWhite, fontSize: 15.0, fontFamily: 'poppins_semibold'),
            ),
          )),
    );
  }

  ///*
  ///
  ///
  showUploadDocumentSheet() {
    getXController.nameController.clear();
    if (MySharedPreference.getString(KeyConstants.keyFullName) != null) {
      getXController.nameController.text = MySharedPreference.getString(KeyConstants.keyFullName);
    }
    showModalBottomSheet(
        isDismissible: false,
        // isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Obx(() {
            return getUploadDocumentView();
          });
        });
  }

  ///*
  ///
  ///
  getUploadDocumentView() {
    return WillPopScope(
      onWillPop: _willPop,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: MyColor.themeTealBlue
                      ),
                      child: Text(
                        'Close',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins_medium',
                            fontSize: 11
                        ),
                      )),
                )
              ],
            ),

            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              onTap: () {
                getXController.setAllErrorToFalse();
              },
              controller: getXController.nameController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: 14.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold'),
              decoration: InputDecoration(
                  labelText: 'Name Of Patient',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyColor.themeSkyBlue),
                  ),
                  errorText: getXController.isNameEmpty.value ? "Please Enter Patient Name" : null),
            ),
            const SizedBox(
              height: 15,
            ),
            getXController.selectedAppointmentType.value == 'Physical Visit' //if appointment type is Physical Visit then show address filed
                ? TextFormField(
                    onTap: () async {
                      getXController.setAllErrorToFalse();
                      Place place = await showPlacePicker(); //use to search address
                      getXController.addressController.text = place.address!;
                    },
                    controller: getXController.addressController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 14.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold'),
                    decoration: InputDecoration(
                        labelText: 'Address',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: MyColor.themeSkyBlue),
                        ),
                        errorText: getXController.isAddressEmpty.value == true ? "Please Enter Address" : null),
                  )
                : SizedBox(),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 10, right: 10.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: MyColor.searchBgColor),
              child: InkWell(
                onTap: () {
                  selectDocFile(); //select doc file i.e jpg, png or pdf
                },
                child: Row(
                  children: [
                    Image(image: uploadImg),
                    getXController.fileName.value == ''
                        ? const Expanded(
                            child: Text(
                              'Attach your prescription or medical documents JPG, PNG, PDF (upto 5MB)',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12.0, color: MyColor.searchColor, fontFamily: 'poppins_semibold'),
                            ),
                          )
                        : Text(
                            getXController.fileName.value,
                            style: const TextStyle(color: MyColor.themeTealBlue, fontSize: 12.0, fontFamily: 'poppins_semibold'),
                          )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image(
                  image: yellowClock,
                  height: 15.0,
                  width: 15.0,
                  color: MyColor.themeTealBlue,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    'Your Schedule is ${getXController.startTime} - ${getXController.endTime}',
                    style: const TextStyle(fontSize: 12.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                // Image(image: homeTkIc, height: 15.0, width: 15.0, color: MyColor.themeTealBlue,),
                const Icon(
                  Icons.account_balance_wallet_sharp,
                  color: MyColor.themeTealBlue,
                ),

                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Text(
                    'You have to pay ${getXController.paidAmount}',
                    style: const TextStyle(fontSize: 12.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                // Image(image: homeTkIc, height: 15.0, width: 15.0, color: MyColor.themeTealBlue,),

                const Icon(
                  Icons.warning,
                  color: MyColor.themeTealBlue,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Expanded(
                  child: Text(
                    "You can't change or edit the schedule for this doctor",
                    style: TextStyle(fontSize: 12.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  height: 15,
                  width: 15,
                  child: Checkbox(
                    value: getXController.isAccepted.value,
                    onChanged: (value) {
                      getXController.isAccepted.value = value!;
                    },
                    fillColor: MaterialStateProperty.all(MyColor.themeTealBlue),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                const Text(
                  "I accept terms and conditions",
                  style: TextStyle(fontSize: 12.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold'),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.white,
              child: ElevatedButton(
                  onPressed: () {
                    if (getXController.isAccepted.value) {
                      getXController.isPatientDataValid();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: getXController.isAccepted.value ? MyColor.themeSkyBlue : Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Continue Booking',
                      style: TextStyle(color: MyColor.offWhite, fontSize: 15.0, fontFamily: 'poppins_semibold'),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  ///*
  ///
  /// use file_picker: ^5.1.0 dependency
  /// use to select document with format i.e png, jpg or pdf
  void selectDocFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile platformFile = result.files.first;
      getXController.fileName.value = platformFile.name;
      // getXController.filetype = file.extension!;
      if (platformFile.path != null) {
        getXController.file.value = platformFile.path!;
        getXController.getUploadPrescriptionResponse(); //upload document i.e prescription , or any test related doc
      }

      print(platformFile.name);
      print(platformFile.bytes);
      print(platformFile.size);
      print(platformFile.extension);
      print(platformFile.path);
    } else {
      // User canceled the picker
    }
  }

  ///*
  ///
  /// show google placepicker to search for address
  /// use google_places_picker: ^3.0.2 dependency
  /// to use placepicker enable places api from google dev. console
  static Future<Place> showPlacePicker() async {
    return await PluginGooglePlacePicker.showAutocomplete(mode: PlaceAutocompleteMode.MODE_OVERLAY, typeFilter: TypeFilter.ESTABLISHMENT);
  }

  ///*
  ///
  ///
  dateFilterDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            'Select Date',
            style: TextStyle(fontSize: 12, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold'),
          ),
        ),
        DropdownSearch<Appointmentdatedata?>(
          dropdownBuilder: _genderTypeStyle,
          dropdownButtonProps: const DropdownButtonProps(
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey,
              ),
              padding: EdgeInsets.zero),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(
                left: 10,
              ),
              /*label: Text('Select Date', style: TextStyle(
                  fontSize: 14.0,
                  color: MyColor.tealBlueLight,
                  fontFamily: 'poppins_medium'
              ),),*/
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
          items: getXController.clinicWiseDateData.value,
          itemAsString: (Appointmentdatedata? u) => u!.dateAsString(),
          selectedItem: getXController.selectedAppointmentDate.value,
          onChanged: (value) {
            getXController.selectedDate.value = value!.appointmentDate!;
            if (getXController.selectedDate.value != 'All') {
              getDateWiseSchedule();
            } else {
              getXController.clinicScheduleList.clear();
              getXController.clinicScheduleList.addAll(getXController.tempClinicScheduleList);
            }
          },
        ),
      ],
    );
  }

  Widget _genderTypeStyle(BuildContext context, Appointmentdatedata? selectedItem) {
    return Text(
      selectedItem!.appointmentDate != null ? selectedItem.appointmentDate! : "",
      style: const TextStyle(fontSize: 12.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_semibold'),
    );
  }

  ///*
  ///
  /// filter allScheduleList for selected clinic to get filtered clinicScheduleList
  /// and also filter allAppointmentDateData List for particular clinic to get filtered clinicWiseDateData List
  Future<void> getClinicWiseSchedule(String? clinicId) async {
    getXController.clinicScheduleList.clear();
    getXController.clinicWiseDateData.clear();

    if (clinicId != null && clinicId.isNotEmpty) {
      // progressDialog.showProgressDialog();
      for (Data schedule in getXController.allScheduleList) {
        if (schedule.clinicId == clinicId) {
          getXController.clinicScheduleList.add(schedule);
          await Future.delayed(const Duration(milliseconds: 1));
        }
      }
      // progressDialog.close();
    }
    getXController.tempClinicScheduleList.addAll(getXController.clinicScheduleList);

    if (clinicId != null && clinicId.isNotEmpty) {
      for (Appointmentdatedata dateData in getXController.allAppointmentDateData) {
        if (dateData.clinicId == clinicId) {
          getXController.clinicWiseDateData.add(dateData);
        }
      }
    }
    Appointmentdatedata data = Appointmentdatedata();
    data.clinicId = '';
    data.appointmentDayOfWeek = '';
    data.appointmentDate = 'All';
    data.caldate = '';
    getXController.clinicWiseDateData.insert(0, data);
    getXController.selectedAppointmentDate.value = getXController.clinicWiseDateData[0];
  }

  ///*
  ///
  /// filter clinicScheduleList for selected Date
  void getDateWiseSchedule() {
    getXController.clinicScheduleList.clear();

    if (getXController.selectedDate.value != null && getXController.selectedDate.value != '') {
      for (Data schedule in getXController.tempClinicScheduleList) {
        if (schedule.appointmentDate == getXController.selectedDate.value) {
          getXController.clinicScheduleList.add(schedule);
        }
      }
    }
  }

  ///
  ///
  ///
  Future<bool> _willPop() {
    Get.back();
    return Future.value(false);
  }
}
