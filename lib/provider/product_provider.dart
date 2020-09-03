import 'dart:convert';

import 'package:elmart/model/product.dart';
import 'package:elmart/resourses/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _loadedPost = [];

  List<Product> get loadedPost {
    return [..._loadedPost];
  }

  Future<void> getProduct() async {
    const url = 'https://khanbuyer.ml/api/products?page=1&?per-page=12';

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      cprint('getProduct responseData $responseData');
      List resultList = responseData as List;
      List<Product> products =
          resultList.map((prod) => Product.fromMap(prod)).toList();
      cprint('getProduct products $products');
      _loadedPost = products;
      notifyListeners();

      // return true;
    } catch (e) {
      print('getProduct error:  ' + e);
    }
    return null;
  }
}
