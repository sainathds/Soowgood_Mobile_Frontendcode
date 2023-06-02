import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/screen/beneficiary_main_screen.dart';
import 'package:soowgood/benificiary/screen/beneficiry_doctors_screen.dart';
import 'package:soowgood/benificiary/screen/benificiary_dashboard_screen.dart';
import 'package:soowgood/common/dialog/custom_progress_dialog.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:webviewx/webviewx.dart';

class BeneficiaryPaymentScreen extends StatefulWidget {

  String url;
  BeneficiaryPaymentScreen({Key? key, required this.url}) : super(key: key);

  @override
  _BeneficiaryPaymentScreenState createState() => _BeneficiaryPaymentScreenState();
}

class _BeneficiaryPaymentScreenState extends State<BeneficiaryPaymentScreen> {

  late WebViewXController webviewController;
  CustomProgressDialog progressDialog = CustomProgressDialog();

  @override
  void initState() {
    // TODO: implement initState

    log('WEB-LINK ${widget.url}');
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: InkWell(
              onTap: (){
                Get.offUntil(MaterialPageRoute(builder: (context) => const BeneficiaryMainScreen()),(route) => false);
                Get.to(() => BeneficiaryDashboardScreen());
              },
              child: Image(image: backArrowWhiteIcon, color: MyColor.themeTealBlue,)),
          title: const Text(
            "Payment",
            style: TextStyle(
              fontSize: 16,
              color: MyColor.themeTealBlue,
              fontFamily: 'poppins_semibold'
            ),
          ),

        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: WebViewX(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  initialContent: widget.url,
                  initialSourceType: SourceType.url,
                  onPageStarted: (src){
                    },
                  onPageFinished: (src){
                    progressDialog.close();
                    },
                  onWebViewCreated: (controller){
                    webviewController = controller;
                    progressDialog.showProgressDialog();
                  },
                )
              ),
            ),

/*
            InkWell(
              onTap: (){
                Get.offUntil( MaterialPageRoute(builder: (context) => const BeneficiaryMainScreen()),(route) => false);
                Get.to(() => BeneficiaryDashboardScreen());
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                color: MyColor.themeSkyBlue,
                child: Text('View Appointments',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'poppins_semibold',
                  fontSize: 16.0
                ),),
              ),
            )
*/
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  void showProgress() {
  }

  ///*
  ///
  ///
  void dismissProgress() {
  }

  ///*
  ///
  ///
  Future<bool> _onWillPop() async{
    Get.offUntil( MaterialPageRoute(builder: (context) => const BeneficiaryMainScreen()),(route) => false);
    Get.to(() => BeneficiaryDashboardScreen());
    return false;
  }
}
