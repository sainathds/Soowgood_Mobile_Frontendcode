import 'package:flutter/material.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderContactUsScreen extends StatefulWidget {
  const ProviderContactUsScreen({Key? key}) : super(key: key);

  @override
  _ProviderContactUsScreenState createState() => _ProviderContactUsScreenState();
}

class _ProviderContactUsScreenState extends State<ProviderContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0), // here the desired height
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [

                    Text('Contact Us',
                      style: TextStyle(
                          fontSize: 17.0,
                          color: MyColor.themeTealBlue,
                          fontFamily: 'poppins_Semibold'
                      ),),

                    // SizedBox(width: 20,)
                  ],
                ),
              ],
            ),
          ),
          body: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(10),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                  // topLeft: Radius.circular(10),

                )
              ),
            color: MyColor.tealBlueMedium,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    getLocationWidget(),
                    SizedBox(height: 5,),
                    getCallWidget(),
                    SizedBox(height: 5,),
                    getEmailWidget()

                  ] ),
            )
          )));
  }

  ///*
  ///
  ///
  getLocationWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children:  [
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
          color: MyColor.tealBlueDark),
          child: Icon(Icons.location_on, color: Colors.white, size: 20,),
        ),
        SizedBox(width: 10,),
        Expanded(child: Text('Mahtab Center (L-12) Suite #10, 177 Shahid Syed Nazrul Islam Sarani Bijoy Nagar, Dhaka-1000, Bangladesh',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'poppins_medium',
              fontSize: 14
          ),),)
      ],
    );
  }

  ///*
  ///
  ///
  getCallWidget() {
    return InkWell(
      onTap: (){
        redirectToPlatform('tel:+880 1818-153225');
      },
      child: Row(
        children:  [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                color: MyColor.tealBlueDark),
            child: Icon(Icons.call, color: Colors.white, size: 20,),
          ),

          SizedBox(width: 10,),
          Text('+880 1818-153225',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins_medium',
                fontSize: 14
            ),),
        ],
      ),
    );
  }

  ///*
  ///
  ///
  getEmailWidget() {
    return InkWell(
      onTap: (){
        redirectToPlatform('mailto:info@soowgood.com'); //get option to choose specific platform to open mail.
      },
      child: Row(
        children:  [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
                color: MyColor.tealBlueDark),
            child: Icon(Icons.email, color: Colors.white, size: 20,),
          ),        SizedBox(width: 10,),
          Text('info@soowgood.com',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins_medium',
                fontSize: 14
            ),),
        ],
      ),
    );
  }


  ///
  ///
  /// redirect to dial pad when call from mobile no. and
  /// get option to redirect on particular platform when call from email
  Future<void> redirectToPlatform(String url) async {
    if (await launchUrl(Uri.parse(url),
      mode: LaunchMode.platformDefault,

    )) {
      throw 'Could not launch $url';
    }
  }
}
