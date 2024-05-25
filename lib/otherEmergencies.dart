import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sos_system/screens/BloodNeed.dart';
import 'package:velocity_x/velocity_x.dart';




final navlinkFontStyle = GoogleFonts.dmSans(textStyle:const TextStyle(fontSize: 20,color: Colors.white));

class otherEmergencies extends StatelessWidget {
  const otherEmergencies({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final topPadding = screenHeight * 0.2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Other Emergency",style:navlinkFontStyle,),
        centerTitle: true,
        backgroundColor:Color.fromARGB(255, 135, 4,4),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 135, 4, 4),
                Color.fromARGB(255, 6, 0, 0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              children: [
                Card(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 200,
                        child: Lottie.asset('lib/Assets/Firebrigade.json'),
                      ),
                      Text('Call Firebrigade',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 200,
                        child: Lottie.asset('lib/Assets/Police.json'),
                      ),
                      Text('Call Police',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
                InkWell(
                  onTap :(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BloodNeeded()),
                    );
                },
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 180,
                          child: Lottie.asset('lib/Assets/Blood.json'),
                        ),
                        Text('Need blood',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 200,
                        child: Lottie.asset('lib/Assets/Ambulance.json'),
                      ),
                      Text('Call Ambulance',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
