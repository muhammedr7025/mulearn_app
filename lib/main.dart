import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mu/forgot_password.dart';
import 'package:mu/login_page%20(1).dart';

import 'package:mu/login_with_otp%20(1).dart';

import 'package:mu/profpag.dart';
import 'package:mu/signup_page.dart';


void main() {
  runApp(
    DevicePreview(
      enabled: true, // set false to disable on release
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true, // important for DevicePreview
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: DevicePreview.appBuilder, // 👈 add this
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(), // <-- show ProfilePage first
    );
  }
}
