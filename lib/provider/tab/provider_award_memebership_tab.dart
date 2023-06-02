import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soowgood/common/resources/my_assets.dart';
import 'package:soowgood/common/resources/my_colors.dart';
import 'package:soowgood/provider/controller/provider_awards_membership_controller.dart';
import 'package:soowgood/provider/screen/provider_add_edit_award_screen.dart';

class ProviderAwardMembershipTab extends StatefulWidget {
  const ProviderAwardMembershipTab({Key? key}) : super(key: key);

  @override
  _ProviderAwardMembershipTabState createState() => _ProviderAwardMembershipTabState();
}

class _ProviderAwardMembershipTabState extends State<ProviderAwardMembershipTab> {

  ProviderAwardMembershipController getXController = Get.put(ProviderAwardMembershipController());
  late Size size ;

  @override
  void initState() {
    // TODO: implement initState
    getXController.clearAll();
    getXController.refreshPage = refreshPage;
    Future.delayed(const Duration(), (){
      getXController.getAwardListResponse();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(

        children: [

          getTitle('Awards', 'Award'),
          getXController.awardList.isNotEmpty?
          Expanded(child: getAwardListWidget())
              : const SizedBox( height: 100, child: Center(child: Text('Award details are not available')),),

          /*const SizedBox(height: 20,),
          getTitle('Membership', 'Membership'),
          getXController.experienceList.isNotEmpty?
          Expanded(child: getExperienceListWidget())
              : const Center(child: Text('Experience details are not available'),),
*/

        ],
      ),
    );
  }


  ///*
  ///
  ///
  getAwardListWidget() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: getXController.awardList.length,
              itemBuilder: (context , index){
                return Card(
                  elevation: 0.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                getData(getXController.awardList[index].name),
                                style: const TextStyle(
                                    color: MyColor.themeTealBlue,
                                    fontSize: 13.0,
                                    fontFamily: 'poppins_medium'
                                ),
                              ),
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
                                      var result = await Get.to(() =>  ProviderAddEditAwardScreen(
                                        callFrom: 'Edit',
                                        awardId: getXController.awardList[index].id.toString(),
                                        award: getXController.awardList[index].name!,
                                        year: getXController.awardList[index].receivedYear.toString(),
                                      ),);

                                      if(result){
                                        getXController.getAwardListResponse();
                                      }

                                      break;
                                    case 'Delete':
                                      getXController.getDeleteAwardResponse(getXController.awardList[index].id.toString());
                                      break;
                                  }
                                })

                          ],
                        ),

                        const SizedBox(height: 3,),
                        Text(
                          getData(getXController.awardList[index].receivedYear.toString()),
                          style: const TextStyle(
                              color: MyColor.themeTealBlue,
                              fontSize: 11.0,
                              fontFamily: 'poppins_medium'
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }),
        ],
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

            if(callFrom == 'Award'){
              var result = await Get.to(() =>  ProviderAddEditAwardScreen(
                callFrom: 'Add',
                awardId: '',
                award: '',
                year: ''
              ),);

              if(result){
                getXController.getAwardListResponse();
              }

            }else if(callFrom == 'Membership'){

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
  refreshPage(){
    setState(() {});
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


}
