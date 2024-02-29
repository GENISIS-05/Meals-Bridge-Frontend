import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'archive_screen.dart';
import 'donate_screen.dart';
import 'home_screen_donner.dart';

class MyNavBar extends StatefulWidget {
  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<NavItemStyle> navItemStyles = [
    NavItemStyle(CupertinoIcons.home, 'Home', 0, Colors.green, 30),
    NavItemStyle(CupertinoIcons.cube_box, 'Donate', 1, Colors.black, 40),
    NavItemStyle(Icons.timelapse, 'Archives', 2, Colors.green, 30),
  ];

  @override
  void initState() {
    super.initState();
    resetNavStyles(); // Initialize the styles
    updateCurrentPageStyle(_currentIndex); // Update style for the initial page
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex > 0) {
          // If not on the home screen, navigate to the home screen
          _pageController.jumpToPage(0);
          setState(() {
            _currentIndex = 0;
            updateCurrentPageStyle(_currentIndex); // Update style for the home screen
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                  updateCurrentPageStyle(_currentIndex); // Update style for the current page
                });
              },
              physics: NeverScrollableScrollPhysics(), // Disable swipe functionality
              children: [
                HomeScreenDonner(),
                DonateScreen(),
                ArchiveScreen(),
              ],
            ),
            Visibility(
              visible: _currentIndex != 1,
              child: Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF63FF6A).withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (var navItemStyle in navItemStyles)
                              buildNavBarItem(
                                navItemStyle.icon,
                                navItemStyle.label,
                                navItemStyle.pageIndex,
                                navItemStyle.color,
                                navItemStyle.size,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavBarItem(
      IconData icon,
      String label,
      int pageIndex,
      Color color,
      double size,
      ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(icon, color: color, size: size),
            onPressed: () {
              _pageController.animateToPage(
                pageIndex,
                duration: Duration(milliseconds: 1),
                curve: Curves.easeInOut,
              );
            },
          ),
          Text(
            label,
            style: TextStyle(
              color: pageIndex == _currentIndex ? Colors.black : Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void resetNavStyles() {
    setState(() {
      for (var navItemStyle in navItemStyles) {
        navItemStyle.color = Colors.green;
        navItemStyle.size = 30;
      }
    });
  }

  void updateCurrentPageStyle(int index) {
    setState(() {
      resetNavStyles(); // Reset all styles
      if (index != 1) {
        navItemStyles[index].color = Colors.black;
      }
    });
  }
}

class NavItemStyle {
  final IconData icon;
  final String label;
  final int pageIndex;
  Color color;
  double size;

  NavItemStyle(this.icon, this.label, this.pageIndex, this.color, this.size);
}
