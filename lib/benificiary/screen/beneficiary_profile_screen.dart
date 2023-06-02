import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soowgood/benificiary/controller/beneficiary_profile_controller.dart';
import 'package:soowgood/benificiary/screen/beneficiary_profile_setting_screen.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/common/screen/login_screen.dart';
import 'package:soowgood/common/screen/notification_list_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/local_database/key_constants.dart';
import '../../common/local_database/my_shared_preference.dart';
import '../../common/screen/change_password_screen.dart';
import '../../common/screen/privacy_policy_screen.dart';
import '../../provider/screen/provider_dashboard_screen.dart';

class BeneficiaryProfileScreen extends StatefulWidget {
  const BeneficiaryProfileScreen({Key? key}) : super(key: key);

  @override
  _BeneficiaryProfileScreenState createState() =>
      _BeneficiaryProfileScreenState();
}

class _BeneficiaryProfileScreenState extends State<BeneficiaryProfileScreen> {
  BeneficiaryProfileController getXController =
      Get.put(BeneficiaryProfileController());
  late Size size;
  String checkoriginal = '';

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(const Duration(), () {
      getXController.getProfileResponse();
    });
    getXController.isSwitchToBeneficial.value = false;
    start();
    super.initState();
  }

  start() async {
    checkoriginal =
        await MySharedPreference.getString(KeyConstants.keyUserRole) ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Text('Profile'),
            // actions: [
            //   const Icon(Icons.notifications_none_rounded),
            //   const SizedBox(
            //     width: 20,
            //   )
            // ],
          ),
          body: Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Container(child: getProfileDataWidget()),
                Expanded(child: getCardWidget())
              ],
            ),
          ),
        );
      }),
    );
  }

  ///*
  ///
  ///
  getProfileDataWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: Container(
            height: 120,
            width: 120,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: !getXController.isLoad.value &&
                          getXController.profileImageUrl.value == ''
                      ? Image(
                          image: noProfileImage,
                          width: 110.0,
                          height: 110.0,
                          fit: BoxFit.fill,
                        )
                      : getXController.isLoad.value &&
                              getXController.compressedImage.value == ''
                          ? Center(
                              child: CircularProgressIndicator(
                                color: MyColor.themeTealBlue,
                              ),
                            )
                          : getXController.compressedImage.value != ''
                              ? Image(
                                  image: FileImage(
                                      File(getXController.imageFile!.path)),
                                  width: 110.0,
                                  height: 110.0,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  getXController.profileImageUrl.value,
                                  width: 110.0,
                                  height: 110.0,
                                  fit: BoxFit.fill,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Image(
                                      image: noProfileImage,
                                      width: 110,
                                      height: 110,
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                ),
                Positioned(
                    right: 5,
                    bottom: 5,
                    child: InkWell(
                        onTap: () {
                          showImageOptionDialog();
                        },
                        child: Image(
                          image: cameraIcon,
                          height: 35.0,
                          width: 35.0,
                        )))
              ],
            ),
          ),
        ),
        Text(
          getXController.userName.value,
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontFamily: 'poppins_bold',
            fontSize: 17.0,
            color: MyColor.tealBlueDark,
          ),
        ),

/*
        Text(
          "Dr. ${getXController.email.value}",
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontFamily: 'poppins_medium',
            fontSize: 13.0,
            color: MyColor.tealBlueLight,
          ),
        ),
*/

        const SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  ///*
  ///
  ///
  void showImageOptionDialog() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    imageSelector(context, "gallery");
                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.image,
                        color: MyColor.tealBlueDark,
                        size: 40.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text('Gallery',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: MyColor.themeTealBlue,
                              fontFamily: 'poppins_semibold')),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    imageSelector(context, "camera");
                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_a_photo,
                        color: MyColor.tealBlueDark,
                        size: 40.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text('Camera',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: MyColor.themeTealBlue,
                              fontFamily: 'poppins_semibold')),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.cancel,
                        color: MyColor.tealBlueDark,
                        size: 40.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text('Cancel',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: MyColor.themeTealBlue,
                              fontFamily: 'poppins_semibold')),
                      SizedBox(
                        width: 10.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  ///*
  ///
  ///
  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        getXController.isLoad.value = false;
        getXController.compressedImage.value = '';
        getXController.imageFile = (await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 90))!;

        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: getXController.imageFile!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: MyColor.themeTealBlue,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
        );
        setState(() {
          getXController.imageFile = XFile(croppedFile!.path);
        });
        compressImage();

        break;

      case "camera": // CAMERA CAPTURE CODE
        getXController.imageFile = (await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 90))!;
        getXController.isLoad.value = true;
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: getXController.imageFile!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: MyColor.themeTealBlue,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
        );
        setState(() {
          getXController.imageFile = XFile(croppedFile!.path);
        });
        compressImage();

        break;
    }

    if (getXController.imageFile != null) {
      log("You selected  image : ${getXController.imageFile!.path}");
      setState(() {
        debugPrint("SELECTED IMAGE PICK   ${getXController.imageFile}");
      });
    } else {
      log("You have not taken image");
    }
  }

  ///*
  ///
  ///
  void compressImage() async {
    getXController.isLoad.value = true;

    final dir = await getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(
      getXController.imageFile!.path, targetPath,
      quality: 88,
      // rotate: 90,
    );

    if (result != null) {
      getXController.compressedImage.value = result.path;
      log('COMPRESSED_IMG_SIZED ${result.readAsBytes()}');
      getXController.uploadProfilePic();
    }
  }

  ///*
  ///
  ///
  getCardWidget() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (checkoriginal == "Provider") getBeneficiarySwitchWidget(),
            if (checkoriginal == "Provider") getDivider(),

            getProfileSettingWidget(),
            getDivider(),

