import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/my_colors.dart';

class CustomProgressDialog{
  bool _dialogIsOpen = false;

  showProgressDialog({
    bool barrierDismissible = false,
  }){
    _dialogIsOpen = true;
    return showDialog(
         barrierDismissible: true,
        context: Get.context!,
        builder: (context){
          return WillPopScope(
              onWillPop: (){
                if(barrierDismissible){
                  _dialogIsOpen = false;
                }
                return Future.value(barrierDismissible);
              },
              child: ProgressDialogWidget());
        });
  }

  void close() {
    if (_dialogIsOpen) {
      Get.back();
      _dialogIsOpen = false;
    }
  }
}


class ProgressDialogWidget extends StatelessWidget {
  const ProgressDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      height: MediaQuery.of(context).size.height,
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        elevation: 20.0,
        backgroundColor: MyColor.themeSkyBlue,
        child: dialogContent(context),
      ),
    );
  }

  ///*
  ///
  ///
  dialogContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText("SoowGood",
                  textStyle: const TextStyle(
                    color: MyColor.themeTealBlue,
                      fontSize: 20.0,
                      fontFamily: 'poppins_bold'
                  ),
                  speed: Duration(milliseconds: 200),),
            ],
            isRepeatingAnimation: true,
            repeatForever: true,
          ),

          /*SizedBox(height: 10.0,),
          Text(
            "Please wait...",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontFamily: 'poppins_medium'
            ),
          )*/
        ],
      ),
    );
  }

}

