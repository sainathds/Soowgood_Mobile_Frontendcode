import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';

class AskDialog extends StatelessWidget {
  String msg;
  Function yesFunction;

  AskDialog({
    required this.msg,
    required this.yesFunction,});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image(image: questionImage, height: 50, width: 50,),
          ),

          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 0.0),
            child: Text(msg,
                textAlign: TextAlign.center,
                style: labelStyle()),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 35,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: MyColor.themeTealBlue),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                      yesFunction.call();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.transparent),
                        elevation: MaterialStateProperty.all(0)),
                    child: Text("Yes",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'lato_semibold'))),
              ),

              Container(
                width: 80,
                height: 35,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: MyColor.themeSkyBlue),
                child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.transparent),
                        elevation: MaterialStateProperty.all(0)),
                    child: Text("No",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'lato_semibold'))),
              ),
            ],
          )
        ],
      ),
    );
  }


  ///*
  ///
  TextStyle labelStyle() {
    return const TextStyle(
        fontSize: 16,
        color: MyColor.searchColor,
        fontFamily: 'poppins_semibold'
    );
  }

  ///*
  ///
  TextStyle titleStyle() {
    return const TextStyle(
        fontSize: 16,
        color: MyColor.themeTealBlue,
        fontFamily: 'poppins_semibold'
    );
  }

}
