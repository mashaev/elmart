import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:elmart/resourses/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  bool hasInternet = false;

  List orders = [];
  Map order = {};

  Future<void> makeOrder(contactData, orderBasket) async {
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      notifyListeners();
      return null;
    }
    String token = session.getString('authKey');
    List queries = [
      'order[recipient_name]=${contactData['name']}',
      'order[recipient_address]=${contactData['address']}',
      'order[recipient_phone_number]=${contactData['phoneNumber']}',
    ];

    int itemIndex = 0;

    orderBasket.forEach((prod, map) {
      map.forEach((colorId, value) {
        int qty = value;
        queries.add('order[items][$itemIndex][product_id]=${prod.id}');
        queries.add('order[items][$itemIndex][color_id]=$colorId');
        queries.add('order[items][$itemIndex][quantity]=$qty');
        itemIndex++;
      });
    });
    try {
      final url = 'https://khanbuyer.ml/api/orders/add?${queries.join('&')}';
      cprint('url $url');
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      final responseData = json.decode(response.body);
      // List resultList = responseData as List;
      // resultList.forEach((element) {
      //   favoriteProduct.add(element['id']);
      // });

      cprint('makeOrder responseData $responseData');

      notifyListeners();
    } catch (e) {
      print('makeOrder error: $e');
    }
    return null;
  }

  Future<void> getOrders() async {
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      notifyListeners();
      return null;
    }
    String token = session.getString('authKey');

    try {
      final url = 'https://khanbuyer.ml/api/orders/list';
      // cprint('url $url');
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      final responseData = json.decode(response.body);
      // List resultList = responseData as List;
      // resultList.forEach((element) {
      //   favoriteProduct.add(element['id']);
      // });
      cprint('getOrders responseData $responseData');
      orders = responseData;
      cprint('getOrders orders ${orders.length}');

      notifyListeners();
    } catch (e) {
      print('getOrders error: $e');
    }
    return null;
  }

  Future<void> deleteOrder(int id) async {
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      notifyListeners();
      return null;
    }
    String token = session.getString('authKey');

    try {
      final url = 'https://khanbuyer.ml/api/orders/remove?order_id=$id';
      // cprint('url $url');
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      final responseData = json.decode(response.body);
      // List resultList = responseData as List;
      // resultList.forEach((element) {
      //   favoriteProduct.add(element['id']);
      // });
      cprint('deleteOrder responseData $responseData');
      if (responseData['success']) {
        orders.forEach((element) {
          if (element['id'] == id) {
            orders.remove(element);
            notifyListeners();
          }
        });
        // orders.remove(orders[id]);
        notifyListeners();
      }
      //orders = responseData;
      // cprint('deleteOrder orders ${orders}');

      notifyListeners();
    } catch (e) {
      print('deleteOrder error: $e');
    }
    return null;
  }

  Future<void> getOrder(int id) async {
    cprint('id $id');
    hasInternet = await DataConnectionChecker().hasConnection;
    if (!hasInternet) {
      notifyListeners();
      return null;
    }
    String token = session.getString('authKey');

    try {
      final url = 'https://khanbuyer.ml/api/orders/$id?expand=items';
      // cprint('url $url');
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );
      final responseData = json.decode(response.body);
      // List resultList = responseData as List;
      // resultList.forEach((element) {
      //   favoriteProduct.add(element['id']);
      // });
      // cprint('getOrder responseData $responseData');

      order = responseData;
      cprint('deleteOrder orders ${order.length}');

      notifyListeners();
    } catch (e) {
      print('getOrder error: $e');
    }
    return null;
  }
}
