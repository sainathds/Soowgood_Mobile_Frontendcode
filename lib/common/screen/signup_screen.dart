import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:soowgood/common/controller/signup_controller.dart';
import 'package:soowgood/common/dialog/custom_progress_dialog.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/common/screen/login_screen.dart';


class SignupScreen extends StatefulWidget {
  String title;
  SignupScreen(this.title);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {


  SignupController getXController = Get.put(SignupController());
  CustomProgressDialog progressDialog = CustomProgressDialog();
  GoogleSignInAccount? googleCurrentUser;
  GoogleSignIn? googleSignIn;

  @override
  void initState() {
    // TODO: implement initState
    MySharedPreference.getInstance(); //get instance of ShearedPref
    getXController.userRole = Get.arguments;
    log("DataArgs : ${getXController.userRole}");

    googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        ApiConstant.googleProfileApi,
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Obx((){
            return Column(
              children: [

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250.0,
                  child: Image(
                    image: providerSignupImg,
                    fit: BoxFit.fill,
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: MyColor.themeTealBlue,
                    padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [

                          Text(
                            '${widget.title} Signup',
                            style: const TextStyle(
                                color: MyColor.offWhite,
                                fontSize: 24.0,
                                fontFamily: 'poppins_bold'
                            ),
                          ),

                          const Text(
                            'Get an organized platform for your services.',
                            style: TextStyle(
                                color: MyColor.offWhite,
                                fontSize: 13.0,
                                fontFamily: 'poppins_regular'
                            ),
                          ),

                          const SizedBox(height: 30.0,),
                          emailOrPhoneWidget(),


                          const SizedBox(height: 30.0,),
                          signupButtonWidget(),

                          const SizedBox(height: 20.0,),
                          // const Align(
                          //   alignment: Alignment.center,
                          //   child: Text('OR',
                          //   style: TextStyle(
                          //     color: MyColor.offWhite,
                          //     fontSize: 13.0,
                          //     fontFamily: 'poppins_medium'
                          //   ),),
                          // ),

                          // const SizedBox(height: 20.0,),
                          // socialMediaIconWidget(),
                          //
                          const SizedBox(height: 30.0,),
                          haveAccountWidget()
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            );
          })
        ));
  }


  ///*
  ///
  ///
  emailOrPhoneWidget() {
     return TextFormField(
       onTap: () {
         getXController.isEmailPhoneEmpty.value = false;
       },
       controller: getXController.emailPhoneController,
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
           hintText: 'Email Address',
           hintStyle: const TextStyle(
               fontSize: 13.0,
               color: MyColor.hintColor,
               fontFamily: 'poppins_regular'
           ),
           errorText: getXController.isEmailPhoneEmpty.value == true ? "Please Enter Email Address/Phone Number" : null
       ),
     );
  }


  ///*
  ///
  ///
  signupButtonWidget() {
    return SizedBox(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: (){
            getXController.isSignUpDataValid();
            },
          style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),),
          child: const Text(
            'Sign up',
            style: TextStyle(
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
  socialMediaIconWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        //icon 1
       if(GetPlatform.isAndroid)
           InkWell(
                onTap: (){
                  googleLogin();
                },
               child: Image(image: googlePlusIc, width: 41),)
        else if (GetPlatform.isIOS)
       Container(
           width: 40,
           height: 40,
           padding: const EdgeInsets.all(3),
           decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white),
           child: const Icon(FontAwesomeIcons.apple,size: 32,)),


        //icon 2
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
        //   child: Image(image: facebookIc,),
        // ),
        //
        //
        // //icon 3
        // Image(image: linkedinIc,)

      ],

    );
  }

  ///*
  ///
  ///
  haveAccountWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [

        const Text(
          "Already have an account?",
          style: TextStyle(
              color: MyColor.offWhite,
              fontSize: 13.0,
              fontFamily: 'poppins_regular'
          ),
        ),


        InkWell(
          onTap: (){
            Get.offAll(const LoginScreen());
            },
          child: Text(
            ' Login',
            style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'poppins_semibold',
                color: MyColor.themeSkyBlue
            ),
          ),
        )

      ],
    );

  }

  ///*
  ///
  ///
  Future<void> googleLogin() async {
    try {
      progressDialog.showProgressDialog();
      googleSignIn!.disconnect(); //use to signout

      GoogleSignInAccount? googleAccount = await googleSignIn!.signIn();
      if(googleAccount != null){
        log("Result : ${googleAccount.email}");
        log("Result : ${googleAccount.id}");
        log("Result : ${googleAccount.displayName}");
        log("Result : ${googleAccount.photoUrl}");

        getXController.emailPhoneController.text = googleAccount.email.toString();
        progressDialog.close();
        getXController.isSignUpDataValid();
      }
    } catch (error) {
      print(error);
    }
  }

}
