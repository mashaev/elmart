import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:elmart/model/product.dart';
import 'package:elmart/resourses/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  bool hasInternet = false;

  Product productItem;
  Map<int, Map<int, int>> amount = {};

  void increaseAmount(int productId, int colorId) {
    if (amount.containsKey(productId)) {
      if (amount[productId].containsKey(colorId)) {
        amount[productId][colorId]++;
      } else {
        amount[productId][colorId] = 1;
      }
    } else {
      amount[productId] = {colorId: 1};
    }
    notifyListeners();
  }

  void dicreaseAmount(int productId, int colorId) {
    if (amount[productId][colorId] > 0) {
      amount[productId][colorId]--;
      notifyListeners();
    }
  }

  Future<void> getProduct(int id) async {
    cprint('getProduct ');
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      // cprint('getProduct no internet');
      notifyListeners();
      return null;
    }
    // String token = session.getString('authKey');
    final url =
        'https://khanbuyer.ml/api/products/$id?expand=colors,pictures,categories';

    try {
      final response = await http.get(
        url,
        //  headers: {'Authorization': 'Bearer $token'},
      );

      final responseData = json.decode(response.body);
      // for (var i = 0; i < responseData['colors'].length; i++) {
      //   amount[responseData['colors'][i]['id']] = 0;
      // }

      productItem = Product.fromMap(responseData);

      // List resultList = responseData as List;
      // resultList.forEach((element) {
      //   favoriteProduct.add(element['id']);
      // });
      //  cprint('getProduct responseData ${favoriteProduct.length}');

      // cprint('getProduct responseData $responseData');

      notifyListeners();
    } catch (e) {
      print('getProduct error:  ' + e);
    }
    return null;
  }
}
