import 'package:flutter/material.dart';
import 'package:tutor/chat_scree.dart';

import 'animation/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      
      home:  const  SplashScreen(),
      routes: {
        '/home': (context) => const ChatScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Najim Bacha',
      // theme: ThemeData(
      //   // brightness: Brightness.dark,

      //   primarySwatch: Colors.green,
      //   useMaterial3: true,
      // ),
    );
  }
}
