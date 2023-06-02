import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:soowgood/common/local_database/key_constants.dart';
import 'package:soowgood/common/local_database/my_shared_preference.dart';
import 'package:soowgood/provider/model/request/provider_dashboard_appointments_request.dart';
import 'package:soowgood/provider/model/request/provider_profile_status_request.dart';
import 'package:soowgood/provider/model/response/provider_dashboard_appointments_response.dart';
import 'package:soowgood/provider/model/response/provider_profile_status_response.dart';
import 'package:soowgood/provider/repository/provider_repository.dart';

class ProviderDashboardController extends GetxController{

  ProviderRepository repository = ProviderRepository();

}