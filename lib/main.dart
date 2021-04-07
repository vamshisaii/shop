import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home-bloc.dart';
import 'home/home-page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APOD',
      home: Provider<HomeBloc>(
          create: (context) => HomeBloc(), child: HomePage()),
    );
  }
}
