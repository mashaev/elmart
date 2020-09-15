import 'package:elmart/model/product.dart';
import 'package:elmart/resourses/session.dart';
import 'package:flutter/cupertino.dart';

class BasketProvider with ChangeNotifier {
  Map<Product, Map> ordersMap = {};

  addToBasket(Product product, Map amount) {
    if (ordersMap.containsKey(product)) {
      ordersMap.update(product, (value) => value);
    } else {
      ordersMap.putIfAbsent(product, () => amount);
    }

    cprint('amount$amount');
    cprint('amount${ordersMap[product][amount]}');

    notifyListeners();
  }

  deleteFromBasket(Product product) {
    ordersMap.remove(product);
    notifyListeners();
  }

  // int totalProducts() {
  //   int total = 0;
  //   _amount.forEach((key, value) {
  //     total = total + value;
  //   });
  //   return total;
  // }

  double totalPrice() {
    int totalProducts = 0;
    double totalPrice = 0.0;
    ordersMap.forEach((prod, value) {
      value.forEach((key, value) {
        totalProducts = totalProducts + value;
      });

      totalPrice += double.parse(prod.price);
    });

    return totalProducts * totalPrice;
  }
}
