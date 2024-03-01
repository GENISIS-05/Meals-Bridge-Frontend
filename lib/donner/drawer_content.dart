import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_bridge_frontend/user_registration.dart';

import '../Services/shared_preference.dart';

class DrawerContent extends StatefulWidget {
  const DrawerContent({Key? key}) : super(key: key);

  @override
  _DrawerContent createState() => _DrawerContent();
}

class _DrawerContent extends State<DrawerContent> {
  String? storedUid;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await checkUserLoggedIn();
    setState(() {
      storedUid = storedUid;
    });
  }

  Future<void> checkUserLoggedIn() async {
    storedUid = await SharedPreferenceService.getUidFromLocalStorage();
  }

  void logout() async {
    await SharedPreferenceService.saveUidToLocalStorage("");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserRegistration()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
          ),
          SizedBox(height: 10),
          Text("User Id:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25)),
          Text("${storedUid}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
          Divider(thickness: 3, height: 20),
          SizedBox(height: 10),
          Container(
             clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.4)
            ),
            child: ListTile(
              onTap: logout,
              leading: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white54
                ),
                  child: Icon(Icons.logout, color: Colors.black)
              ),
              title: Text("Log out", style: TextStyle(color: Colors.red, fontSize: 22)),
              trailing: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white54
                  ),
                  child: Icon(Icons.navigate_next, color: Colors.black)
              ),
            ),
          )
        ],
      ),
    );
  }
}
