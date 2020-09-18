import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:elmart/resourses/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CatalogProvider with ChangeNotifier {
  bool hasInternet = false;
  Map<String, List> catalogs = {
    'winter': [],
    'summer': [],
    'demi': [],
  };

  Future<void> getCatalog({filter}) async {
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      notifyListeners();
      return null;
    }

    try {
      final url = 'https://khanbuyer.ml/api/categories/list?expand=pictures';

      final response = await http.get(
        url,
      );
      final responseData = json.decode(response.body);
      cprint('getCatalog responseData $responseData');
      List winter = [], demi = [], summer = [];

      for (var i = 0; i < responseData.length; i++) {
        var catalog = responseData[i];
        if (catalog['parent_id'] == 1) {
          winter.add(catalog);
        }
        if (catalog['parent_id'] == 2) {
          summer.add(catalog);
        }
        if (catalog['parent_id'] == 3) {
          demi.add(catalog);
        }
      }

      catalogs['winter'] = winter;
      catalogs['summer'] = summer;
      catalogs['demi'] = demi;

      // responseData;
      cprint('getCatalog winter orders ${catalogs['winter'].length}');
      cprint('getCatalog summer orders ${catalogs['summer'].length}');
      cprint('getCatalog demi orders ${catalogs['demi'].length}');

      notifyListeners();
    } catch (e) {
      print('getCatalog error: $e');
    }
    return null;
  }
}
