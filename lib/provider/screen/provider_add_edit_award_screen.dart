import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_add_edit_award_controller.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderAddEditAwardScreen extends StatefulWidget {

  String callFrom;
  String awardId;
  String award;
  String year;


  ProviderAddEditAwardScreen({Key? key, required this.callFrom, required this.awardId, required this.award, required this.year}) : super(key: key);

  @override
  _ProviderAddEditAwardScreeState createState() => _ProviderAddEditAwardScreeState();
}

class _ProviderAddEditAwardScreeState extends State<ProviderAddEditAwardScreen> {

    ProviderAddEditAwardController getXController = Get.put(ProviderAddEditAwardController());

  late DateTime selectedYear  = DateTime.now();

    @override
    void initState() {
      // TODO: implement initState
      ProviderGlobal.isAwardBack = false;
      getXController.clearAll();
      setData();
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child: Obx((){
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,

                leading: InkWell(
                    onTap: (){
                      Get.back(result: ProviderGlobal.isAwardBack);
                    },
                    child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
                title: Text('${widget.callFrom} Award'),
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

                      getStarLabel('Award Name'),
                      const SizedBox(height: 5.0,),
                      awardField(),


                      const SizedBox(height: 20.0,),
                      getStarLabel('Receive Year'),
                      const SizedBox(height: 5.0,),
                      receiveYearField(),


                      const SizedBox(height: 30.0,),
                      buttonWidget()

                    ],
                  ),
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
    buttonWidget() {
      return SizedBox(
        height: 45.0,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            onPressed: (){
              getXController.isDataValid();
            },
            style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),),
            child:  Text(
              widget.callFrom == 'Edit' ? 'Update Award': '${widget.callFrom} Award',
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
    ///
    awardField() {
      return TextFormField(
        onTap: () {
          getXController.setAllErrorToFalse();
        },
        controller: getXController.awardController,
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
            const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0),
            hintText: 'Award Name',
            hintStyle: const TextStyle(
                fontSize: 13.0,
                color: MyColor.hintColor,
                fontFamily: 'poppins_regular'
            ),
            errorText: getXController.isAwardEmpty.value? "Please Enter Name Of Award" : null
        ),
      );
    }

    ///*
    ///
    ///
    receiveYearField() {
      return TextFormField(
        readOnly: true,
        onTap: () {
          getXController.setAllErrorToFalse();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Select Year"),
                content: Container( // Need to use container to add size constraint.
                  width: 300,
                  height: 300,
                  child: YearPicker(
                    firstDate: DateTime(DateTime.now().year - 100, 1),
                    lastDate: DateTime(DateTime.now().year + 100, 1),
                    initialDate: DateTime.now(),
                    // save the selected date to _selectedDate DateTime variable.
                    // It's used to set the previous selected date when
                    // re-showing the dialog.
                    selectedDate: selectedYear,
                    onChanged: (value) {
                      // close the dialog when year is selected.
                      Navigator.pop(context);
                      setState(() {
                        getXController.receiveYearController.text = value.year.toString();
                      });
                      // Do something with the dateTime selected.
                      // Remember that you need to use dateTime.year to get the year
                    },
                  ),
                ),
              );
            },
          );
        },
        controller: getXController.receiveYearController,
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
            const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0),
            hintText: 'Passing Year',
            hintStyle: const TextStyle(
                fontSize: 13.0,
                color: MyColor.hintColor,
                fontFamily: 'poppins_regular'
            ),
            errorText: getXController.isReceiveYearEmpty.value? "Please Enter Receive Year" : null
        ),
      );
    }

    ///*
    ///
    ///
  void setData() {
      getXController.callFrom = widget.callFrom;
      getXController.awardId = widget.awardId;
      getXController.awardController.text = widget.award;
      getXController.receiveYearController.text = widget.year;
  }

    ///*
    ///
    ///
  Future<bool> _onWillPop() async{
    Get.back(result: ProviderGlobal.isAwardBack);
    return false;
  }
}
