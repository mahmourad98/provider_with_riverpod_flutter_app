import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';

main(){
  AppRoot.init();
}

class AppRoot{
  static const _myApp = MyApp();

  AppRoot.init(){
    Provider.debugCheckInvalidValueType = null;
    HttpOverrides.global = MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    runApp(_myApp,);
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context,){
    return super.createHttpClient(context,)
      ..badCertificateCallback = (X509Certificate cert, String host, int port,) => true;
  }
}