import 'dart:convert';

import 'package:elmart/model/product.dart';
import 'package:elmart/resourses/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';

class ProductProvider with ChangeNotifier {
  List<Product> loadedPost = [];
  List<int> favoriteProduct = [];
  List<int> filterBrand = [];

  int page = 1;
  int perPage = 8;
  int pageCount;
  bool hasInternet = false;
  int totalItem = 0;

  incrementPage() {
    page++;
    getProducts();
  }

  void updateFav(int pid) {
    if (favoriteProduct.contains(pid)) {
      favoriteProduct.remove(pid);
    } else {
      favoriteProduct.add(pid);
      //print('Favorite---${favorites.length} -- $favorites');
    }
    notifyListeners();
  }

  List<Product> favPosts() {
    List<Product> fp = [];
    //print('favs $favorites');
    loadedPost.forEach((upost) {
      if (favoriteProduct.contains(upost.id)) {
        fp.add(upost);
        //print('fav contains ${upost.postId}');
      } else {
        //print('fav NO ${upost.postId}');
      }
    });
    return fp;
  }

  bool checkFav(int pid) {
    if (favoriteProduct.contains(pid)) {
      return true;
    }
    return false;
  }

  Future<void> getFavorite() async {
    // cprint('getProducts page $page');
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      // cprint('getProducts no internet');
      notifyListeners();
      return null;
    }
    String token = session.getString('authKey');
    final url = 'https://khanbuyer.ml/api/user-favorite-products/list';

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      final responseData = json.decode(response.body);
      List resultList = responseData as List;
      resultList.forEach((element) {
        favoriteProduct.add(element['id']);
      });
      cprint('favoriteProduct responseData ${favoriteProduct.length}');

      cprint('getFavorite responseData $responseData');

      notifyListeners();
    } catch (e) {
      print('getFavorite error:  ' + e);
    }
    return null;
  }

  Future<void> getProducts({Map filter}) async {
    cprint('getProducts page $page');
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      cprint('getProducts no internet');
      notifyListeners();
      return null;
    }

    String url =
        'https://khanbuyer.ml/api/products?page=$page&per-page=$perPage';
    if (filter != null && filter.containsKey('brand')) {
      url = url + '&ProductSearch[brand_id]=${filter['brand'][0]}';
    }

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

      cprint('getProducts responseData $responseData');
      List resultList = responseData as List;
      List<Product> products =
          resultList.map((prod) => Product.fromMap(prod)).toList();
      cprint('getProducts products $products');
      if (page > 1) {
        loadedPost.addAll(products);
      } else {
        loadedPost = products;
      }
      Future.delayed(Duration(seconds: 2), () {
        notifyListeners();
      });
    } catch (e) {
      print('getProducts error:  ' + e);
    }
    return null;
  }

  Future<bool> sendFavoriteProduct(int prodId) async {
    cprint('getProducts page $page');
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      cprint('getProducts no internet');
      notifyListeners();
      return null;
    }
    String token = session.getString('authKey');
    final url =
        'https://khanbuyer.ml/api/user-favorite-products/add?product_id=$prodId';
    cprint('token $token and $prodId');
    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      final responseData = json.decode(response.body);
      // response.headers.forEach((name, values) {
      //   if (name == 'x-pagination-page-count') {
      //     pageCount = int.parse(values[0]);
      //   } else if (name == 'x-pagination-total-count') {
      //     totalItem = int.parse(values);
      //   }
      //   //  else if (name == 'x-pagination-current-page') {
      //   //   //xCurrentPage = int.parse(values[0]);
      //   //   //xNextPage = xCurrentPage + 1;
      //   // }
      // });

      cprint('sendFavoriteProduct responseData $responseData');
      // List resultList = responseData as List;
      // List<Product> products =
      //     resultList.map((prod) => Product.fromMap(prod)).toList();
      // cprint('getProducts products $products');
      // loadedPost.addAll(products);
      // Future.delayed(Duration(seconds: 2), () {
      notifyListeners();
      // });
      return true;
    } catch (e) {
      print('getProducts error:  ' + e);
    }
    return false;
  }

  Future<bool> deleteFavoriteProduct(int prodId) async {
    cprint('getProducts page $page');
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      cprint('getProducts no internet');
      notifyListeners();
      return null;
    }
    String token = session.getString('authKey');
    final url =
        'https://khanbuyer.ml/api/user-favorite-products/remove?product_id=$prodId';
    cprint('token $token and $prodId');
    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      final responseData = json.decode(response.body);
      // response.headers.forEach((name, values) {
      //   if (name == 'x-pagination-page-count') {
      //     pageCount = int.parse(values[0]);
      //   } else if (name == 'x-pagination-total-count') {
      //     totalItem = int.parse(values);
      //   }
      //   //  else if (name == 'x-pagination-current-page') {
      //   //   //xCurrentPage = int.parse(values[0]);
      //   //   //xNextPage = xCurrentPage + 1;
      //   // }
      // });

      cprint('deleteFavoriteProduct responseData $responseData');
      // List resultList = responseData as List;
      // List<Product> products =
      //     resultList.map((prod) => Product.fromMap(prod)).toList();
      // cprint('getProducts products $products');
      // loadedPost.addAll(products);
      // Future.delayed(Duration(seconds: 2), () {
      notifyListeners();
      // });
      return true;
    } catch (e) {
      print('getProducts error:  ' + e);
    }
    return false;
  }
}
