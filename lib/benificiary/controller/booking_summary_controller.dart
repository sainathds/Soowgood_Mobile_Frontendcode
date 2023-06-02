import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/model/request/booking_summary_request.dart';
import 'package:soowgood/benificiary/model/request/dummy_payment_request.dart';
import 'package:soowgood/benificiary/model/request/payment_process_request.dart';
import 'package:soowgood/benificiary/model/request/remove_booking_request.dart';
import 'package:soowgood/benificiary/model/response/booking_summary_response.dart';
import 'package:soowgood/benificiary/repository/beneficiary_repository.dart';
import 'package:soowgood/benificiary/screen/beneficiary_main_screen.dart';
import 'package:soowgood/benificiary/screen/beneficiary_payment_screen.dart';
import 'package:soowgood/benificiary/screen/benificiary_dashboard_screen.dart';
import 'package:soowgood/common/dialog/custom_dialog.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingSummaryController extends GetxController{

  BeneficiaryRepository repository = BeneficiaryRepository();

  var bookingId = ''.obs;

  var providerName = ''.obs;
  var providerSpecialist = ''.obs;
  var providerImageUrl = ''.obs;
  var attendName = ''.obs;
  var bookingDate = ''.obs;
  var appointmentDate = ''.obs;
  var time = ''.obs;
  var doctorFee = ''.obs;
  var total = ''.obs;


  var transactionId = ''.obs;

  var bookingHistoryList = <BookingSummaryResponse>[].obs;

  var grandTotal = 0.0.obs;
  var allBookingId = <String>[].obs;

  var  selectedBookingId = ''.obs;

  ///*
  ///
  /// get Bookings/getbookinghistoryforpayment Api Response
  /// to get All booking list
  void getBookingSummaryResponse() async{

    BookingSummaryRequest requestModel = BookingSummaryRequest();
    requestModel.serviceReceiverId = MySharedPreference.getString(KeyConstants.keyUserId);

    var responseModel = await repository.hitGetBookingSummaryApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      bookingHistoryList.clear();
      bookingHistoryList.value = responseModel;

/*
      providerName.value = responseModel[responseModel.length-1].serviceProvider!;
      providerSpecialist.value = responseModel[responseModel.length-1].specializationName!;

      attendName.value = getData(responseModel[responseModel.length-1].patientName);
      bookingDate.value = getData(responseModel[responseModel.length-1].bookingDate);
      appointmentDate.value = getData(responseModel[responseModel.length-1].appointmentDate);
      time.value = '${getData(responseModel[responseModel.length-1].scheduleStartTime)} - ${getData(responseModel[responseModel.length-1].scheduleEndTime)}';
      doctorFee.value = getData(responseModel[responseModel.length-1].paidAmount.toString());
      total.value = getData(responseModel[responseModel.length-1].paidAmount.toString());
*/

    }else{
      bookingHistoryList.clear();
    }
  }


  ///*
  ///
  /// get Bookings/processPayment Api Response
  /// to get transactionId for all bookings to make payment
  void getPaymentProcessResponse() async{

    PaymentProcessRequest requestModel = PaymentProcessRequest();
    requestModel.serviceReceiverId = MySharedPreference.getString(KeyConstants.keyUserId);
    requestModel.id = allBookingId.join(',');
    requestModel.paidAmount = grandTotal.value.toString();
    requestModel.trancurrency = 'BDT';
    requestModel.sourceFrom = 'mobile';

    var responseModel = await repository.hitPaymentProcessApi(requestModel);

    if(responseModel != null){
      transactionId.value = responseModel.id!;
      // redirectToWeb('https://payment.soowgood.com/index.aspx?transactionid=${transactionId.value}');  //uncomment this line if payment account is in working

      dummyPaymentResponse(); //use to make temporary payment if payment account is not in working else comment it and uncomment above line
    }
  }

  ///*
  ///
  ///
  void clearAll() {

    bookingHistoryList.clear();
    allBookingId.clear();

     providerName.value = '';
     providerSpecialist.value = '';
     providerImageUrl.value = '';
     attendName.value = '';
     bookingDate.value = '';
     appointmentDate.value = '';
     time.value = '';
     doctorFee.value = '';
     total.value = '';

     transactionId.value = '';
     bookingId.value = '';

     selectedBookingId.value = '';

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
  void redirectToWeb(String url) async{

  /*  if (await launchUrl(Uri.parse(url),
      mode: LaunchMode.inAppWebView,

    )) {
      throw 'Could not launch $url';
    }
*/

    Get.to(() => BeneficiaryPaymentScreen(url: url,));
  }


  ///*
  ///
  /// use Bookings/removeAppointmentBeforePayment Api to remove booking before payment
  void getRemoveBookingResponse() async{

    RemoveBookingRequest requestModel = RemoveBookingRequest();
    requestModel.id = selectedBookingId.value;

    var responseModel = await repository.hitRemoveBookingApi(requestModel);

    if(responseModel != null){
      if(responseModel.isDeleted!){
        getBookingSummaryResponse(); //call to getUpdated list
      }
    }
  }


  ///*
  ///
  /// use Bookings/updatepaymentransaction api to make temp payment if payment account is not in working
  void dummyPaymentResponse() async{

    DummyPaymentRequest requestModel = DummyPaymentRequest();
    requestModel.tranpkid = transactionId.value;
    requestModel.bankTranId = '1234455555';
    requestModel.statuscode = 'E000';
    requestModel.errormessage = '';

    var response = await repository.hitDummyPaymentApi(requestModel);

    if(response != null && response.success == '1'){
      showDialog(
        context: Get.context!,
        builder: (BuildContext context1) =>
            CustomDialog(
                my_context: Get.context!,
                img: successImage,
                title: "",
                description: response.message!,
                buttonText: 'Ok',
                okBtnFunction: okFunction
            ),
      );
    }
  }



  ///
  ///
  ///
  okFunction() {
    Get.offAll(() => BeneficiaryMainScreen() );
  }
}