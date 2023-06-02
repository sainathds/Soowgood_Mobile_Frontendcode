import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_clinic_appointement_controller.dart';
import 'package:soowgood/provider/model/response/provider_appointment_list_response.dart';
import 'package:soowgood/provider/model/response/provider_clinic_list_response.dart';
import 'package:soowgood/provider/screen/provider_view_medical_history_screen.dart';

class ProviderClinicAppointmentTab extends StatefulWidget {

  String appointmentTypeId;

  ProviderClinicAppointmentTab({Key? key, required this.appointmentTypeId }) : super(key: key);

  @override
  _ProviderClinicAppointmentTabState createState() => _ProviderClinicAppointmentTabState();
}

class _ProviderClinicAppointmentTabState extends State<ProviderClinicAppointmentTab> {

 ProviderClinicAppointmentController getXController = Get.put(ProviderClinicAppointmentController());
 DateTime dateTime = DateTime.now();

 @override
 void initState() {
   // TODO: implement initState

   getXController.clinicAppointmentList.clear();
   getXController.dateController.text = "${dateTime.month.toString().padLeft(2, "0")}/${dateTime.day.toString().padLeft(2, "0")}/${dateTime.year}";

   getXController.appointmentTypeId.value = widget.appointmentTypeId;

   Future.delayed(const Duration(), (){
     getXController.getClinicListResponse(widget.appointmentTypeId);
   });

   super.initState();
 }

 @override
  Widget build(BuildContext context) {
   return Container(
       padding: const EdgeInsets.only(left: 10, right: 10),
       height: MediaQuery.of(context).size.height,
       child: Column(
         children: [
           getSearchDateWidget(),
           getXController.clinicAppointmentList.isNotEmpty?
           Expanded(
             child: ListView.builder(
                 itemCount: getXController.clinicAppointmentList.length,
                 itemBuilder: (context, index){
                   return getOnlineAppointments(index);
                 }),
           )
               : const Expanded(child: Center(child: Text('No Data Found', style:  TextStyle(fontSize: 16, color: MyColor.searchColor, fontFamily: 'poppins_medium'),),)),            ],
       )
   );

 }

