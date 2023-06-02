import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:soowgood/common/controller/login_controller.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soowgood/common/screen/signup_screen.dart';

import '../controller/signup_controller.dart';
import '../dialog/custom_progress_dialog.dart';
import '../resources/my_assets.dart';
import '../resources/my_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  LoginController getXController = Get.put(LoginController());
  SignupController getXSignUpController = Get.put(SignupController());
  CustomProgressDialog progressDialog = CustomProgressDialog();
  GoogleSignIn? googleSignIn;
  
  @override
  void initState() {
    // TODO: implement initState

    //uncomment below method when social login enable
    //initSocialLogins();

    getFcmToken();
    MySharedPreference.getInstance(); //get instance of ShearedPref
    super.initState();
  }


  void initSocialLogins() async {
    //google login
    googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );
  }


  ///
  ///
  /// initialize google login
  Future<void> googleLogin() async {
    try {
      googleSignIn!.signOut();
      GoogleSignInAccount? googleAccount = await googleSignIn!.signIn();
      if (googleAccount != null) {
        setState(() {
          getXSignUpController.emailPhoneController.text = googleAccount.email;
        });
        getXSignUpController.isSignUpDataValid();
      } else {
        Fluttertoast.showToast(msg: "Something went wrong, please try after sometime", toastLength: Toast.LENGTH_LONG);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Something went wrong, please try after sometime", toastLength: Toast.LENGTH_LONG);
    }
  }

  ///
  ///
  /// initialise apple login
  Future<void> appleLogin() async {
    /// Generates a cryptographically secure random nonce, to be included in a
    /// credential request.
    String generateNonce([int length = 32]) {
      final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = Random.secure();
      return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
    }

    /// Returns the sha256 hash of [input] in hex notation.
    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final credent = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: credent.identityToken,
        rawNonce: rawNonce,
        accessToken: credent.authorizationCode,
      );
      progressDialog.showProgressDialog();
      UserCredential appleId = await FirebaseAuth.instance.signInWithCredential(credential);

      await appleId.user!.reload();
      await appleId.user!.updateProfile(displayName: "${credent.givenName} ${credent.familyName}");
      await appleId.user!.updateEmail(appleId.user!.email.toString());

      print("credential ${appleId.user!.email} ${credent.givenName} ${credent.familyName}");
      setState(() {
        getXSignUpController.emailPhoneController.text = appleId.user!.email.toString();
      });
      progressDialog.close();
      getXSignUpController.isSignUpDataValid();
    } catch (error) {
      
      Fluttertoast.showToast(msg: "Something went wrong, please try after sometime", toastLength: Toast.LENGTH_LONG);
      print("appleLogin Exception : " + error.toString());

    }
  }
  
  
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Obx(() {
      return Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250.0,
            child: Image(
              image: loginImg,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: MyColor.themeTealBlue,
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        'Login Your Account ',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: MyColor.offWhite, fontSize: 24.0, fontFamily: 'poppins_bold'),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    emailOrPhoneWidget(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    passwordField(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    rememberMeAndForgotPassWidget(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    loginButtonWidget(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // const Align(
                    //   alignment: Alignment.center,
                    //   child: Text(
                    //     'OR',
                    //     style: TextStyle(color: MyColor.offWhite, fontSize: 13.0, fontFamily: 'poppins_medium'),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // socialMediaIconWidget(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    dontHavAccountWidget()
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    })));
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
      style: const TextStyle(fontSize: 14.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_medium'),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          hintText: 'Email Address',
          hintStyle: const TextStyle(fontSize: 13.0, color: MyColor.hintColor, fontFamily: 'poppins_regular'),
          errorText: getXController.isEmailPhoneEmpty.value ? "Please Enter Email Address/Phone Number" : null),
    );
  }

  ///*
  ///
  ///
  Widget passwordField() {
    return TextFormField(
        onTap: () {
          setState(() {
            getXController.setAllErrorToFalse();
          });
        },
        controller: getXController.passwordController,
        keyboardType: TextInputType.text,
        obscureText: getXController.isPasswordObscure.value,
        textInputAction: TextInputAction.next,
        focusNode: getXController.passwordFocus,
        style: const TextStyle(fontSize: 14.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_medium'),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            hintText: 'Password',
            hintStyle: const TextStyle(fontSize: 13.0, color: MyColor.hintColor, fontFamily: 'poppins_regular'),
            suffixIcon: IconButton(
              icon: Icon(
                getXController.isPasswordObscure.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() {
                  getXController.isPasswordObscure.value = !getXController.isPasswordObscure.value;
                });
              },
            ),
            errorText: getXController.isPasswordEmpty.value ? "Please Enter Password" : null));
  }

  ///*
  ///
  ///
  loginButtonWidget() {
    return SizedBox(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          onPressed: () {
            getXController.isDataValid();
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text(
            'Log In',
            style: TextStyle(color: MyColor.offWhite, fontSize: 16.0, fontFamily: 'poppins_semibold'),
          )),
    );
  }

  ///*
  ///
  ///
  socialMediaIconWidget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //icon 1
          // GetPlatform.isAndroid?
          if (GetPlatform.isIOS)
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: ()async{
                await appleLogin();
              },
              child: Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white),
                  child: const Icon(FontAwesomeIcons.apple,size: 32,)),
            ),

          //icon 2
          // Container(
          //     width: 30,
          //     height: 30,
          //     padding: const EdgeInsets.all(3),
          //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.blue.shade700),
          //     child: const Icon(
          //       FontAwesomeIcons.facebookF,
          //       color: Colors.white,
          //       size: 20,
          //     )),
          InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: ()async{
                await googleLogin();
              },
              child: Image(image: googlePlusIc, width: 41)),
          //icon 3
          // Container(
          //     width: 30,
          //     height: 30,
          //     padding: const EdgeInsets.all(3),
          //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.blue.shade600),
          //     child: const Icon(
          //       FontAwesomeIcons.linkedinIn,
          //       color: Colors.white,
          //       size: 20,
          //     )),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  rememberMeAndForgotPassWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        /*Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_box_outline_blank, color: MyColor.offWhite,),
            SizedBox(width: 5.0,),
            Text('Remember Me',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: MyColor.offWhite,
                    fontFamily: 'poppins_regular'
                  ),)
          ],
        ),
