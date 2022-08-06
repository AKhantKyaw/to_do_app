import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/View/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NotesApp())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
            backgroundColor:  Color(0xff8D8DAA),
      body: Center(child: Text("Audio Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
    );
  }
}