 ///*
 ///
 ///
 getSearchDateWidget() {
   return Column(
     children: [
       Row(
         children: [
           Expanded(
             flex: 2,
             child: Container(
               margin: const EdgeInsets.only(top: 5, left: 10),
               height: 40,
               child: TextFormField(
                 controller: getXController.searchController,
                 keyboardType: TextInputType.text,
                 textInputAction: TextInputAction.search,
                 onFieldSubmitted: (query) async{
                   if(getXController.searchController.text.trim().isNotEmpty){
                     getPatientFilterList();
                   }
                 },
                 decoration: InputDecoration(
                     enabledBorder:  const OutlineInputBorder(
                       borderSide:  BorderSide(color: MyColor.searchBgColor),
                     ),
                     focusedBorder:  const OutlineInputBorder(
                       borderSide:  BorderSide(color: MyColor.searchBgColor),
                     ),
                     border: const OutlineInputBorder(),
                     filled: true,
                     fillColor: MyColor.searchBgColor,
                     contentPadding: const EdgeInsets.symmetric(
                         vertical: 5.0, horizontal: 15.0),
                     hintText: 'Search by Doctors',
                     hintStyle: const TextStyle(
                         fontSize: 13.0,
                         color: MyColor.searchColor,
                         fontFamily: 'poppins_medium'),
                     suffixIcon: getXController.isShow.value ? InkWell(
                       onTap: (){
                         getXController.isShow.value = false;
                         getXController.searchController.clear();

                         if(getXController.newClinicAppointmentList.isNotEmpty){
                           getXController.clinicAppointmentList.clear();
                           getXController.clinicAppointmentList.addAll(getXController.newClinicAppointmentList);
                         }
                       },
                       child: const Icon(
                         Icons.clear,
                         size: 30,
                         color: Colors.grey,
                       ),
                     ): const SizedBox()),

                 onChanged: (value){
                   if(value.isEmpty){
                     if(getXController.newClinicAppointmentList.isNotEmpty){
                       getXController.clinicAppointmentList.clear();
                       getXController.clinicAppointmentList.addAll(getXController.newClinicAppointmentList);
                     }
                     getXController.isShow.value = false;
                   }else{
                     getXController.isShow.value = true;
                   }
                 },
               ),
             ),
           ),

           InkWell(
             onTap: (){
               getPatientFilterList();
             },
             child: Container(
               height: 40,
               width: 45,
               margin: const EdgeInsets.only(top: 5, right: 10),
               decoration: const BoxDecoration(
                   color: MyColor.themeSkyBlue,
                   borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))
               ),
               child: const Icon(Icons.person_search_outlined, color: Colors.white,),
             ),
           )
         ],
       ),
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
         child: Row(
           children: [
             getXController.clinicList.isNotEmpty?
             Expanded(
                 flex: 2,
                 child: clinicDropdown()
             ):const SizedBox(),

             Expanded(
                 flex: 1,
                 child: dateField())
           ],
         ),
       ),
     ],
   );
 }


 ///*
 ///
 ///
 dateField() {
   return Container(
     margin: const EdgeInsets.only(top: 5),
     height: 40,
     child: TextFormField(
       readOnly: true,
       onTap: () {
         setState(() {
           // getXController.setAllErrorToFalse();
           selectDate();
         });
       },
       controller: getXController.dateController,
       keyboardType: TextInputType.text,
       textInputAction: TextInputAction.next,
       style:  const TextStyle(
           fontSize: 12.0,
           color: MyColor.themeTealBlue,
           fontFamily: 'poppins_semibold'
       ),
       decoration: const InputDecoration(
         hintText: 'Select Date',
         hintStyle: TextStyle(
             fontSize: 12,
             fontFamily: 'poppins_medium',
             color: Colors.black26
         ),
         prefixIcon: Icon(Icons.date_range_outlined, color: Colors.black26, size: 20,),
         prefixIconConstraints: BoxConstraints(
             minWidth: 25,
             minHeight: 25,
             maxHeight: 25,
             maxWidth: 25
         ),
         border: OutlineInputBorder(),
         disabledBorder: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.blueGrey),
         ),
         focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.grey),
         ),

         contentPadding:
         EdgeInsets.zero
       ),

     ),
   );

 }

 ///*
 ///
 ///
 void selectDate() async {

   DateTime selectedDate = DateTime.now();

   DateTime nowDate = DateTime.now();

   final DateTime? selected = await showDatePicker(
     context: context,
     initialDate: selectedDate,
     firstDate: DateTime(1901),
     lastDate: DateTime(2199),
   );
   if (selected != null) {
     setState(() {
       selectedDate = selected;
       getXController.dateController.text =
       "${selectedDate.month.toString().padLeft(2, "0")}/${selectedDate.day.toString().padLeft(2, "0")}/${selectedDate.year}";
       getXController.getAppointmentListResponse();
     });
   }
 }


 ///*
 ///
 ///
 getOnlineAppointments(int index) {
   return Card(
     margin: const EdgeInsets.only(top: 5, bottom: 5),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(10.0),
       // side:  BorderSide(color: MyColor.tealBlueDark, width: 2.0),
     ),
     child: Padding(
       padding: const EdgeInsets.only(top: 5.0, bottom: 5),
       child: Column(
         children: [
           getPatientData(index),

           getAppointmentDetails(index)

         ],
       ),
     ),
   );
 }


 ///*
 ///
 ///
 getPatientData(int index) {
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
     child: Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(
               height: 60,
               width: 60,
               child: ClipRRect(
                 borderRadius: const BorderRadius.all(Radius.circular(10)),
                 child: getXController.clinicAppointmentList[index].receiverImage == null || getXController.clinicAppointmentList[index].receiverImage!.isEmpty?
                 Image(
                   image: noProfileImage,
                 )
                     : Image.network('${ApiConstant.fileBaseUrl}${ApiConstant.profilePicFolder}${getXController.clinicAppointmentList[index].receiverImage}',
                     width: 80.0,
                     height: 80.0,
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
                     getData(getXController.clinicAppointmentList[index].serviceReceiver!),
                     maxLines: 1,
                     style: const TextStyle(
                         color: MyColor.themeTealBlue,
                         fontSize: 13.0,
                         fontFamily: 'poppins_semibold'),
                   ),

                   getData(getXController.clinicAppointmentList[index].age.toString()) != ''?
                   Text(
                     'Age ${getData(getXController.clinicAppointmentList[index].age.toString())} years',
                     maxLines: 1,
                     style: const TextStyle(
                         color: MyColor.themeTealBlue,
                         fontSize: 10.0,
                         fontFamily: 'poppins_medium'),
                   ):const SizedBox(),

                   Row(
                     children: [
                       Container(
                           alignment: Alignment.center,
                           padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                           margin: const EdgeInsets.only(top: 5, ),
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(6),
                               color: Colors.orange
                           ),
                           child:  Text(
                             getData(getXController.clinicAppointmentList[index].appointmentNo),
                             style: const TextStyle(
                                 fontSize: 10,
                                 fontFamily: 'poppins_medium',
                                 color: Colors.white
                             ),
                           )
                       ),

                       Container(
                         padding: const EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
                         margin: const EdgeInsets.only(top: 5, left: 5),
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(6),
                             color: Colors.green
                         ),
                         child:  Text(
                           getData(getXController.clinicAppointmentList[index].appointmentTypeName),
                           style: const TextStyle(
                               color: Colors.white,
                               fontFamily: 'poppins_semibold',
                               fontSize: 10.0
                           ),
                         ),
                       ),

                     ],
                   ),




                 ],
               ),
             ),

             // getXController.appointmentList[index].appointmentStatus != 'Cancelled'?
             Row(
               children: [

                 Container(
                     height: 30,
                     width: 30,
                     padding: const EdgeInsets.all(5),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(50),
                         border: Border.all(color: Colors.black,)
                     ),
                     child: const Icon(Icons.call, size: 20,)),

                 PopupMenuButton(
                     padding: EdgeInsets.zero,
                     icon: const Icon(Icons.more_vert, color: Colors.black,),
                     // add this line
                     itemBuilder: (_) => <PopupMenuItem<String>>[
                       getXController.clinicAppointmentList[index].appointmentStatus != 'Cancelled'? const PopupMenuItem<String>(
                           padding: EdgeInsets.only(left: 10),
                           value: 'Cancel',
                           child: Text(
                             "Cancel",
                             style: TextStyle(
                               color: Colors.red,
                               fontFamily: 'popins_regular',
                             ),
                           ))
                       :const PopupMenuItem(child: SizedBox()),

                       const PopupMenuItem<String>(
                           padding: EdgeInsets.only(left: 10),
                           value: 'View Medical History',
                           child: Text(
                             "View Medical History",
                             style: TextStyle(
                               color: Colors.red,
                               fontFamily: 'popins_regular',
                             ),
                           ))

                     ],
                     onSelected: (value) {
                       switch (value) {
                         case 'Cancel':
                         getXController.getCheckCancelAppointmentResponse(index);
                           break;
                         case 'View Medical History':
                           Get.to(() => ProviderViewMedicalHistoryScreen(serviceReceiverId: getXController.clinicAppointmentList[index].serviceReceiverId!,));
                           break;
                       }
                     }),
               ],
             )/*: SizedBox()*/
           ],
         ),