/*
            getCardElement('Billing History'),
            getDivider(),
*/

            getCardElement('Password Change'),
            getDivider(),

            /*getCardElement('Health Questionnaire'),
            getDivider(),


            getCardElement('Services'),
            getDivider(),*/

            getCardElement('Notifications'),
            getDivider(),

/*            getCardElement('Health News'),
            getDivider(),


            getCardElement('Need Help?'),
            getDivider(),

            getCardElement('Contact Us'),
            getDivider(),*/

            getCardElement('Rate The App'),
            getDivider(),

            // getCardElement('Terms & Conditions'),
            // getDivider(),

            getCardElement('Privacy Policy & Terms'),
            getDivider(),

            getCardElement('Logout'),
            getDivider(),

            getCardElement('Delete Account'),
            // getDivider(),
          ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  getDivider() {
    return const Divider(
      color: Colors.black12,
      height: 0.1,
    );
  }

  getBeneficiarySwitchWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Become A Provider',
            style: TextStyle(
                color: MyColor.tealBlueDark,
                fontSize: 14.0,
                fontFamily: 'Poppins_semibold'),
          ),
          Transform.scale(
            scale: 1,
            child: Switch(
              onChanged: (value) {
                getXController.isSwitchToBeneficial.value = true;

                if (getXController.isSwitchToBeneficial.value) {
                  Get.off(const ProviderDashboardScreen());
                }
              },
              value: getXController.isSwitchToBeneficial.value,
              activeColor: Colors.blue,
              activeTrackColor: Colors.grey,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getProfileSettingWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Profile Settings',
            style: TextStyle(
                color: MyColor.tealBlueDark,
                fontSize: 14.0,
                fontFamily: 'Poppins_semibold'),
          ),
          Row(
            children: [
              InkWell(
                onTap: () async {
                  var result = await Get.to(
                      () => const BeneficiaryProfileSettingScreen());
                  if (result) {
                    Future.delayed(const Duration(), () {
                      getXController.getProfileResponse();
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 7, right: 7, top: 2, bottom: 2),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: MyColor.lightPink,
                  ),
                  child: const Text(
                    'Update info',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 14.0,
                        fontFamily: 'poppins_medium'),
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              const Icon(Icons.keyboard_arrow_right)
            ],
          )
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getCardElement(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: MyColor.tealBlueDark,
                fontSize: 14.0,
                fontFamily: 'Poppins_semibold'),
          ),
          InkWell(
              onTap: () async {
                if (text == 'Password Change') {
                  Get.to(() => const ChangePasswordScreen());
                } else if (text == 'Notifications') {
                  Get.to(() => const NotificationListScreen());
                } else if (text == 'Rate The App') {
                  launchUrl(
                      Uri.parse(
                          "https://play.google.com/store/apps/details?id=com.app.soowgood"),
                      mode: LaunchMode.externalNonBrowserApplication);
                } else if (text == 'Privacy Policy & Terms') {
                  var data = await rootBundle
                      .loadString("assets/images/soowgood.html");
                  Get.to(() => PrivacyPolicy(data));
                  // launchUrl(Uri.parse(await rootBundle.loadString("assets/images/soowgood.html")));
                } else if (text == 'Logout') {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Logout',
                          style: TextStyle(
                              fontFamily: "poppins_regular",
                              fontWeight: FontWeight.bold)),
                      content: Text('Do you want to Logout?',
                          style: TextStyle(
                              fontFamily: "poppins_regular",
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('No',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "poppins_regular",
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.clear();
                              Get.offAll(const LoginScreen());
                            },
                            child: Text('Yes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "poppins_regular",
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (text == 'Delete Account') {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete Account',
                          style: TextStyle(
                              fontFamily: "poppins_regular",
                              fontWeight: FontWeight.bold)),
                      content: Text('Do you want to delete your account?',
                          style: TextStyle(
                              fontFamily: "poppins_regular",
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: Text('No',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "poppins_regular",
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              getXController.deleteAccountResponse();
                            },
                            child: Text('Yes',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "poppins_regular",
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Icon(Icons.keyboard_arrow_right))
        ],
      ),
    );
  }
}
