

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class NetworkConnectivityService {


  NetworkConnectivityService._();
  static final _instance = NetworkConnectivityService._();
  static NetworkConnectivityService get instance => _instance;

  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  bool _isOnline = false;
  bool get isOnline => _isOnline;

  Future<void> initialize() async {
    ConnectivityResult result = await
    _networkConnectivity.checkConnectivity();

    _checkStatus(result);


    _networkConnectivity.onConnectivityChanged.listen((event) {

      _checkStatus(result);
    });
  }



  void _checkStatus(ConnectivityResult result ) async {
    try {
      final result = await
        InternetAddress.lookup("example.com");
      _isOnline = result.isNotEmpty &&
          result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      _isOnline = false ;
    }
    _controller.sink.add({result: _isOnline});

  }
  void disposeStream() => _controller.close();


  Future<bool> checkConnectivityToAddress (String address) async {

      try {
        final res = await  http.get(Uri.parse(address));
        if(res.statusCode == 200) {
          return true;
        }
        else {
          return false ;
        }
      } on Exception catch (e) {
        debugPrint(e.toString());
        return false;
      }

  }
}