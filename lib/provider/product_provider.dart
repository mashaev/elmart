import 'dart:convert';

import 'package:elmart/model/product.dart';
import 'package:elmart/resourses/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';

class ProductProvider with ChangeNotifier {
  List<Product> loadedPost = [];

  int page = 1;
  int perPage = 8;
  int pageCount;
  bool hasInternet = false;
  int totalItem = 0;

  incrementPage() {
    page++;
    getProduct();
  }

  Future<void> getProduct() async {
    cprint('getProduct page $page');
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      cprint('getProduct no internet');
      notifyListeners();
      return null;
    }

    final url =
        'https://khanbuyer.ml/api/products?page=$page&per-page=$perPage';

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      response.headers.forEach((name, values) {
        if (name == 'x-pagination-page-count') {
          pageCount = int.parse(values[0]);
        } else if (name == 'x-pagination-total-count') {
          totalItem = int.parse(values);
        }
        //  else if (name == 'x-pagination-current-page') {
        //   //xCurrentPage = int.parse(values[0]);
        //   //xNextPage = xCurrentPage + 1;
        // }
      });

      cprint('getProduct responseData $responseData');
      List resultList = responseData as List;
      List<Product> products =
          resultList.map((prod) => Product.fromMap(prod)).toList();
      cprint('getProduct products $products');
      loadedPost.addAll(products);
      Future.delayed(Duration(seconds: 2), () {
        notifyListeners();
      });
    } catch (e) {
      print('getProduct error:  ' + e);
    }
    return null;
  }
}
