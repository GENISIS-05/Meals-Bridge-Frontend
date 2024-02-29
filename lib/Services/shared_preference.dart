
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
// Function to save UID to local storage
  static Future<void> saveUidToLocalStorage(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
  }

// Function to retrieve UID from local storage
  static Future<String?> getUidFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  // Function to save list of nearby UIDs to local storage
  static Future<void> saveNearbyUidsToLocalStorage(List<String> nearbyUids) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('nearbyUids', nearbyUids);
  }

  // Function to retrieve list of nearby UIDs from local storage
  static Future<List<String>> getNearbyUidsFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('nearbyUids') ?? [];
  }

  static Future<void> clearUidData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('nearbyUids');
  }
}
