import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soowgood/common/network/api_constant.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_medical_document_controller.dart';
import 'package:soowgood/provider/utils/provider_global.dart';

class ProviderMedicalDocumentDialog extends StatefulWidget {

  String serviceReceiverId;
  String bookingId;
  ProviderMedicalDocumentDialog({Key? key, required this.serviceReceiverId, required this.bookingId}) : super(key: key);

  @override
  _ProviderMedicalDocumentDialogState createState() => _ProviderMedicalDocumentDialogState();
}

class _ProviderMedicalDocumentDialogState extends State<ProviderMedicalDocumentDialog> {

  ProviderMedicalDocumentController getXController = Get.put(ProviderMedicalDocumentController());

  late PermissionStatus status ;
  late Directory externalDir;

  ReceivePort _port = ReceivePort();


  @override
  void initState() {
    // TODO: implement initState

    getXController.documentHistoryList.clear();
    getXController.serviceReceiverId.value = widget.serviceReceiverId;
    getXController.bookingId.value = widget.bookingId;

    ProviderGlobal.isMedicalDocDialogDismiss.value = false;

    Future.delayed(const Duration(),(){
      getXController.getPatientDocumentHistory();
    });
    log('SERVICE_RECEIVER_ID ${getXController.serviceReceiverId.value}  BOOKING_ID ${getXController.bookingId.value}');

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
    return Obx((){
          return Dialog(
             insetPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            elevation: 5.0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Medical Details',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'poppins_semibold'
                      ),
                    ),

                    getXController.documentHistoryList.isNotEmpty?
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index){
                            return getDocumentWidget(index);
                          },
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                          itemCount: getXController.documentHistoryList.length),
                    ):
                     Center(child: Container(child: const Text('No Data Found'),))
                  ],
                ),
              ),
            ),
          );
        }
    );

  }

  ///*
  ///
  ///
  Widget getDocumentWidget(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: MyColor.tealBlueDark,

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    const Icon(Icons.date_range_outlined, color: Colors.white, size: 15,),
                    const SizedBox(width: 3,),
                    Text(getXController.documentHistoryList[index].scheduleAppointmentDate!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins_medium',
                          fontSize: 12
                      ),)

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_outlined, color: Colors.white, size: 15,),
                    const SizedBox(width: 3,),
                    Text(
                      '${getXController.documentHistoryList[index].scheduleStartTime!}-'
                          '${getXController.documentHistoryList[index].scheduleEndTime}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'poppins_medium',
                          fontSize: 12
                      ),)

                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5,),
        InkWell(
          onTap: (){
            checkStoragePermission(getXController.documentHistoryList[index].documentname!); //check storage permission granted or not and if yes then download document
            },
          child: Row(
            children: [
              const Icon(
                Icons.download_rounded,
                color: Colors.black,
                size: 20,
              ),
              const SizedBox(width: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                    getXController.documentHistoryList[index].documentname!
                ),
              )
            ],
          ),
        ),

        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: (){
                // ProviderGlobal.isMedicalDocDialogDismiss.value = true;
                Get.back();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.deepOrangeAccent
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'poppins_semibold',
                    fontSize: 12
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }


  ///*
  ///
  ///
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
  ///
  Future<void> requestStoragePermission(String docFileName) async{
    status = await Permission.storage.request();

    if(status == PermissionStatus.granted){
      String? path = await getDownloadPath();
      if(path != null){
        downloadFile(path, docFileName);
      }
    }
    log('PERSMIISSION_STATUS : $status' );
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

        log('DIRECTORY_PATH _1 $directory');
        log('IS_EXIST_ ${await directory.exists()}');


        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
        log('DIRECTORY_PATH _2 $directory');

      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }


  ///*
  ///
  /// use to download document
  void downloadFile(String path, String docFileName) async{


    String newFileName = DateTime.now().millisecondsSinceEpoch.toString();
    String extension = docFileName.substring(docFileName.indexOf('.'), docFileName.length );
    log('EXTENSION_ $extension');


    final taskId = await FlutterDownloader.enqueue(
      url: '${ApiConstant.fileBaseUrl}${ApiConstant.appointmentDocFolder}/$docFileName',
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
