import 'dart:convert';

import 'package:elmart/model/product.dart';
import 'package:elmart/resourses/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> loadedPost = [];
  List<int> favoriteProduct = [];
  List<int> filterBrand = [];
  int filterSize;
  int filterCategory;

  int page = 1;
  int perPage = 8;
  int pageCount;
  bool hasInternet = false;
  bool isLoading = false;
  int totalItem = 0;

  incrementPage() {
    page++;
    getProducts();
  }

  void setFilterSize(int size) {
    filterSize = size;
    notifyListeners();
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
      // cprint('favoriteProduct responseData ${favoriteProduct.length}');

      cprint('getFavorite responseData $responseData');

      notifyListeners();
    } catch (e) {
      print('getFavorite error:  $e');
    }
    return null;
  }

  void clearFilter({bool notif = false}) {
    filterBrand = [];
    filterCategory = null;
    filterSize = null;
    if (notif) {
      Future.delayed(Duration.zero, () async {
        notifyListeners();
      });
    }
  }

  Future<void> getProducts() async {
    cprint('getProducts filterCategory $filterCategory');
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      cprint('getProducts no internet');
      notifyListeners();
      return null;
    }
    isLoading = true;
    // notifyListeners();
    String url =
        'https://khanbuyer.ml/api/products?page=$page&per-page=$perPage';
    if (filterBrand.isNotEmpty) {
      isLoading = true;
      notifyListeners();
      url = url + '&ProductSearch[brand_id]=${filterBrand[0]}';
    }
    if (filterSize != null) {
      isLoading = true;
      notifyListeners();
      url = url + '&ProductSearch[size_minimum]=$filterSize';
    }
    if (filterCategory != null) {
      isLoading = true;
      notifyListeners();
      url = url + '&ProductSearch[category_id]=$filterCategory';
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
      });

      // cprint('getProducts responseData $responseData');
      List resultList = responseData as List;
      List<Product> products =
          resultList.map((prod) => Product.fromMap(prod)).toList();
      // cprint('getProducts products $products');
      if (page > 1) {
        // isLoading = false;
        // notifyListeners();
        loadedPost.addAll(products);
      } else {
        // isLoading = false;
        // notifyListeners();
        loadedPost = products;
      }
      Future.delayed(Duration(seconds: 2), () {
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print('getProducts error:  $e');
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
