import 'dart:convert';
import 'dart:io';

import 'package:elmart/model/user.dart';
import 'package:elmart/resourses/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String token;

  Future<void> signup(User user) async {
    const url = 'https://khanbuyer.ml/api/user/register';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('${user.email}:${user.password}'));
    print(basicAuth);

    final response = await http
        .post(url, headers: {HttpHeaders.authorizationHeader: basicAuth});
    //token = response.body['auth_key'];
    cprint('json------${response.body}');

    notifyListeners();
  }

  Future<bool> signIn(User user) async {
    const url = 'https://khanbuyer.ml/api/user/login';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('${user.email}:${user.password}'));
    print(basicAuth);

    try {
      final response = await http
          .post(url, headers: {HttpHeaders.authorizationHeader: basicAuth});

      cprint('json------${response.body}');

      notifyListeners();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
