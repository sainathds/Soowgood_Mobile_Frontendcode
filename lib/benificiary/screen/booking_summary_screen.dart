import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/controller/booking_summary_controller.dart';
import 'package:soowgood/common/dialog/ask_dialog.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';

class BookingSummaryScreen extends StatefulWidget {
    String bookingId;
   BookingSummaryScreen({Key? key, required this.bookingId}) : super(key: key);

  @override
  _BookingSummaryScreenState createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  BookingSummaryController getXController = Get.put(BookingSummaryController());

  @override
  void initState() {
    // TODO: implement initState
    getXController.clearAll();
    getXController.bookingId.value = widget.bookingId;
    Future.delayed(const Duration(), (){
      getXController.getBookingSummaryResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.white),
      child: Obx((){
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: InkWell(
                onTap: (){
                  Get.back();
                },
                  child: Image(image: backArrowWhiteIcon, color: MyColor.themeTealBlue,)),
              title: const Text(
                'Booking Summary',
                style: TextStyle(
                    color: MyColor.themeTealBlue,
                    fontSize: 17.0,
                    fontFamily: 'poppins_semibold'),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: MyColor.black06,
              child: Column(
                children: [
                  getBookingWidget(),

                  getGrandTotalWidget()

                ],
              ),
            ),
          ),
        );
      })
    );
  }

  ///*
  ///
  ///
  getProviderData(int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            width: 60,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: getImage(getXController.bookingHistoryList[index].providerImage) == ''
                  ? Image(
                image: noProfileImage,
              )
                  : Image.network('${ApiConstant.fileBaseUrl}${ApiConstant.profilePicFolder}${getXController.bookingHistoryList[index].providerImage}',
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.fill, errorBuilder: (BuildContext context,
                      Object exception, StackTrace? stackTrace) {
                    return Image(
                        image: noProfileImage,
                        width: 80,
                        height: 80,
                        fit: BoxFit.fill);
                  }),
            ),
          ),

          const SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getData(getXController.bookingHistoryList[index].serviceProvider),
                  maxLines: 1,
                  style: const TextStyle(
                      color: MyColor.themeTealBlue,
                      fontSize: 15.0,
                      fontFamily: 'poppins_semibold'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(
                    getData(getXController.bookingHistoryList[index].specializationName),
                    maxLines: 1,
                    style: const TextStyle(
                        color: MyColor.themeTealBlue,
                        fontSize: 13.0,
                        fontFamily: 'poppins_medium'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getAppointmentData(int index) {

    return Column(
      children: [

        getXController.bookingHistoryList[index].serviceReceiver != ''?
        getRowData('Attendee Name', getData(getXController.bookingHistoryList[index].serviceReceiver)):  SizedBox(),
        getRowData('Booking Date', getData(getXController.bookingHistoryList[index].bookingDate!.isNotEmpty ? getXController.bookingHistoryList[index].bookingDate!.split(" ")[0] : "")),
        getRowData('Appointment Date', getData(getXController.bookingHistoryList[index].appointmentDate!.isNotEmpty ? getXController.bookingHistoryList[index].appointmentDate!.split(" ")[0] : "")),
        getRowData('Time', '${getData(getXController.bookingHistoryList[index].scheduleStartTime)} - ${getData(getXController.bookingHistoryList[index].scheduleEndTime)}'),
        getRowData('Doctor Fee', getData(getXController.bookingHistoryList[index].paidAmount.toString())),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          height: 1.5,
          color: MyColor.searchBgColor,
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5, bottom: 5),
          child: Row(
            children: [
              const Text(
                'Total',
                style: TextStyle(
                    color: MyColor.themeSkyBlue,
                    fontSize: 17.0,
                    fontFamily: 'poppins_semibold'),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      getData(getXController.bookingHistoryList[index].paidAmount.toString()),
                      maxLines: 1,
                      style: const TextStyle(
                          color: MyColor.themeSkyBlue,
                          fontSize: 17.0,
                          fontFamily: 'poppins_semibold'),
                    ),
                  ],),
              )
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          InkWell(
            onTap: (){
              getXController.selectedBookingId.value = getXController.bookingHistoryList[index].id!;
              showDialog(
                  context: context,
                  builder: (context){
                    return AskDialog(msg: 'Are you sure you want to Remove Appointment', yesFunction: yesFunction); //if yes then call api
                  });
            },
            child: Container(
              height: 35,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.deepOrangeAccent
              ),
              child: Text(
                'Remove',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'poppins_medium'
                ),
              ),
            ),
          )
        ],)
      ],
    );
  }

  ///*
  ///
  ///
  getRowData(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5, bottom: 5),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
                color: MyColor.themeTealBlue,
                fontSize: 13.0,
                fontFamily: 'poppins_medium'),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              Text(
                value,
                maxLines: 1,
                style: const TextStyle(
                    color: MyColor.themeTealBlue,
                    fontSize: 11.0,
                    fontFamily: 'poppins_regular'),
              ),
            ],),
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getGrandTotalWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text('Consulting Fee',
            style: TextStyle(
              fontSize: 12.0,
              color: MyColor.themeTealBlue,
              fontFamily: 'poppins_medium'
            ),),

              Text('BDT ${getGrandTotal()} TK',
              style: TextStyle(
                  fontSize: 18.0,
                  color: MyColor.themeSkyBlue,
                  fontFamily: 'poppins_semibold'
              ),),
          ],),

          InkWell(
            onTap: (){
              getXController.getPaymentProcessResponse(); //call api to get transaction id to make payment
              },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColor.themeSkyBlue
              ),
              child: const Text(
                'Proceed to pay',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontFamily: 'poppins_medium'
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getBookingWidget() {

    return Expanded(
      child: ListView.builder(
         itemCount: getXController.bookingHistoryList.length,
          itemBuilder: (context, index){
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(children: [
                getProviderData(index),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  height: 1.5,
                  color: MyColor.searchBgColor,
                ),
                getAppointmentData(index),
              ],),
            );
          }),
    );
  }


  ///*
  ///
  ///
  String getData(String? data) {
    if(data != null){
      return data;
    }else{
      return '';
    }
  }

  ///*
  ///
  ///
  getGrandTotal() {
    getXController.grandTotal.value = 0;

    for(int index = 0; index < getXController.bookingHistoryList.length ; index++){
      getXController.allBookingId.add(getXController.bookingHistoryList[index].id.toString());
      getXController.grandTotal.value = getXController.grandTotal.value + getXController.bookingHistoryList[index].paidAmount!;
    }
    return getXController.grandTotal.value;
  }

  ///*
  ///
  ///
  getImage(String? providerImage) {
    if(providerImage != null){
      return '${ApiConstant.fileBaseUrl}${ApiConstant.profilePicFolder}$providerImage';
    }else{
      return '';
    }
  }


  ///*
  ///
  ///
  yesFunction() {
    getXController.getRemoveBookingResponse();

  }
}
