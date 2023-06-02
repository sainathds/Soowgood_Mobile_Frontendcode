
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_patients_controller.dart';
import 'package:soowgood/provider/model/response/provider_patient_list_response.dart';
import 'package:soowgood/provider/screen/provider_view_medical_history_screen.dart';

class ProviderPatientsScreen extends StatefulWidget {
  const ProviderPatientsScreen({Key? key}) : super(key: key);

  @override
  _ProviderPatientsScreenState createState() => _ProviderPatientsScreenState();
}

class _ProviderPatientsScreenState extends State<ProviderPatientsScreen> {

  ProviderPatientsController getXController = Get.put(ProviderPatientsController());

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(),(){
      getXController.getPatientListResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(100.0), // here the desired height
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [

                      Text('Patients',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: MyColor.themeTealBlue,
                            fontFamily: 'poppins_Semibold'
                        ),),

                      // SizedBox(width: 20,)
                    ],
                  ),

                  const SizedBox(height: 10.0,),
                  getSearchWidget()
                ],
              ),
            ),
            body: SingleChildScrollView(
                child: Column(
                    children: [
                      const SizedBox(height: 5.0,),
                      getXController.patientList.isNotEmpty?
                      getPatientWidget()
                      : const Center(
                    child: Text("No Data Found"),)
                    ] )),
          ));

    });



  }

  ///*
  ///
  ///
  getPatientWidget(){
    return ListView.builder(
       shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: getXController.patientList.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              Card(
                elevation: 4,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  // width: 180,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          getPatientImgPath(getXController.patientList[index].receiverImage) != ''?
                          Image.network(getPatientImgPath(getXController.patientList[index].receiverImage),
                              width: 60.0, height: 60.0, fit: BoxFit.fill,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Image(
                                    image: noProfileImage, width: 60, height: 60, fit: BoxFit.fill);})
                              : Image(image: noProfileImage, width: 60, height: 60, fit: BoxFit.fill),

                          SizedBox(width: 20,),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(getData(getXController.patientList[index].serviceReceiver),
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: MyColor.tealBlueDark,
                                  fontFamily: 'poppins_semibold'
                              ),),

                            // const SizedBox(height: 5,),
                            Text(getData(getXController.patientList[index].receiverPhone),
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: MyColor.tealBlueDark,
                                  fontFamily: 'poppins_medium'
                              ),),
                          ],)
                        ],
                      ),

                      SizedBox(height: 5,),
                      getRowData('Location', getData(getXController.patientList[index].patientAddress)),

                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Expanded(
                          child: getRowData('Blood Group', getData(getXController.patientList[index].bloodGroup)),
                        ),
                        Expanded(child: getRowData('Gender', getData(getXController.patientList[index].gender)),),
                        Expanded(child: getRowData('Age', getData(getXController.patientList[index].age.toString())),)
                        ],),

                      SizedBox(height: 10,),
                      viewMedicalHistoryBtn(index)
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  ///*
  ///
  ///
/*
  getPatientWidget() {
    return SingleChildScrollView(
      child: LayoutGrid(
        columnSizes: [1.fr, 1.fr],
        rowSizes: List<IntrinsicContentTrackSize>.generate(
            (getXController.patientList.length / 2).round(),
                (int index) => auto),
        rowGap: 15,
        children: [
          for (var index = 0;
          index < getXController.patientList.length;
          index++)

            Center(
              child: Column(
                children: [
                  Card(
                    elevation: 4,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: 180,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getPatientImgPath(getXController.patientList[index].receiverImage) != ''?
                          Image.network(getPatientImgPath(getXController.patientList[index].receiverImage),
                              width: 110.0, height: 110.0, fit: BoxFit.fill,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Image(
                                    image: noProfileImage, width: 110, height: 110, fit: BoxFit.fill);})
                              : Image(image: noProfileImage, width: 110, height: 110, fit: BoxFit.fill),

                          Text(getData(getXController.patientList[index].serviceReceiver),
                            style: const TextStyle(
                                fontSize: 13,
                                color: MyColor.tealBlueDark,
                                fontFamily: 'poppins_semibold'
                            ),),

                          // const SizedBox(height: 5,),
                          Text(getData(getXController.patientList[index].receiverPhone),
                            style: const TextStyle(
                                fontSize: 10,
                                color: MyColor.tealBlueDark,
                                fontFamily: 'poppins_medium'
                            ),),

                          getRowData('Location', getData(getXController.patientList[index].patientAddress)),
                          getRowData('Blood Group', getData(getXController.patientList[index].bloodGroup)),
                          getRowData('Gender', getData(getXController.patientList[index].gender)),
                          getRowData('Age', getData(getXController.patientList[index].age.toString())),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
*/

  ///*
  ///
  ///
  getSearchWidget() {
    return Row(
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
                  getFilerList();
                }
              },
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide:  BorderSide(color: MyColor.searchBgColor),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:  BorderSide(color: MyColor.searchBgColor),
                  ),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: MyColor.searchBgColor,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 15.0),
                  hintText: 'Search by Patient',
                  hintStyle: const TextStyle(
                      fontSize: 13.0,
                      color: MyColor.searchColor,
                      fontFamily: 'poppins_medium'),
                  suffixIcon: getXController.isShow.value ? InkWell(
                    onTap: (){
                      getXController.isShow.value = false;
                      getXController.searchController.clear();

                      if(getXController.newPatientList.isNotEmpty){
                        getXController.patientList.clear();
                        getXController.patientList.addAll(getXController.newPatientList);
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
                  if(getXController.newPatientList.isNotEmpty){
                    getXController.patientList.clear();
                    getXController.patientList.addAll(getXController.newPatientList);
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
            getFilerList();
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
    );
  }

  ///*
  ///
  ///
  String getPatientImgPath(image) {
    if(image != null && image != ''){
      return ApiConstant.fileBaseUrl + ApiConstant.profilePicFolder + image;

    }else{
      return '';
    }
  }

  ///*
  ///
  ///
  String getData(String? data) {
    if(data != null && data.isNotEmpty){
      return "$data";
    }else{
      return '';
    }
  }

  ///*
  ///
  ///
  getRowData(String label, String value) {
    return Row(
      children: [
        Text(
          '$label :',
          style: TextStyle(
            fontSize: 11,
            color: Colors.black,
            fontFamily: 'poppins_medium'
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: TextStyle(
                fontSize: 11,
                color: Colors.black,
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
  viewMedicalHistoryBtn(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      // width: MediaQuery.of(context).size.width,
      height: 30,
      child: ElevatedButton(
          onPressed: (){
            // redirect on screen to show medical history
            Get.to(() => ProviderViewMedicalHistoryScreen(serviceReceiverId: getXController.patientList[index].serviceReceiverId!,));

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColor.themeTealBlue,
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),),
          child: const Text(
            'View Medical Details',
            style: TextStyle(
                color: MyColor.offWhite,
                fontSize: 13.0,
                fontFamily: 'poppins_semibold'
            ),
          )),
    );

  }

  ///*
  ///
  ///
  getFilerList(){
    getXController.newPatientList.clear();
    getXController.newPatientList.addAll(getXController.patientList);
    getXController.patientList.clear();
    for (ProviderPatientListResponse patientData in getXController.newPatientList) {
      if (patientData.serviceReceiver!.toLowerCase().contains(getXController.searchController.text.trim().toLowerCase())) {
        getXController.patientList.add(patientData);
      }
    }
  }


}
