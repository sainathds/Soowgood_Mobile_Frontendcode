import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/controller/change_password_controller.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordController getXController = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,

            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
            title: Text('Change Password'),
          ),

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Text(
                    'For a strong password make sure to use Capital letters, numbers and symbols.',
                    style: TextStyle(
                      fontSize: 14,
                      color: MyColor.searchColor,
                      fontFamily: 'poppins_medium'
                    ),
                  ),

                  SizedBox(height: 20,),
                  getStarLabel('Current Password'),
                  const SizedBox(height: 5.0,),
                  currentPassField(),

                  const SizedBox(height: 20.0,),
                  getStarLabel('New Password'),
                  const SizedBox(height: 5.0,),
                  newPassField(),

                  const SizedBox(height: 20.0,),
                  getStarLabel('Re-Type Password'),
                  const SizedBox(height: 5.0,),
                  confirmPassField(),

                  const SizedBox(height: 30.0,),
                  buttonWidget()

                ],
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
  buttonWidget() {
    return SizedBox(
      height: 45.0,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: ElevatedButton(
          onPressed: () {
            getXController.isDataValid();
          },
          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),),
          child: Text(
            'Save Changes',
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
  currentPassField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.currentPassController,
      obscureText: getXController.isCurrentPassObscure.value,
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
          hintText: 'Current Password',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          suffixIcon: IconButton(
            icon: Icon(
              getXController.isCurrentPassObscure.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () {
              setState(() {
                getXController.isCurrentPassObscure.value = !getXController.isCurrentPassObscure.value;
              });
            },
          ),
          errorText: getXController.isCurrentPassEmpty.value? "Please Enter Current Password" : null
      ),
    );

  }


  ///*
  ///
  ///
  newPassField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.newPassController,
      obscureText: getXController.isNewPassObscure.value,
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
          hintText: 'Current Password',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          suffixIcon: IconButton(
            icon: Icon(
              getXController.isNewPassObscure.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () {
              setState(() {
                getXController.isNewPassObscure.value = !getXController.isNewPassObscure.value;
              });
            },
          ),
          errorText: getXController.isNewPassEmpty.value? "Please Enter New Password" : null
      ),
    );

  }


  ///*
  ///
  ///
  confirmPassField() {
    return TextFormField(
      onTap: () {
        getXController.setAllErrorToFalse();
      },
      controller: getXController.confirmPassController,
      obscureText: getXController.isConfirmPassObscure.value,
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
          hintText: 'Current Password',
          hintStyle: const TextStyle(
              fontSize: 13.0,
              color: MyColor.hintColor,
              fontFamily: 'poppins_regular'
          ),
          suffixIcon: IconButton(
            icon: Icon(
              getXController.isConfirmPassObscure.value
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            onPressed: () {
              setState(() {
                getXController.isConfirmPassObscure.value = !getXController.isConfirmPassObscure.value;
              });
            },
          ),
          errorText: getXController.isConfirmPassEmpty.value? "Please Enter Confirm Password" : getXController.isConfirmPassNotMatched.value ? 'Confirm Password Does Not Match' : null
      ),
    );

  }

}




