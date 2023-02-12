import 'dart:async';

import 'package:anime_radio/src/services/ColorService.dart';
import 'package:anime_radio/src/services/NetworkConnectivityService.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class BuildOnlineStatus extends StatefulWidget {
  const BuildOnlineStatus({Key? key}) : super(key: key);

  @override
  State<BuildOnlineStatus> createState() => _BuildOnlineStatusState();
}

class _BuildOnlineStatusState extends State<BuildOnlineStatus> {

  final NetworkConnectivityService _networkConnectivity = NetworkConnectivityService.instance;
  Map _source = {ConnectivityResult.none: false};
  String string = '';
  late StreamSubscription subscription ;


  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  // }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _networkConnectivity.initialize();
    subscription = _networkConnectivity.myStream.listen((source) {

      _source = source;
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string =
          _source.values.toList()[0] ? 'Mobile: Online' : 'Mobile: Offline';
          break;
        case ConnectivityResult.wifi:
          string =
          _source.values.toList()[0] ? 'WiFi: Online' : 'WiFi: Offline';
          break;
        case ConnectivityResult.none:
          string = 'Offline';
          break ;


      }

      setState(() {});

    });
  }
  @override
  void dispose() {

    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildLineDot(_source.values.first),
        const SizedBox(width: 10),
        Text(string , )
      ],
    );
  }

  Widget buildLineDot (bool online) => Container(
    width: 7.5,
    height: 7.5,
    decoration: BoxDecoration(
        color: online ? ColorService.green : ColorService.red,
        shape: BoxShape.circle,
    ),
  );
}
