import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_bridge_frontend/donner/map_test.dart';


import '../Services/shared_preference.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerContent(),
      body: Stack(
        children: [
          MapTest(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: 20,
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
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
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                  Container(
                    child: Text(
                      'Distributors Near You',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
