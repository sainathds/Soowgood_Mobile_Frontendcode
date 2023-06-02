

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/my_colors.dart';

class OKDialog extends StatefulWidget {

   String? title;
   String? descriptions;
   AssetImage img;

  OKDialog(
      {Key? key,
      required this.title,
      required this.descriptions,
      required this.img}) : super(key: key);

  @override
  _OKDialogState createState() => _OKDialogState();
}

class _OKDialogState extends State<OKDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      elevation: 20.0,
      backgroundColor: MyColor.offWhite,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child:  Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15, bottom: 15, top: 10),
          // ignore: unnecessary_new
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  Image(image: widget.img, height: 60, width: 60,),
                  const SizedBox(height: 10),
                  widget.title != ""
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                widget.title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: MyColor.themeTealBlue,
                                    fontSize: 18.0,
                                    fontFamily: 'poppins_bold'),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                  widget.title != "" ? const SizedBox(height: 20) : SizedBox(),
                  widget.descriptions != ""
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                widget.descriptions!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: MyColor.themeTealBlue,
                                    fontSize: 16.0,
                                    fontFamily: 'poppins_medium')
                              ),
                            )
                          ],
                        )
                      : SizedBox(),
                  const SizedBox(height: 20),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.0,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: (){
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(shape:
                        RoundedRectangleBorder(
                          side: const BorderSide(
                          width: 1.0,
                          color: MyColor.skyBlueLight,
                        ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        primary: MyColor.themeTealBlue),
                        child: const Text(
                          'OK',
                          style: TextStyle(
                              color: MyColor.offWhite,
                              fontSize: 16.0,
                              fontFamily: 'poppins_semibold'
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
