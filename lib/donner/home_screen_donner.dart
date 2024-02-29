import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_bridge_frontend/donner/map_test.dart';


import 'drawer_content.dart';

class HomeScreenDonner extends StatefulWidget {
  const HomeScreenDonner({Key? key}) : super(key: key);

  @override
  State<HomeScreenDonner> createState() => _HomeScreenDonnerState();
}

class _HomeScreenDonnerState extends State<HomeScreenDonner> {
  double _animationValue = 1.0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();

    // Start a timer to update _animationValue over time
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        _animationValue -= 0.01; // Adjust the decrement value based on your preference
        if (_animationValue <= 0) {
          timer.cancel(); // Stop the timer when the animation is complete
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerContent(),
      body: Stack(
        children: [
          // CustomScrollView(
          //   slivers: [
          //     SliverAppBar(
          //       expandedHeight: MediaQuery.of(context).size.height,
          //       backgroundColor: Colors.black,
          //       flexibleSpace: FlexibleSpaceBar(
          //         background: Stack(
          //           children: [
          //             Container(
          //               decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                   image: AssetImage('assets/homebg.png'),
          //                   fit: BoxFit.cover,
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               decoration: BoxDecoration(
          //                 gradient: LinearGradient(
          //                   begin: Alignment.bottomRight,
          //                   colors: [
          //                     Colors.black,
          //                     Colors.black.withOpacity(.2),
          //                   ],
          //                 ),
          //               ),
          //               child: Padding(
          //                 padding: EdgeInsets.only(
          //                   left: MediaQuery.of(context).size.width,
          //                   bottom: MediaQuery.of(context).size.height,
          //                 ),
          //               ),
          //             ),
          //             Positioned(
          //               top: 120,
          //                 left: 20,
          //                 child: DefaultTextStyle(
          //                   style: const TextStyle(
          //                     fontSize: 30.0,
          //                     color: Colors.black,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                   child: Container(
          //                     width: MediaQuery.of(context).size.width - 40, // Adjust the width as needed
          //                     child: AnimatedTextKit(
          //                       animatedTexts: [
          //                         TypewriterAnimatedText('Help combat food wastage and hunger'),
          //                         TypewriterAnimatedText('Be mindful of your food consumption'),
          //                         TypewriterAnimatedText('Support initiatives to redistribute surplus food'),
          //                         TypewriterAnimatedText('Together, we can make a difference'),
          //                       ],
          //                       onTap: () {
          //                         print("Tap Event");
          //                       },
          //                     ),
          //                   ),
          //                 ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          MapTest(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: 20,
            child: GestureDetector(
              onTap: () {
                // Show a snackbar when the user clicks on the container
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('The feature is under development'),
                    backgroundColor: Colors.green, // Set the background color to green
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF04FC10).withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.1),
                  Container(
                    child: Text('Distributors Near You', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
