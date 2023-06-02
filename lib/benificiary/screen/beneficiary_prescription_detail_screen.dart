
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/benificiary/controller/beneficiary_prescription_detail_controller.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';

class BeneficiaryPrescriptionDetailScreen extends StatefulWidget {

  String prescriptionId;
  String providerId;
  String prescriptionDate;
  String diagnosis;

  BeneficiaryPrescriptionDetailScreen({Key? key , required this.prescriptionId, required this.providerId, required this.prescriptionDate, required this.diagnosis}) : super(key: key);

  @override
  _BeneficiaryPrescriptionDetailScreenState createState() => _BeneficiaryPrescriptionDetailScreenState();
}

class _BeneficiaryPrescriptionDetailScreenState extends State<BeneficiaryPrescriptionDetailScreen> {

  BeneficiaryPrescriptionDetailController getXController = Get.put(BeneficiaryPrescriptionDetailController());

  @override
  void initState() {
    // TODO: implement initState

    getXController.providerId.value = widget.providerId;
    getXController.prescriptionId.value = widget.prescriptionId;
    getXController.date.value = widget.prescriptionDate;
    getXController.diagnosis.value = widget.diagnosis;


    Future.delayed(Duration(), (){
      getXController.getPrescriptionData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child: Obx((){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
              centerTitle: true,
              title: const Text('Prescription Detail'),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                getPatientDetail(),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  color:  Colors.grey,),

                getXController.drugList.isNotEmpty?
                Expanded(
                  child: ListView.builder(
                      itemCount: getXController.drugList.length,
                      itemBuilder: (context, index){
                        return drugDetailWidget(index);
                      }),
                ) :SizedBox(),

                getXController.medicalTestList.isNotEmpty?
                Expanded(
                  child: ListView.builder(
                      itemCount: getXController.medicalTestList.length,
                      itemBuilder: (context, index){
                        return medicalTestWidget(index);
                      }),
                ) :SizedBox(),

                getXController.adviceList.isNotEmpty?
                Expanded(
                  child: ListView.builder(
                      itemCount: getXController.adviceList.length,
                      itemBuilder: (context, index){
                        return adviceWidget(index);
                      }),
                ) :SizedBox(),


                // adviceWidget()

              ],
            ),

          );
        })
    );
  }

  ///*
  ///
  ///
  getPatientDetail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: getRowData('Name' , getXController.name.value),),
              Expanded(child: getRowData('Age' , getXController.age.value),)
            ],
          ),

          Row(
            children: [
              Expanded(
                flex: 2,
                child:
                getRowData('Gender' , getXController.gender.value),
              ),
              Expanded(child: getRowData('Date' , getXController.date.value),)

            ],
          ),

          Row(
            children: [
              Expanded(
                child:
                getRowData('Diagnosis' , getXController.diagnosis.value),
              )
            ],
          )
        ],
      ),
    );

  }

  ///*
  ///
  ///
  getRowData(String label, String value) {
    return Row(
      children: [
        Text(
          '$label :',
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
  medicalTestWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      child: Table(
        border: TableBorder.symmetric(
            inside: const BorderSide(width: 1, color: Colors.black)),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,

        columnWidths: const {
          0: FlexColumnWidth(0.5),
          1: FlexColumnWidth(2),
        },
        children: [
          index == 0 ?
          getMedicalTestTableTitleRow(): TableRow(children: [SizedBox(),SizedBox()]),
          getMedicalTestTableRow((index+1).toString(),getXController.medicalTestList[index].medicaltest!),

        ],
      ),

    );
  }

  ///*
  ///
  ///
  adviceWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      child: Table(
        border: TableBorder.symmetric(
            inside: const BorderSide(width: 1, color: Colors.black)),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,

        columnWidths: const {
          0: FlexColumnWidth(0.5),
          1: FlexColumnWidth(2),
        },
        children: [
          index == 0 ?
          getAdviceTableTitleRow():TableRow(children: [SizedBox(),SizedBox()]),
          getMedicalTestTableRow((index+1).toString(),getXController.adviceList[index].advice!),
        ],
      ),
    );
  }


  ///*
  ///
  ///
  getMedicalTestTableRow(String srNo,String testName){
    return TableRow(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 0.5,
          ),),
        children: [
          tableValueData(srNo),
          tableValueData(testName),
        ]

    );

  }


  ///*
  ///
  ///
  getMedicalTestTableTitleRow(){
    return TableRow(
        decoration: BoxDecoration(
          color: MyColor.lightGreenBlue,
          border: Border.all(
            width: 0.5,
          ),),
        children: [
          tableHeadingData('Sr.no'),
          tableHeadingData('Name of Medical Test'),
        ]

    );

  }

  ///*
  ///
  ///
  getAdviceTableTitleRow(){
    return TableRow(
        decoration: BoxDecoration(
          color: MyColor.lightGreenBlue,
          border: Border.all(
            width: 0.5,
          ),),
        children: [
          tableHeadingData('Sr.no'),
          tableHeadingData('Advice'),
        ]

    );

  }


  ///*
  ///
  ///
  drugDetailWidget(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text('RX',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'poppins_semibold'
          ),),

          const SizedBox(height: 10,),

          Table(
            border: TableBorder.symmetric(
                inside: const BorderSide(width: 1, color: Colors.black)),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,

            columnWidths: const {
              0: FlexColumnWidth(0.5),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.5),
              4: FlexColumnWidth(1),
            },
            children: [
              index == 0?
              getDrugTableTitleRow(): TableRow(children: [SizedBox(),SizedBox()]),
              getDrugTableRow((index+1).toString(), getXController.drugList[index].durgname!, getXController.drugList[index].weeklyschedule!, getXController.drugList[index].timing!, getXController.drugList[index].dose!),

            ],
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getDrugTableRow(String srNo,String drugName, String schedule, String timing, String dose){
   return TableRow(
       decoration: BoxDecoration(
         color: Colors.white,
         border: Border.all(
           width: 0.5,
         ),),
       children: [
         tableValueData(srNo),
         tableValueData(drugName),
         tableValueData(schedule),
         tableValueData(timing),
         tableValueData(dose),

       ]

   );

  }


  ///*
  ///
  ///
  getDrugTableTitleRow(){
    return TableRow(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          border: Border.all(
            width: 0.5,
          ),),
        children: [
          tableHeadingData('Sr.no'),
          tableHeadingData('Drug Name'),
          tableHeadingData('Weekly Schedule'),
          tableHeadingData('Timing'),
          tableHeadingData('Dose'),
        ]

    );

  }

  ///*
  ///
  ///
  tableValueData(String data){
    return
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'poppins_regular'
          ),),
      );
  }

  ///*
  ///
  ///
  tableHeadingData(String data){
    return
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontFamily: 'poppins_semibold'
          ),),
      );
  }
}
