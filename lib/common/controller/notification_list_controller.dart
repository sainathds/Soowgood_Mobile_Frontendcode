import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/common/model/request/delete_all_notification_request.dart';
import 'package:soowgood/common/model/request/notification_list_request.dart';
import 'package:soowgood/common/model/request/read_all_notification_request.dart';
import 'package:soowgood/common/model/response/notification_list_response.dart';
import 'package:soowgood/common/model/response/read_all_notification_response.dart';
import 'package:soowgood/provider/model/response/provider_patient_list_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class NotificationListController extends GetxController{

  ProviderRepository repository = ProviderRepository();
  var notificationList = <NotificationListResponse>[].obs;

  var isReadNotificationIcShow = false.obs;


  var isBack = false.obs;

  ///*
  ///
  ///
   Future getNotificationListResponse() async{

    NotificationListRequest requestModel = NotificationListRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);

    // requestModel.id = 'eb9ce487-8c86-49ef-aff9-17dd2f49d459';

    List<NotificationListResponse>? responseModel = await repository.hitGetNotificationListApi(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      notificationList.clear();
      notificationList.value = responseModel;
      if(responseModel[0].isread == 1){
        isReadNotificationIcShow.value = true;
      }
    }else {
      notificationList.clear();
    }
  }


  ///*
  ///
  ///
  void readNotificationResponse() async{

    ReadAllNotificationRequest requestModel = ReadAllNotificationRequest();
    requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);


    List<ReadAllNotificationResponse>? responseModel = await repository.hitReadAllNotification(requestModel);

    if(responseModel != null && responseModel.isNotEmpty){
      if(responseModel[0].isread == 1){
        getNotificationListResponse();
      }
    }
  }


  ///*
  ///
  ///
  void deleteAllNotifications() async{
     DeleteAllNotificationRequest requestModel = DeleteAllNotificationRequest();
     requestModel.id = MySharedPreference.getString(KeyConstants.keyUserId);
     // requestModel.id = 'eb9ce487-8c86-49ef-aff9-17dd2f49d459';

     bool? responseModel = await repository.hitDeleteAllNotificationApi(requestModel);

     if(responseModel != null && responseModel){
       isBack.value = true;
       getNotificationListResponse();
     }
   }
}