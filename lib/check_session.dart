import 'package:flutter/material.dart';
import 'package:meals_bridge_frontend/Services/shared_preference.dart';
import 'package:meals_bridge_frontend/donner/home_screen_donner.dart';
import 'package:meals_bridge_frontend/user_registration.dart';

import 'donner/my_nav_bar.dart';

class UserSession extends StatefulWidget {
  const UserSession({super.key});

  @override
  State<UserSession> createState() => _UserSessionState();
}

class _UserSessionState extends State<UserSession> {

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    String? storedUid = await SharedPreferenceService.getUidFromLocalStorage();
    if (storedUid != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyNavBar(initialPageIndex: 0)));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserRegistration()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
