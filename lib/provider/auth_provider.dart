import 'dart:convert';
import 'dart:io';

import 'package:elmart/model/user.dart';
import 'package:elmart/resourses/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  int id;
  String name;
  String email;
  String token;

  Future<bool> signup(User user) async {
    const url = 'https://khanbuyer.ml/api/user/register';

    // String basicAuth =
    //     'Basic ' + base64Encode(utf8.encode('${user.email}:${user.password}'));
    // print(basicAuth);

    try {
      final response = await http.post(url, body: {
        'email': user.email,
        'password': user.password,
      });
      final responseData = json.decode(response.body);
      cprint('signup responseData $responseData');
      if (responseData == null) {
        return false;
      }
      id = responseData['id'];
      name = responseData['username'];
      token = responseData['auth_key'];
      email = responseData['email'];
      cprint('RegisterData------${responseData['auth_key']}');
      cprint('RegisterData------${responseData['username']}');
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();

      final data = json.encode({
        'id': id,
        'email': email,
        'name': name,
        'tokenVal': token,
      });

      prefs.setString('userData', data);

      final extractData = json.decode(prefs.getString('userData'));

      cprint('sharedPref------${extractData['tokenVal']}');

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  String get getToken {
    if (token == null) {
      return null;
    }
    return token;
  }

  String get getEmail {
    if (email == null) {
      return null;
    }
    return email;
  }

  Future<bool> signIn(User user) async {
    const url = 'https://khanbuyer.ml/api/user/login';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('${user.email}:${user.password}'));
    print(basicAuth);

    try {
      final response = await http
          .post(url, headers: {HttpHeaders.authorizationHeader: basicAuth});

      final responseData = json.decode(response.body);
      id = responseData['id'];
      name = responseData['username'];
      token = responseData['auth_key'];
      email = responseData['email'];

      cprint('LoginData------${responseData['auth_key']}');
      cprint('LoginData------${responseData['username']}');

      notifyListeners();
      //  final prefs = await SharedPreferences.getInstance();

      final data = json.encode({
        'id': id,
        'email': email,
        'name': name,
        'tokenVal': token,
      });

      session.setString('userData', data);
      final extractData = json.decode(session.getString('userData'));

      cprint('sharedPref------${extractData['tokenVal']}');

      return true;
    } catch (e) {
      cprint('FUCCKK-----------$e');
      print(e);
    }
    return false;
  }

  Future<bool> tryAutoLogin() async {
    // final prefs = await SharedPreferences.getInstance();

    if (!session.containsKey('userData')) {
      return false;
    }

    final extractData = json.decode(session.getString('userData'));
    token = extractData['tokenVal'];
    cprint(
        'tryAutoLogin------ $token-------TRY---- ${extractData['tokenVal']}');
    notifyListeners();

    return true;
  }

  logout() {
    //  final prefs = await SharedPreferences.getInstance();
    token = null;
    session.clear();
    notifyListeners();
  }
}
