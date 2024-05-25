import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sos_system/HomePage.dart';
import 'package:sos_system/screens/BloodNeed.dart';
import 'package:sos_system/screens/signin_screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
 void initState() {
    super.initState();
    //initializeBox();
    Timer(Duration(seconds:3), () {
      Navigator.pushReplacement(
           context,
           MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 6, 0, 0),
              Color.fromARGB(255, 135, 4, 4),
            ],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SOS Sytem',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 254, 254, 254),
                ),
              ),
              // Text(
              //   '____________________________',
              //   style: TextStyle(
              //       fontWeight: FontWeight.normal, color: Colors.black12),
              // ),
              Text(
                'You are enough to handle the Problem',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 252, 252, 252),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
