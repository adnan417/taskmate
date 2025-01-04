import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _prefs;

  //call this method from initState() function of mainApp()
  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    print('Static Cache Initialized');
    return _prefs;
  }

  //Sets
  static Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  //Gets
  static Future<List<String>?> getStringList(String key) async {
    return _prefs.getStringList(key);
  }
}
