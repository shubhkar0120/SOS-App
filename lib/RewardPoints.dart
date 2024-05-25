import 'package:flutter/material.dart';
import 'RedeemPoints.dart';

class RewardPoints extends StatelessWidget {
  RewardPoints({Key? key}) : super(key: key);

  final int currentPoints = 1220;
  final List<String> cardNames = ['FlipKart', 'Amazon', 'Myntra', 'Ajio', 'Meesho'];
  final List<String> cardLogos = [
    'lib/Assets/logos/Flipcart_Logo.jpeg',
    'lib/Assets/logos/Amazon_Logo.jpeg',
    'lib/Assets/logos/Myntra_logo.png',
    'lib/Assets/logos/Ajio_Logo.png',
    'lib/Assets/logos/Meesho_Logo.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reward Points',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        centerTitle: true,
        backgroundColor:Color.fromARGB(255, 135, 4,4),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
              child: Center(
                child: Text(
                  'Total Points: $currentPoints',
                  style: TextStyle(fontSize: 30,color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        5,
                            (index) => SizedBox(
                          height: 200,
                          width: 400,
                          child: Card(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ReedemPoints(name: cardNames[index])),
                                );
                              },
                              child: Stack(
                                children: [
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      cardLogos[index % cardLogos.length],
                                                      height: 120,
                                                      width: 100,
                                                    ),
                                                    SizedBox(width: 30),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Gift Card Valued at \nRs 500 or 30% off at\n ${cardNames[index % cardNames.length] }',style: TextStyle(fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  'Expire Date',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                Text(
                                                  '30 March 2024',
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20), // Adjust spacing as needed
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    right: 25,
                                    child: Container(
                                      width: 80,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.purple, Colors.blue], // Gradient colors from purple to blue
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius: BorderRadius.circular(20), // Makes the container round
                                      ),
                                      child: Center(
                                        child: Text(
                                          '500',
                                          style: TextStyle(
                                            color: Colors.white, // Example text color, you can change it as needed
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
