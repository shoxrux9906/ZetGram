import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<void> saveData(
    String username,
    String password,
    String mail,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
    prefs.setString("password", password);
    prefs.setString("mail", mail);
  }

  static Future<void> savePassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("password", password);
  }

  static Future<bool> isName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("username") != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("username") != null) {
      return prefs.getString("username");
    } else {
      return "Shoxrux Quroqov";
    }
  }

  static Future<bool> isMail(String mail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("mail") != null) {
      if (prefs.getString("mail") == mail) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<bool> isLogin(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("username") != null) {
      if ((prefs.getString("username") == username ||
              prefs.getString("mail") == username) &&
          prefs.getString("password") == password) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<void> clearCache() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
