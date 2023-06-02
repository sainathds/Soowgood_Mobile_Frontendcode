import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_doctor_visit_controller.dart';
import 'package:soowgood/provider/screen/provider_add_edit_prescription_screen.dart';
import 'package:soowgood/provider/screen/provider_medical_document_dialog.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderDoctorVisitTab extends StatefulWidget {

  String serviceReceiverId;

  ProviderDoctorVisitTab({Key? key, required this.serviceReceiverId}) : super(key: key);

  @override
  _ProviderDoctorVisitTabState createState() => _ProviderDoctorVisitTabState();
}

class _ProviderDoctorVisitTabState extends State<ProviderDoctorVisitTab> {
  ProviderDoctorVisitController getXController = Get.put(ProviderDoctorVisitController());

  @override
  void initState() {
    // TODO: implement initState

    getXController.doctorVisitList.clear();
    Future.delayed(Duration(), (){
      getXController.getDoctorVisitResponse(widget.serviceReceiverId);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Obx((){
       return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            itemCount: getXController.doctorVisitList.length,
            itemBuilder: (context, index){
              return getVisitedHistory(index);
            }),
      );
    });
  }

  ///*
  ///
  ///
  Widget getVisitedHistory(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getRowData('Appointment Id', getData(getXController.doctorVisitList[index].appointmentNo)),
            getRowData('Appointment Type', getData(getXController.doctorVisitList[index].appointmentType)),
            getRowData('Payment Status', getData(getXController.doctorVisitList[index].userPaymentStatus)),
            getRowData('Amount', getData(getXController.doctorVisitList[index].paidAmount.toString())),
            getRowData('Date', getData(getXController.doctorVisitList[index].scheduleAppointmentDate)),
            getRowData('Time', getData(getXController.doctorVisitList[index].scheduleTime)),
            getRowData('Status', getData(getXController.doctorVisitList[index].appointmentStatus)), //Confirmed
            getRowData('Place', getData(getXController.doctorVisitList[index].clinicAddress)),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                InkWell(
                  onTap: (){
                    showDialog(
                       barrierDismissible: true,
                        context: context,
                        builder: (context){
                          return ProviderMedicalDocumentDialog(serviceReceiverId: widget.serviceReceiverId, bookingId: getXController.doctorVisitList[index].bookingId!,);
                        });
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5, top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        color: MyColor.lightGreenBlue,
                        borderRadius: BorderRadius.circular(50)
                    ),

                    child: const Text('View Document', style: TextStyle(color: Colors.black, fontSize: 10, fontFamily: 'poppins_semibold'),),
                  ),
                ),

                InkWell(
                  onTap: (){
                    Get.to(() => ProviderAddEditPrescriptionScreen(
                      callFrom: 'Add',
                      receiverId: widget.serviceReceiverId,
                      bookingId: getXController.doctorVisitList[index].bookingId!,
                      prescriptionId: '',
                      diagnosis: '',));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5, top: 5, left: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                      color: MyColor.themeSkyBlue,
                      borderRadius: BorderRadius.circular(50)
                    ),

                    child: const Text('Add Prescription', style: TextStyle(color: Colors.white, fontSize: 10 , fontFamily: 'poppins_semibold'),),
                  ),
                ),


              ],
            )
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  getRowData(String label, String value) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label : ',
          style: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'poppins_regular'
          ),
        ),

        Expanded(
          child: Text(
            ' $value',
            // maxLines: 1,
            style: TextStyle(
                fontSize: 12,
                color: label == 'Status' && value == 'Confirmed'? Colors.deepOrangeAccent :
                       label == 'Status' && value == 'Completed'? Colors.green :
                           Colors.black,
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
  String getData(String? data) {
    if(data != null){
      return data;
    }else{
      return '';
    }
  }



}
