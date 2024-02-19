import 'package:flutter/material.dart';

class HomeScreenDonner extends StatefulWidget {
  const HomeScreenDonner({Key? key}) : super(key: key);

  @override
  State<HomeScreenDonner> createState() => _HomeScreenDonnerState();
}

class _HomeScreenDonnerState extends State<HomeScreenDonner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Your main content goes here

          // Bottom Navigation Bar
          Positioned(
            bottom: 30, // Adjust this value to set the height from the bottom
            left: 30,
            right: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF04FC10),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // First and Third Icons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.home, color: Colors.white, size: 40,),
                              onPressed: () {
                                // Add your home icon functionality here
                              },
                            ),
                            Text('Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.archive, color: Colors.white, size: 40,),
                              onPressed: () {
                                // Add your archive icon functionality here
                              },
                            ),
                            Text('Archives', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height*0.06, // Adjust this value based on your design
            left: MediaQuery.of(context).size.width*0.42,
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart, color: Color(0xFF04FC10), size: 40,),
                    onPressed: () {
                      // Add your order icon functionality here
                    },
                  ),
                ),
                Text('Donate', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
