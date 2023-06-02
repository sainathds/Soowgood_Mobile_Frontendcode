import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_clinic_schedule_controller.dart';
import 'package:soowgood/provider/screen/provider_add_edit_schedule_screen.dart';

class ProviderClinicScheduleTab extends StatefulWidget {
  const ProviderClinicScheduleTab({Key? key}) : super(key: key);

  @override
  _ProviderClinicScheduleTabState createState() => _ProviderClinicScheduleTabState();
}

class _ProviderClinicScheduleTabState extends State<ProviderClinicScheduleTab> {

  ProviderClinicScheduleController getXController = Get.put(ProviderClinicScheduleController());

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 100), (){
      getXController.clearAll();
      getXController.getClinicScheduleListResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Column(
        children: [
          getXController.clinicScheduleList.isNotEmpty?
          Expanded(child: getClinicScheduleWidget())
              : const SizedBox( height: 100, child: Center(child: Text('Clinic Schedule details are not available')),),

        ],
      );
    });
  }


  ///
  ///
  ///
  getClinicScheduleWidget() {
    return  ListView.builder(
        itemCount: getXController.clinicScheduleList.length,
        itemBuilder: (context , index){
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            elevation: 0.5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      /*ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child : getXController.clinicList[index].imageUrl != null ?  Image.network(getImageUrl(getXController.clinicList[index].imageUrl!),
                          width: 60.0, height: 60.0, fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Image(
                                image: noImage, width: 60, height: 60, fit: BoxFit.fill);
                          },
                        )
                            : Image(image:  noImage,
                          width: 60.0, height: 60.0, fit: BoxFit.fill,),
                      ),*/
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getData(getXController.clinicScheduleList[index].clinicname!),
                                        // 'Evercare Hospital Dhaka',
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: MyColor.themeTealBlue,
                                            fontSize: 13.0,
                                            fontFamily: 'poppins_medium'
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 30.0),
                                        child: Text(
                                          getData(getXController.clinicScheduleList[index].cliniccurrentaddress!),
                                          // 'plot 81, Dhaka 1229 Bangladesh',
                                          maxLines: 1,
                                          style: const TextStyle(
                                              color: MyColor.hintColor,
                                              fontSize: 11.0,
                                              fontFamily: 'poppins_semibold'
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(right: 30.0),
                                        child: Text(
                                          getData(getXController.clinicScheduleList[index].appointmentDayOfWeek!),
                                          // 'Mon, Tue, Wed, Fri, Sat',
                                          style: const TextStyle(
                                              color: Colors.orange,
                                              fontSize: 13.0,
                                              fontFamily: 'poppins_medium'
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                PopupMenuButton(
                                    padding: EdgeInsets.zero,
                                    icon: Icon(Icons.more_vert, color: Colors.black,),
                                    // add this line
                                    itemBuilder: (_) => <PopupMenuItem<String>>[
                                      const PopupMenuItem<String>(
                                          padding: EdgeInsets.only(left: 10),
                                          value: 'Edit',
                                          child: Text(
                                            "Edit",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'popins_regular',
                                            ),
                                          )),
                                      const PopupMenuItem<String>(
                                          padding: EdgeInsets.only(left: 10),
                                          value: 'Delete',
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'popins_regular',
                                            ),
                                          )),
                                    ],
                                    onSelected: (value) async{
                                      switch (value) {
                                        case 'Edit':
                                          var result = await Get.to(() =>  ProviderAddEditScheduleScreen(
                                            callFrom: 'Edit',
                                            scheduleId: getXController.clinicScheduleList[index].appointmentSettingId!,
                                          ));

                                          // if(result){
                                            getXController.getClinicScheduleListResponse();
                                          // }
                                          break;
                                        case 'Delete':
                                          getXController.getDeleteScheduleResponse(getXController.clinicScheduleList[index].appointmentSettingId.toString());
                                          break;
                                      }
                                    })

                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left:10.0, right: 10.0, top: 5),
                    child: Row(
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Schedule Type',
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyColor.hintColor,
                                  fontSize: 11.0,
                                  fontFamily: 'poppins_semibold'
                              ),
                            ),
                            Text(
                              getData(getXController.clinicScheduleList[index].scheduleType!),
                              maxLines: 1,
                              style: const TextStyle(
                                  color: MyColor.themeTealBlue,
                                  fontSize: 11.0,
                                  fontFamily: 'poppins_semibold'
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 20,),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Appointment Fee',
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyColor.hintColor,
                                  fontSize: 11.0,
                                  fontFamily: 'poppins_semibold'
                              ),
                            ),
                            Text(
                              getData(getXController.clinicScheduleList[index].appointmentFees!.toString()),
                              maxLines: 1,
                              style: const TextStyle(
                                  color: MyColor.themeTealBlue,
                                  fontSize: 11.0,
                                  fontFamily: 'poppins_semibold'
                              ),
                            ),
                          ],
                        )


                      ],
                    ),
                  ),


                  Container(
                    height: 1,
                    color: Colors.black12,
                    margin: EdgeInsets.only(top: 10),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left:10.0, right: 10.0, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Admin Charges',
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyColor.hintColor,
                                  fontSize: 11.0,
                                  fontFamily: 'poppins_semibold'
                              ),
                            ),
                            Text(
                              getData(getXController.clinicScheduleList[index].adminComission.toString()),
                              maxLines: 1,
                              style: const TextStyle(
                                  color: MyColor.themeTealBlue,
                                  fontSize: 11.0,
                                  fontFamily: 'poppins_semibold'
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: 1,
                          height: 35,
                          color: Colors.black12,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            const Text(
                              'Patient Charges',
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyColor.hintColor,
                                  fontSize: 11.0,
                                  fontFamily: 'poppins_semibold'
                              ),
                            ),
                            Text(
                              getData(getXController.clinicScheduleList[index].patientCharges.toString()),
                              maxLines: 1,
                              style: const TextStyle(
                                  color: MyColor.themeTealBlue,
                                  fontSize: 11.0,
                                  fontFamily: 'poppins_semibold'
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: 1,
                          height: 35,
                          color: Colors.black12,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  const [
                            Text(
                              'Status',
                              maxLines: 1,
                              style: TextStyle(
                                  color: MyColor.hintColor,
                                  fontSize: 11.0,
                                  fontFamily: 'poppins_semibold'
                              ),
                            ),
                            Text(
                              // getData(getXController.onlineScheduleList[index].),
                              'Active',
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 11.0,
                                  fontFamily: 'poppins_semibold'
                              ),
                            ),
                          ],
                        )



                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        });

  }

  ///*
  ///
  ///
  String getData(String data) {
    if(data.isNotEmpty){
      return data;
    }else{
      return '';
    }
  }

}