/*
          Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.orangeAccent
                  ),
                  child:  Text(
                    getData(getXController.onlineAppointmentList[index].appointmentNo),
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'poppins_medium'
                    ),
                  )
              ),
            ],
          )
*/
       ],
     ),
   );
 }

 ///*
 ///
 ///
 getAppointmentDetails(int index) {
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 10.0),
     child: Column(
       children: [
         getRowData('Clinic Name', getData(getXController.clinicAppointmentList[index].clinicName)),
         getRowData('Appointment Date', getData(getXController.clinicAppointmentList[index].scheduleAppointmentDate)),
         getRowData('Appointment Time', getData(getXController.clinicAppointmentList[index].scheduleStartTime)),
         getRowData('Paid Amount', getData(getXController.clinicAppointmentList[index].appointmentFees.toString())),
         getRowData('Payment Status', getData(getXController.clinicAppointmentList[index].userPaymentStatus)),
         getRowData('Status', getData(getXController.clinicAppointmentList[index].appointmentStatus)),
         getRowData('Last Visit', getData(getXController.clinicAppointmentList[index].lastApointmentDate)),


       ],
     ),
   );
 }


 ///*
 ///
 ///
 getRowData(String label, String value) {
   return Padding(
     padding: const EdgeInsets.symmetric(vertical: 2.0),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text(
           label,
           style: const TextStyle(
               fontSize: 12,
               color: Colors.black,
               fontFamily: 'poppins_regular'
           ),
         ),

         Text(
           value,
           style: TextStyle(
               fontSize: 12,
               color: label == 'Status' ? Colors.deepOrangeAccent : Colors.black,
               fontFamily: label == 'Status' ? 'poppins_semibold' : 'poppins_regular'
           ),
         )

       ],
     ),
   );
 }

 ///*
 ///
 ///
 String getData(String? data) {
   if(data != null && data != ''){
     return data;
   }else{
     return '';
   }
 }

 ///*
 ///
 ///
 Widget clinicDropdown() {
   return Container(
     margin: const EdgeInsets.only(top: 5, right: 10),
     height: 40,
     child: DropdownSearch<ProviderClinicListResponse?>(
       dropdownBuilder: _clinicDropDownStyle,
       dropdownButtonProps:  const DropdownButtonProps(
           icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
           padding: EdgeInsets.zero
       ),
       dropdownDecoratorProps: const DropDownDecoratorProps(
         dropdownSearchDecoration: InputDecoration(
           contentPadding: EdgeInsets.symmetric(horizontal: 10),
           border: OutlineInputBorder(),
           disabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.blueGrey),
           ),
           focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.grey),
           ),
         ),
       ),
       items: getXController.clinicList,
       itemAsString: (ProviderClinicListResponse? u) => u!.clinicAsString(),
       selectedItem: getXController.selectedClinic.value,
       onChanged: (value) {
         getXController.selectedClinic.value = value!;
         getXController.getAppointmentListResponse();
       },
     ),
   );
 }


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
 /// filter Appointment List data to get search data by patient name
 getPatientFilterList(){
   getXController.newClinicAppointmentList.clear();
   getXController.newClinicAppointmentList.addAll(getXController.clinicAppointmentList);
   getXController.clinicAppointmentList.clear();
   for (ProviderAppointmentListResponse appointment in getXController.newClinicAppointmentList) {
     if (appointment.serviceReceiver!.toLowerCase().contains(getXController.searchController.text.trim().toLowerCase())) {
       getXController.clinicAppointmentList.add(appointment);
     }
   }
 }



}