*/
        InkWell(
          onTap: () {
            // Get.toNamed(AppRoutes.forgotPasswordScreen);
          },
          child: const Text(
            'Forgot Password',
            style: TextStyle(fontSize: 13.0, color: MyColor.offWhite, fontFamily: 'poppins_medium'),
          ),
        )
      ],
    );
  }

  ///*
  ///
  ///
  dontHavAccountWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: MyColor.offWhite, fontSize: 13.0, fontFamily: 'poppins_regular'),
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                )),
                builder: (context) {
                  return userTypeWidget();
                });
          },
          child: Text(
            '  Register',
            style: TextStyle(fontSize: 13.0, fontFamily: 'poppins_semibold', color: MyColor.themeSkyBlue),
          ),
        )
      ],
    );
  }

  ///*
  ///
  ///
  userTypeWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Beneficiary Widget
        InkWell(
          onTap: () {
            Get.off(SignupScreen("Beneficiar"), arguments: "Beneficiar");
          },
          child: Card(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: MyColor.skyBlueLight,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: Image(
                  image: beneficiaryIcon,
                  height: 30,
                  width: 30,
                ),
                title: const Text(
                  'Beneficiary Signup',
                  style: TextStyle(fontSize: 16.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_regular'),
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(
                    top: 5.0,
                  ),
                  child: Text(
                    'I am looking for a Healthcare Specialist.',
                    style: TextStyle(fontSize: 12.0, color: MyColor.themeTealBlue, fontFamily: 'poppins_light'),
                  ),
                ),
              ),
            ),
          ),
        ),

        //Provider Widget
        InkWell(
          onTap: () {
            Get.offAll(SignupScreen("Provider"), arguments: "Provider");
          },
          child: Card(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0, bottom: 40.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: MyColor.themeTealBlue,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: Image(
                  image: providerIcon,
                  height: 30,
                  width: 30,
                ),
                title: const Text(
                  'Become Provider',
                  style: TextStyle(fontSize: 16.0, color: MyColor.offWhite, fontFamily: 'poppins_regular'),
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(
                    top: 5.0,
                  ),
                  child: Text(
                    'I am a Medical Healthcare Expert.',
                    style: TextStyle(fontSize: 12.0, color: MyColor.offWhite, fontFamily: 'poppins_light'),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  ///
  ///
  ///  get Firebase Token
  void getFcmToken() {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.getToken().then((token) {
      getXController.fcmToken.value = token!;
    });
  }
}
