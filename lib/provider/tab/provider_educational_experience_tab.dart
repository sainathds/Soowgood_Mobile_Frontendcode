import 'dart:developer' as dev;
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/provider/controller/provider_educational_experience_controller.dart';
import 'package:soowgood/provider/screen/provider_add_edit_document_screen.dart';
import 'package:soowgood/provider/screen/provider_add_edit_education_screen.dart';
import 'package:soowgood/provider/screen/provider_add_edit_experience_screen.dart';

import '../../common/resources/my_colors.dart';

class ProviderEducationalExperienceTab extends StatefulWidget {
  const ProviderEducationalExperienceTab({Key? key}) : super(key: key);

  @override
  _ProviderEducationalExperienceTabState createState() => _ProviderEducationalExperienceTabState();
}

class _ProviderEducationalExperienceTabState extends State<ProviderEducationalExperienceTab> {

  ProviderEducationExperienceController getXController = Get.put(ProviderEducationExperienceController());
  late Size size ;


  bool downloading = false;
  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  // late Permission permission1;

  late PermissionStatus status ;
  var _onPressed;
  static final Random random = Random();
  late Directory externalDir;

  ReceivePort _port = ReceivePort();


  @override
  void initState() {
    // TODO: implement initState


    getXController.clearAll();
    getXController.refreshPage = refreshPage;
    Future.delayed(const Duration(), (){
      getXController.getEducationListResponse();
    });
    Future.delayed(const Duration(), (){
      getXController.getExperienceListResponse();
    });
    Future.delayed(const Duration(), (){
      getXController.getDocumentListResponse();
    });


    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);

    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('https://api.soowgood.com');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('https://api.soowgood.com')!;
    send.send([id, status, progress]);
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(

         children: [

           getTitle('Educational Details', 'Education'),
           getXController.educationList.isNotEmpty?
           getEducationListWidget()
               : const SizedBox( height: 100, child: Center(child: Text('Education details are not available')),),


           const SizedBox(height: 20,),
           getTitle('Experience Details', 'Experience'),
           getXController.experienceList.isNotEmpty?
           getExperienceListWidget()
               : const SizedBox( height: 100, child: Center(child: Text('Experience details are not available')),),


           const SizedBox(height: 20,),
           getTitle('Documents', 'Document'),
           getXController.documentList.isNotEmpty?
           getDocumentListWidget()
               : const SizedBox( height: 100, child: Center(child: Text('Documents details are not available')),),


         ],
        ),
      ),
    );
  }

  ///*
  ///
  ///
  getTitle(String title, String callFrom) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text(
          title,
          style: const TextStyle(
              color: MyColor.themeSkyBlue,
              fontSize: 17.0,
              fontFamily: 'poppins_semibold'
          ),
        ),

        InkWell(
          onTap: () async{

            if(callFrom == 'Education'){
              var result = await Get.to(() => ProviderAddEditEducationScreen(
                callFrom: 'Add',
                educationId: '',
                degree: '',
                college: '',
                year: '',
              ));

              if(result){
                getXController.getEducationListResponse();
              }

            }else  if(callFrom == 'Experience'){
              var result = await Get.to(() => ProviderAddEditExperienceScreen(
                callFrom: 'Add',
                experienceId: '',
                hospital: '',
                designation: '',
                fromDate: '',
                toDate: '',
              ));

              if(result){
                getXController.getExperienceListResponse();
              }

            }else if(callFrom == 'Document'){
             var result = await Get.to(() => ProviderAddEditDocumentScreen(
                  callFrom: 'Add',
                  documentId: '',
                  documentName: '',
                  fileName: '',));

              if(result){
                getXController.getDocumentListResponse();
              }

            }
          },
          child: Container(
            padding: const EdgeInsets.only(left: 7, right: 7, top: 5, bottom: 5),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: MyColor.themeSkyBlue,
            ),
            child:  Text(
              '+ Add $callFrom',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontFamily: 'poppins_medium'
              ),
            ),
          ),
        ),
      ],
    );

  }


  ///*
  ///
  ///
  getEducationListWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: getXController.educationList.length,
            itemBuilder: (context , index){
              return Card(
                elevation: 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [


                        Row(
                          children: [

                            Image(image: degreeIcon, height: 40, width: 40),

                            const SizedBox(width: 5,),
                            Text(
                              getData(getXController.educationList[index].name),
                              style: getNameStyle(),
                            ),
                          ],
                        ),

                        PopupMenuButton(
                            icon: Icon(Icons.more_vert, color: Colors.black,),
                            // add this line
                            itemBuilder: (_) => <PopupMenuItem<String>>[
                              const PopupMenuItem<String>(
                                  value: 'Edit',
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'popins_regular',
                                    ),
                                  )),
                              const PopupMenuItem<String>(
                                  value: 'Delete',
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'popins_regular',
                                    ),
                                  )),
                            ],
                            onSelected: (value) async {
                              switch (value) {
                                case 'Edit':
                                  var result = await Get.to(() =>  ProviderAddEditEducationScreen(
                                    callFrom: 'Edit',
                                    educationId: getXController.educationList[index].id.toString(),
                                    degree: getXController.educationList[index].name!,
                                    college: getXController.educationList[index].institution!,
                                    year: getXController.educationList[index].yearOfCompletion.toString(),
                                  ),);

                                  if(result){
                                    getXController.getEducationListResponse();
                                  }
                                  break;
                                case 'Delete':
                                 getXController.getDeleteEducationResponse(getXController.educationList[index].id.toString());
                                  break;
                              }
                            })

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Text(
                        getData(getXController.educationList[index].institution),
                        style: const TextStyle(
                            color: MyColor.themeTealBlue,
                            fontSize: 13.0,
                            fontFamily: 'poppins_medium'
                        ),
                      ),
                    ),

                    const SizedBox(height: 3,),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0, bottom: 10),
                      child: Text(
                        getData(getXController.educationList[index].yearOfCompletion.toString()),
                        style: const TextStyle(
                            color: MyColor.themeTealBlue,
                            fontSize: 11.0,
                            fontFamily: 'poppins_medium'
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }),
      ],
    );
  }


  ///*
  ///
  ///
  getExperienceListWidget() {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: getXController.experienceList.length,
            itemBuilder: (context , index){
              return Card(
                elevation: 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [


                        Row(
                          children: [

                            Image(image: degreeIcon, height: 40, width: 40),

                            const SizedBox(width: 5,),
                            Text(
                              getData(getXController.experienceList[index].hospitalName),
                              style: getNameStyle(),
                            ),
                          ],
                        ),

                        PopupMenuButton(
                            icon: Icon(Icons.more_vert, color: Colors.black,),
                            // add this line
                            itemBuilder: (_) => <PopupMenuItem<String>>[
                              const PopupMenuItem<String>(
                                  value: 'Edit',
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'popins_regular',
                                    ),
                                  )),
                              const PopupMenuItem<String>(
                                  value: 'Delete',
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'popins_regular',
                                    ),
                                  )),
                            ],
                            onSelected: (value) async {
                              switch (value) {
                                case 'Edit':
                                  var result = await Get.to(() =>  ProviderAddEditExperienceScreen(
                                    callFrom: 'Edit',
                                    experienceId: getXController.experienceList[index].id.toString() ,
                                    hospital: getXController.experienceList[index].hospitalName!,
                                    designation: getXController.experienceList[index].designation!,
                                    fromDate: getFormattedDate(getXController.experienceList[index].fromDate!),
                                    toDate: getFormattedDate(getXController.experienceList[index].toDate!),
                                  ),);

                                  if(result){
                                    getXController.getExperienceListResponse();
                                  }

                                  break;
                                case 'Delete':
                                  getXController.getDeleteExperienceResponse(getXController.experienceList[index].id.toString());
                                  break;
                              }
                            })

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Text(
                        getData(getXController.experienceList[index].designation),
                        style: const TextStyle(
                            color: MyColor.themeTealBlue,
                            fontSize: 13.0,
                            fontFamily: 'poppins_medium'
                        ),
                      ),
                    ),

                    const SizedBox(height: 3,),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0, bottom: 10),
                      child: Text(
                          '${getMonthStringDate(getXController.experienceList[index].fromDate!)} - ${getMonthStringDate(getXController.experienceList[index].toDate!)}',
                          style: const TextStyle(
                            color: MyColor.themeTealBlue,
                            fontSize: 11.0,
                            fontFamily: 'poppins_medium'
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }),
      ],
    );
  }

  ///*
  ///
  ///
  getDocumentListWidget() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: getXController.documentList.length,
        itemBuilder: (context , index){
          return Card(
            elevation: 0.5,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      Row(
                        children: [

                          Image(image: degreeIcon, height: 40, width: 40),

                          const SizedBox(width: 5,),
                          Text(
                            getData(getXController.documentList[index].documentname),
                            style: getNameStyle(),
                          ),
                        ],
                      ),

                      PopupMenuButton(
                          icon: Icon(Icons.more_vert, color: Colors.black,),
                          // add this line
                          itemBuilder: (_) => <PopupMenuItem<String>>[
                            const PopupMenuItem<String>(
                                value: 'Edit',
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'popins_regular',
                                  ),
                                )),
                            const PopupMenuItem<String>(
                                value: 'Delete',
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'popins_regular',
                                  ),
                                )),
                            const PopupMenuItem<String>(
                                value: 'Download',
                                child: Text(
                                  "Download",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'popins_regular',
                                  ),
                                )),
                          ],
                          onSelected: (value) async {
                            switch (value) {
                              case 'Edit':
                                var result = await Get.to(() => ProviderAddEditDocumentScreen(
                                  callFrom: 'Edit',
                                  documentId: getXController.documentList[index].id.toString(),
                                  documentName: getXController.documentList[index].documentname!,
                                  fileName: getXController.documentList[index].documentfilename!,));

                                if(result){
                                  getXController.getDocumentListResponse();
                                }

                                break;
                                case 'Delete':
                                getXController.getDeleteDocumentResponse(getXController.documentList[index].id.toString());
                                  break;

                              case 'Download':
                                checkStoragePermission(getXController.documentList[index].documentfilename!);
                                break;

                            }
                          })

                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 45.0),
                    child: Text(
                      getData(getXController.documentList[index].documentfilename),
                      style: const TextStyle(
                          color: MyColor.themeTealBlue,
                          fontSize: 13.0,
                          fontFamily: 'poppins_medium'
                      ),
                    ),
                  ),


                ],
              ),
            ),
          );
        });
  }


  ///*
  ///
  ///
  String getFormattedDate(String dateTime){

    String date = dateTime.substring(0, 10);
    DateFormat formatter = DateFormat('MM-dd-yyyy');
    DateTime _stringdate;
    String formatedDate = "";

    List<String> validadeSplit = date.split('/');

    if(validadeSplit.length > 1)
    {
      int year = int.parse(validadeSplit[0].toString());
      int month = int.parse(validadeSplit[1].toString());
      int day = int.parse(validadeSplit[2].toString());

      _stringdate = DateTime.utc(year, month, day);
      formatedDate = formatter.format(_stringdate);
      print("tempDate :" + formatedDate);

    }

    return formatedDate;
  }


  ///*
  ///
  ///
  String getMonthStringDate(String dateTime){

    String date = dateTime.substring(0, 10);
    DateFormat formatter = DateFormat('dd MMM yyyy');
    DateTime _stringdate;
    String formatedDate = "";

    List<String> validadeSplit = date.split('/');

    if(validadeSplit.length > 1)
    {
      int year = int.parse(validadeSplit[0].toString());
      int month = int.parse(validadeSplit[1].toString());
      int day = int.parse(validadeSplit[2].toString());

      _stringdate = DateTime.utc(year, month, day);
      formatedDate = formatter.format(_stringdate);
      print("tempDate :" + formatedDate);

    }

    return formatedDate;
  }

  ///*
  ///
  ///
  String getData(String? data) {

    if(data != null){
      return data;
    }else{
      return data = '';
    }
  }

  ///*
  ///
  ///
  getNameStyle() {
    return const TextStyle(
      color: MyColor.themeTealBlue,
      fontSize: 15.0,
      fontFamily: 'poppins_semibold'
    );
  }


  ///*
  ///
  ///
  refreshPage(){
    setState(() {});
  }


  ///*
  ///
  /// check storage permission granted or not
  Future<void> checkStoragePermission(String docFileName) async{
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
    status = await Permission.storage.status;
    if (status.isDenied) {
      requestStoragePermission(docFileName);
    }else if(status.isGranted){
      String? path = await getDownloadPath();
      if(path != null){
        downloadFile(path, docFileName);
      }
    }

  }

  ///*
  ///
  /// request for storage permission
  Future<void> requestStoragePermission(String docFileName) async{
    status = await Permission.storage.request();

    if(status == PermissionStatus.granted){
      String? path = await getDownloadPath();
      if(path != null){
        downloadFile(path, docFileName);
      }
    }
    dev.log('PERSMIISSION_STATUS : $status' );
  }

  ///*
  ///
  ///
  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io

        dev.log('DIRECTORY_PATH _1 $directory');
        dev.log('IS_EXIST_ ${await directory.exists()}');


        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
          dev.log('DIRECTORY_PATH _2 $directory');

      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }


  ///*
  ///
  /// flutter_downloader use to download document from url
  void downloadFile(String path, String docFileName) async{


    String newFileName = DateTime.now().millisecondsSinceEpoch.toString();
    String extension = docFileName.substring(docFileName.indexOf('.'), docFileName.length );
    dev.log('EXTENSION_ $extension');


    final taskId = await FlutterDownloader.enqueue(
      url: '${ApiConstant.fileBaseUrl}ProviderDocument/$docFileName',
      // url: imgUrl,
      // headers: Map<String, "http://204.93.160.159:8080/api/">, // optional: header send with url (auth token etc)
      savedDir: path,
      fileName: '$newFileName $extension',
      saveInPublicStorage: true,
      showNotification: true, // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)

    );
  }
}
