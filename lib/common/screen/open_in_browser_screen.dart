import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/dialog/custom_progress_dialog.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webviewx/webviewx.dart';

class OpenInBrowserScreen extends StatefulWidget {

  String url;
   OpenInBrowserScreen({Key? key, required this.url}) : super(key: key);

  @override
  _OpenInBrowserScreenState createState() => _OpenInBrowserScreenState();
}

class _OpenInBrowserScreenState extends State<OpenInBrowserScreen> {
  late WebViewXController webviewController;
  CustomProgressDialog progressDialog = CustomProgressDialog();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.5,
              backgroundColor: Colors.white,
              leading: InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: Image(image: backArrowWhiteIcon, color: Colors.black,)),
              centerTitle: true,
              title: const Text('Document'),
            ),
            body:
            Container(
                child: SfPdfViewer.network(
                    widget.url))
          ),
        )
    );

  }
}
