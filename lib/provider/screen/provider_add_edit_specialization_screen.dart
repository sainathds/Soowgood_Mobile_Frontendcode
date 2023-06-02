import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_add_edit_specialization_controller.dart';
import 'package:soowgood/provider/model/response/provider_category_type_response.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderAddEditSpecializationScreen extends StatefulWidget {

  String callFrom;
  String specializationId;
  String categoryId;
  String categoryName;
  String services;
  String specializations;

  ProviderAddEditSpecializationScreen({
    Key? key,
    required this.callFrom,
    required this.specializationId,
    required this.categoryId,
    required this.categoryName,
    required this.services,
    required this.specializations}) : super(key: key);

  @override
  _ProviderAddEditSpecializationScreenState createState() => _ProviderAddEditSpecializationScreenState();
}

class _ProviderAddEditSpecializationScreenState extends State<ProviderAddEditSpecializationScreen> {

  ProviderAddEditSpecializationController getXController = Get.put(ProviderAddEditSpecializationController());

  @override
  void initState() {
    // TODO: implement initState
    getXController.clearAll();
    ProviderGlobal.isSkillBack = false;
    setData();
    getXController.refreshPage = refreshPage;
    getXController.callFrom = widget.callFrom;
    Future.delayed(const Duration(), (){
      getXController.getCategoryListResponse();
    });
    Future.delayed(const Duration(), (){
      getXController.getServiceListResponse();
    });
    Future.delayed(const Duration(), (){
      getXController.getSpecializationListResponse();
    });

    super.initState();
  }

  ///*
  ///
  ///
  refreshPage(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,

            leading: InkWell(
                onTap: (){
                  Get.back(result: ProviderGlobal.isSkillBack);
                },
                child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
            title: Text('${widget.callFrom} Specialization'),
            actions: const [
              Icon(Icons.notifications_none_rounded),
              SizedBox(width: 20,)
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  getStarLabel('Category Type'),
                  const SizedBox(height: 5.0,),
                  categoryDropdown(),


                  const SizedBox(height: 20.0,),
                  getStarLabel('Service'),
                  const SizedBox(height: 5.0,),
                  serviceDropdown(),


                  const SizedBox(height: 20.0,),
                  getStarLabel('Specialization'),
                  const SizedBox(height: 5.0,),
                  specializationDropdown(),

                  const SizedBox(height: 30.0,),
                  buttonWidget()

                ],
              ),
            ),
          ),
        ),
      )
    );
  }


  ///*
  ///
  ///
  Widget categoryDropdown() {
    return DropdownSearch<ProviderCategoryTypeResponse?>(
      // dropdownBuilder: _countryDropDownStyle,
      dropdownButtonProps:  const DropdownButtonProps(
        icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
        padding: EdgeInsets.zero,
      ),
      // dropdownDecoratorProps: const DropDownDecoratorProps(
      //   dropdownSearchDecoration: InputDecoration(
      //     contentPadding: EdgeInsets.zero,
      //     isCollapsed: true,
      //     hintText: "Select Category Type",
      //     hintStyle: TextStyle(
      //       color: Colors.black,
      //        fontSize: 14
      //     ),
      //     border: OutlineInputBorder()
      //   ),
      // ),
      items: getXController.categoryList,

      itemAsString: (ProviderCategoryTypeResponse? u) => u!.categoryAsString(),
      selectedItem: getXController.selectedCategory,
      onChanged: (value) {
        getXController.selectedCategory = value!;
      },
    );
  }


  ///*
  ///
  ///
  Widget serviceDropdown(){
    return MultiSelectDialogField(
      initialValue: getXController.selectedServiceList,
      items: getXController.multiServiceList,
      listType: MultiSelectListType.LIST,
      buttonText: const Text('Select Service'),
      buttonIcon:  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey)
      ),
      searchable: true,
      onConfirm: (values) {
        getXController.selectedServiceList = values;
      },
    );
  }

  ///*
  ///
  ///
  Widget specializationDropdown(){
    return MultiSelectDialogField(
      initialValue: getXController.selectedSpecializationList,
      items: getXController.multiSpecializationList,
      listType: MultiSelectListType.LIST,
      buttonText: const Text('Select Specialization'),
      buttonIcon:  const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey,),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey)
      ),
      searchable: true,
      onConfirm: (values) {
        getXController.selectedSpecializationList = values;
      },
    );
  }

  ///*
  ///
  ///
  buttonWidget() {
    return SizedBox(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: (){
            setState(() {
              getXController.isDataValid();

            });
          },
          style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),),
          child:  Text(
            widget.callFrom == 'Edit'?  'Update Specialization':'${widget.callFrom} Specialization',
            style: const TextStyle(
                color: MyColor.offWhite,
                fontSize: 16.0,
                fontFamily: 'poppins_semibold'
            ),
          )),
    );

  }

  ///*
  ///
  ///
  getStarLabel(String label) {
    return Row(
      children: [
        Text(label, style: const TextStyle(
            fontSize: 13.0,
            color: MyColor.themeTealBlue,
            fontFamily: 'poppins_semibold'
        ),),
        const Padding(
          padding: EdgeInsets.all(3.0),
        ),
        const Text('*', style: const TextStyle(color: Colors.red)),

      ],
    );

  }

  ///*
  ///
    setData() {
    getXController.callFrom = widget.callFrom;
    getXController.specializationId = widget.specializationId;

    getXController.selectedCategory.id = widget.categoryId;
    getXController.selectedCategory.provider = widget.categoryName;
    getXController.selectedCategory.medicalCareType = '';
    getXController.selectedCategory.providerType = '';

    if(getXController.callFrom == 'Edit'){
      getXController.selectedServiceList = getList(widget.services);
      getXController.selectedSpecializationList = getList(widget.specializations);
    }

  }

  ///*
  ///
  ///
  List<String> getList(String data) {
    List<String> stringList = data.split(",");
    // List<MultiSelectItem<String>> multiStringList = stringList.map((e) => MultiSelectItem(e, e)).toList();
    return stringList;

  }



///*
  ///
  ///
 /* Widget _countryDropDownStyle(
      BuildContext context, countryListResponse.Payload? selectedData) {
    return Text(
        selectedData!.countryName!.toString(),
        style: fieldStyle()
    );
  }
*/

  ///*
  ///
  ///
  Future<bool> _onWillPop() async{
    Get.back(result: ProviderGlobal.isSkillBack);
    return false;
  }
}
