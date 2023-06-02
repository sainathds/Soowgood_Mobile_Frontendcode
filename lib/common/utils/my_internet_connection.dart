import 'dart:developer';
import 'dart:io';

class MyInternetConnection{


  ///
  ///
  /// use to check is internet connection is available or not
  /// its use before calling api.
  Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log('connected');
      }
      return true;

    } on SocketException catch (_) {
      log('not connected');
      return false;
    }
  }
}