import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:mu/login_page%20(1).dart';
import 'package:mu/profpag.dart';

void main() {
  runApp(MyApp());
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
      home: const ProfilePge(), // <-- show ProfilePage first
    );
  }
}
