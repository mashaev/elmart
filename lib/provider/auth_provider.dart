import 'dart:convert';

import 'package:elmart/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> signup(User user) async {
    const url = 'https://khanbuyer.ml/api/user/login';

    await http.post(url, body: json.encode(user.toJson()));
    notifyListeners();
  }
}
