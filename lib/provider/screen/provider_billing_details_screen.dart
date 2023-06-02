import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_billing_details_controller.dart';
import 'package:soowgood/provider/model/response/provider_consultancy_type_response.dart';

class ProviderBillingDetailsScreen extends StatefulWidget {
  const ProviderBillingDetailsScreen({Key? key}) : super(key: key);

  @override
  _ProviderBillingDetailsScreenState createState() => _ProviderBillingDetailsScreenState();
}

class _ProviderBillingDetailsScreenState extends State<ProviderBillingDetailsScreen> {
  ProviderBillingDetailsController getXController = Get.put(ProviderBillingDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    getXController.clearAll();
    Future.delayed(const Duration(),(){
      getXController.getBillInformation();

    });

    Future.delayed(const Duration(),(){
      getXController.getBillingHistoryResponse();

    });

    Future.delayed(Duration(),(){
      getXController.getAppointmentTypeResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,

            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
            title: const Text('Billing Details'),
          ),

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  getXController.isBillingSetupInfoShow.value?
                   showBillingSetupInfo()
                  :Container(
                    alignment: Alignment.center,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: MyColor.themeTealBlue),
                      color: MyColor.clinicBgColor
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Add at least one method to take your cash.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: MyColor.themeTealBlue,
                              fontFamily: 'poppins_medium'
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            showDialog(
                              barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context){
                                  return showPaymentMethodOption();
                                });
                          },
                          child: Container(
                            height: 30,
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: MyColor.themeTealBlue
                            ),
                            child:
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_circle_outline, color: Colors.white,
                                size: 20,),
                                const SizedBox(width: 5,),
                                const Text(
                                  'Add Billing Method',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'poppins_medium'
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getXController.appointmentTypeList.isNotEmpty?
                      Expanded(child: appointmentTypeDropdown(),):SizedBox(),
                      SizedBox(width: 10,),
                      getXController.paymentStatusList.isNotEmpty?
                      Expanded(child: paymentStatusDropdown(),):SizedBox(),
                    ],
                  ),

                  getXController.billingHistoryList.isNotEmpty?
                      showBillingHistory() : Center(child: Text('No Data Found'),)
                ],
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
  Widget showPaymentMethodOption() {
    return Dialog(
      child: Obx((){
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              RadioListTile(
                // contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                value: 'Bank Account',
                title: Row(
                  children: [
                    Image(image: paypalMethodIc, width: 30, height: 30,),

                    const Text("Bank Account",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'poppins_regular'),
                    ),
                  ],
                ),
                groupValue: getXController.selectedMethod.value,
                onChanged: (value){
                  getXController.selectedMethod.value = value.toString();

                },
              ),

              RadioListTile(
                // contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                value: 'Google Pay',
                title: Row(
                  children: [
                    Image(image: paypalMethodIc, width: 30, height: 30,),

                    const Text("Google Pay",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'poppins_regular'),
                    ),
                  ],
                ),
                groupValue: getXController.selectedMethod.value,
                onChanged: (value){
                  getXController.selectedMethod.value = value.toString();

                  log('Selected Method : ${getXController.selectedMethod.value}');
                  },
              ),

              RadioListTile(
                // contentPadding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                value: 'Paypal',
                title: Row(
                  children: [
                    Image(image: paypalMethodIc, width: 30, height: 30,),
                    const Text("Paypal",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'poppins_regular'),
                    ),
                  ],
                ),
                groupValue: getXController.selectedMethod.value,
                onChanged: (value){
                  getXController.selectedMethod.value = value.toString();

                },
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        getXController.selectedMethod.value = '';
                        Get.back();
                        },
                      child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: MyColor.searchBgColor
                        ),
                        child: const Text(
                          'Close',
                          style: (
                              TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: 'poppins_regular'
                              )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        Get.back();
                        if(getXController.selectedMethod.value == 'Bank Account'){
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context){
                                return showBankAccountDialog();
                              });

                        }else if(getXController.selectedMethod.value == 'Google Pay'){
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context){
                                return showGooglePayDialog();
                              });
                        }else{
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context){
                                return showPayPalDialog();
                              });
                        }

                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.black
                        ),
                        child: const Text(
                          'Next',
                          style: (
                              TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontFamily: 'poppins_regular'
                              )
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              )
            ]);
      })
    );
  }


  ///*
  ///
  ///
  Widget showBankAccountDialog() {
    return Dialog(
      backgroundColor: Colors.white,
      child: Obx((){
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Fill the Required Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'poppins_semibold'
                    ),
                  ),
                ),

                bankNameField(),
                const SizedBox(height: 20,),
                branchNameField(),
                const SizedBox(height: 20,),
                accountNameField(),
                const SizedBox(height: 20,),
                accountNumberField(),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10, top: 15),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: MyColor.searchBgColor
                          ),
                          child: const Text(
                            'Close',
                            style: (
                                TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontFamily: 'poppins_regular'
                                )
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          Get.back();
                          getXController.isBankDataValid();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.black
                          ),
                          child: const Text(
                            'Save',
                            style: (
                                TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontFamily: 'poppins_regular'
                                )
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                )


              ],
            ),
          ),
        );
      })
    );
  }

  ///*
  ///
  ///
  Widget showGooglePayDialog() {
    return Dialog(
        backgroundColor: Colors.white,
        child: Obx((){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [


                  const Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Fill the Required Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'poppins_semibold'
                      ),
                    ),
                  ),

                  gPayNumberField(),


                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 10, top: 25),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: MyColor.searchBgColor
                            ),
                            child: const Text(
                              'Close',
                              style: (
                                  TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontFamily: 'poppins_regular'
                                  )
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            getXController.isGPayDataValid();
                            if(!getXController.isGPayDataInValid.value){
                              Get.back();
                            }

                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.black
                            ),
                            child: const Text(
                              'Save',
                              style: (
                                  TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'poppins_regular'
                                  )
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  )


                ],
              ),
            ),
          );
        })
    );
  }

  ///*
  ///
  ///
  Widget showPayPalDialog() {
    return Dialog(
        backgroundColor: Colors.white,
        child: Obx((){
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [


                  const Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Text(
                      'Fill the Required Details',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'poppins_semibold'
                      ),
                    ),
                  ),

                  emailField(),
                  SizedBox(height: 15,),
                  payPalNumberField(),


                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 10, top: 25),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: MyColor.searchBgColor
                            ),
                            child: const Text(
                              'Close',
                              style: (
                                  TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontFamily: 'poppins_regular'
                                  )
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            getXController.isPayPalDataValid();
                            if(!getXController.isPayPalDataInValid.value){
                              Get.back();
                            }

                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.black
                            ),
                            child: const Text(
                              'Save',
                              style: (
                                  TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: 'poppins_regular'
                                  )
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  )


                ],
              ),
            ),
          );
        })
    );
  }

  ///*
  ///
  ///
  bankNameField() {
    return
      TextFormField(
        onTap: () {
          getXController.setAllErrorToFalse();
        },
        controller: getXController.bankNameController,
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
            const EdgeInsets.symmetric(horizontal: 10),
            labelText: 'Bank Name',
            // hintText: 'Drug Name',
            hintStyle: const TextStyle(
                fontSize: 13.0,
                color: MyColor.hintColor,
                fontFamily: 'poppins_regular'
            ),
            errorText: getXController.isBankNameEmpty.value? "Please Enter Name Of Bank" : null
        ),
      );
  }

  ///*
  ///
  ///
  branchNameField() {
    return
      TextFormField(
        onTap: () {
          getXController.setAllErrorToFalse();
        },
        controller: getXController.branchNameController,
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
            const EdgeInsets.symmetric(horizontal: 10),
            labelText: 'Branch Name',
            // hintText: 'Drug Name',
            hintStyle: const TextStyle(
                fontSize: 13.0,
                color: MyColor.hintColor,
                fontFamily: 'poppins_regular'
            ),
            errorText: getXController.isBranchNameEmpty.value? "Please Enter Name Of Branch" : null
        ),
      );
  }

  ///*
  ///
  ///
  accountNameField() {
    return
      TextFormField(
        onTap: () {
          getXController.setAllErrorToFalse();
        },
        controller: getXController.accountNameController,
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
            const EdgeInsets.symmetric(horizontal: 10),
            labelText: 'Account Name',
            // hintText: 'Drug Name',
            hintStyle: const TextStyle(
                fontSize: 13.0,
                color: MyColor.hintColor,
                fontFamily: 'poppins_regular'
            ),
            errorText: getXController.isAccountNameEmpty.value? "Please Enter Name Of Account" : null
        ),
      );
  }

  ///*
  ///
  ///
  accountNumberField() {
    return
      TextFormField(
        onTap: () {
          getXController.setAllErrorToFalse();
        },
        controller: getXController.accountNumberController,
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
            const EdgeInsets.symmetric(horizontal: 10),
            labelText: 'Account Number',
            // hintText: 'Drug Name',
            hintStyle: const TextStyle(
                fontSize: 13.0,
                color: MyColor.hintColor,
                fontFamily: 'poppins_regular'
            ),
            errorText: getXController.isAccountNumberEmpty.value? "Please Enter Account Number" : null
        ),
      );
  }


  ///*
  ///
  ///
  gPayNumberField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.gPayMobileNoController,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      // maxLength: 10,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      onChanged: (data){
        if( data.isNotEmpty && data.length != 11){
          getXController.isGPayNoInValid.value = true;
        }else{
          getXController.setAllErrorToFalse();
        }
      },
      decoration:  InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Mobile Number',
          errorText: getXController.isGPayNoEmpty.value? "Please Enter Mobile Number" : getXController.isGPayNoInValid.value? 'Please Enter Valid Mobile Number' : null
        // getXController.isMobileNoValid.value ? "Please enter valid 10 digit mobile no.": null
      ),
    );

  }


  ///*
  ///
  ///
  emailField() {
    return
      TextFormField(
        onTap: () {
          getXController.setAllErrorToFalse();
        },
        controller: getXController.emailController,
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
            const EdgeInsets.symmetric(horizontal: 10),
            labelText: 'Email',
            // hintText: 'Drug Name',
            hintStyle: const TextStyle(
                fontSize: 13.0,
                color: MyColor.hintColor,
                fontFamily: 'poppins_regular'
            ),
            errorText: getXController.isEmailEmpty.value? "Please Enter Email" : null
        ),
      );
  }

  ///*
  ///
  ///
  payPalNumberField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.paypalMobileNoController,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      // maxLength: 10,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
      onChanged: (data){
        if( data.isNotEmpty && data.length != 11){
          getXController.isPayPalNoInValid.value = true;
        }else{
          getXController.setAllErrorToFalse();
        }
      },
      decoration:  InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 10),
          labelText: 'Mobile Number',
          errorText: getXController.isPaypalNoEmpty.value? "Please Enter Mobile Number" : getXController.isPayPalNoInValid.value? 'Please Enter Valid Mobile Number' : null
        // getXController.isMobileNoValid.value ? "Please enter valid 10 digit mobile no.": null
      ),
    );

  }

  ///*
  ///
  ///
  showBillingSetupInfo(){
    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getBillingSetupInfoRow('Account', getXController.selectedMethod.value),

            InkWell(
              onTap: (){
                getXController.deleteBillingSetup();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.redAccent,
                ),
                child: const Text(
                    'Delete',
                     style: TextStyle(
                       fontSize: 12,
                       fontFamily: 'poppins_medium',
                       color: Colors.white
                     ),
                ),),
            )
          ],
        ),
        const SizedBox(height: 5,),
        getXController.selectedMethod.value == 'Bank Account'?
        showBankAccountData()
        : getXController.selectedMethod.value == 'Google Pay'?
        showGooglePayData()
        :showPaypalData(),


        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 1,
          color: Colors.grey,
        )
      ],
    );
  }

  ///*
  ///
  ///
  getBillingSetupInfoRow(String label, String value) {
    return Row(

      children: [
        Text(
          '$label : ',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontFamily: 'poppins_medium'
          ),
        ),

        Text(
          value,
          style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'poppins_regular'
          ),
        )
      ],
    );
  }

  ///*
  ///
  ///
  showBankAccountData() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        getBillingSetupInfoRow('Bank Name', getXController.bankNameController.text),
        getBillingSetupInfoRow('Branch Name', getXController.branchNameController.text),
        getBillingSetupInfoRow('Account Name', getXController.accountNameController.text),
        getBillingSetupInfoRow('Account No', getXController.accountNumberController.text),

      ],
    );
  }

  ///*
  ///
  ///
  showGooglePayData() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        getBillingSetupInfoRow('Mobile No.', getXController.gPayMobileNoController.text),
      ],
    );
  }

  ///*
  ///
  ///
  showPaypalData() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        getBillingSetupInfoRow('Email', getXController.emailController.text),
        getBillingSetupInfoRow('Mobile No.', getXController.paypalMobileNoController.text),

      ],
    );
  }

  ///*
  ///
  ///
  showBillingHistory() {

    return ListView.builder(
       shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: getXController.billingHistoryList.length,
        itemBuilder: (context, index){
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getBillingHistoryRow('Patient Name', getXController.billingHistoryList[index].serviceReceiver!, ''),
                  getBillingHistoryRow('Email', getXController.billingHistoryList[index].receiverEmail!, ''),

                  getBillingHistoryRow('Phone No.', getXController.billingHistoryList[index].receiverPhone!, ''),
                  getBillingHistoryRow('Appointment Type', getXController.billingHistoryList[index].appointmentTypeName!, ''),

                  getBillingHistoryRow('Appointment Date.', getXController.billingHistoryList[index].scheduleAppointmentDate!, ''),
                  getBillingHistoryRow('Appointment Time', getXController.billingHistoryList[index].scheduleTime!, ''),

                  getBillingHistoryRow('Doctor Charges', getXController.billingHistoryList[index].paidAmount!.toString(), ''),
                  getBillingHistoryRow('Status', getXController.billingHistoryList[index].paybackstatus!, getXController.billingHistoryList[index].id!)
                ],
              ),
            ),
          );
        });
  }

  ///*
  ///
  ///
  getBillingHistoryRow(String label, String value, String bookingId) {
    return Row(

      children: [
        Text(
          '$label : ',
          style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'poppins_medium'
          ),
        ),

        label == 'Status' && value == ''?
        InkWell(
          onTap: (){
            getXController.requestForPayment(bookingId);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: MyColor.themeTealBlue
            ),
            child: Row(
              children: [
                Icon(Icons.add_circle_outline, color: Colors.white, size: 15,),
                Text(
                  ' Request',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'poppins_regular'
                  ),
                ),
              ],
            ),
          ),
        )
        : Expanded(
          child: Text(
            value,
            style: TextStyle(
                fontSize: 12,
                color: (label == 'Status' && value == 'Completed') ? Colors.green : (label == 'Status' && value == 'Requested') ? Colors.orange : Colors.black,
                fontFamily: 'poppins_regular'
            ),
          ),
        )


      ],
    );

  }


  ///*
  ///
  ///
  appointmentTypeDropdown() {
    return DropdownSearch<ProviderConsultancyTypeResponse?>(
      dropdownBuilder: _consultancyDropDownStyle,
      dropdownButtonProps:  const DropdownButtonProps(
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
          padding: EdgeInsets.zero
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ) ,
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
            ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ),
        ),
      ),
      items: getXController.appointmentTypeList,
      itemAsString: (ProviderConsultancyTypeResponse? u) => u!.consultancyAsString(),
      selectedItem: getXController.selectedAppointmentType.value,
      onChanged: (value) {
        getXController.selectedAppointmentType.value = value!;
        getXController.appointmentType.value = getXController.selectedAppointmentType.value.name!;
        getXController.getBillingHistoryResponse();
      },
    );

  }


  ///*
  ///
  ///
  paymentStatusDropdown() {
    return DropdownSearch<String?>(
      dropdownBuilder: _paymentStatusDropdownStyle,
      dropdownButtonProps:  const DropdownButtonProps(
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
          padding: EdgeInsets.zero
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ) ,
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ),
        ),
      ),
      items: getXController.paymentStatusList,
      // itemAsString: (ProviderConsultancyTypeResponse? u) => u!.consultancyAsString(),
      selectedItem: getXController.selectedPaymentStatus.value,
      onChanged: (value) {
        getXController.selectedPaymentStatus.value = value!;
        getXController.getBillingHistoryResponse();

      },
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
  Widget _paymentStatusDropdownStyle(BuildContext context, String? selectedStatus) {
    return Text(
      selectedStatus!,
      style: const TextStyle(
          fontSize: 14.0,
          color: MyColor.themeTealBlue,
          fontFamily: 'poppins_semibold'
      ),
    ); }

}
