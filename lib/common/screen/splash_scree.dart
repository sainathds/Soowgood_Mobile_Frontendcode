import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/screen/change_password_screen.dart';
import 'package:soowgood/common/screen/welcome_screen.dart';

import '../resources/my_assets.dart';
import '../resources/my_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(const Duration(seconds: 5), (){
      Get.off(const WelcomeScreen());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: MyColor.themeTealBlue,
      child: Center(child: Image(image: splashLogoImg,),),);
  }
}
