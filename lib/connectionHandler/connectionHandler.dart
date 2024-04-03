import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

/// ConnectionHandler call to handle the internet and WiFi connectivity.
class ConnectionHandler {
  ValueNotifier<bool> isConnected = ValueNotifier(true);

  Future<void> init() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    isInternetConnected(result);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isInternetConnected(result);
    });
  }

  bool isInternetConnected(ConnectivityResult? result) {
    if (result == ConnectivityResult.none) {
      isConnected.value = false;
      return false;
    } else if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      isConnected.value = true;
      return true;
    }
    return false;
  }
}
