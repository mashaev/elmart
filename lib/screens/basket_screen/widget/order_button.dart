import 'package:elmart/provider/basket_provider.dart';
import 'package:elmart/screens/order_screen.dart/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products =
        Provider.of<BasketProvider>(context, listen: true).ordersMap;
    return RaisedButton(
      onPressed: products.length == 0
          ? null
          : () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderScreen()),
              ),
      child: Text(
        'Оформить заказ',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      color: Colors.blue,
      textColor: Colors.white,
    );
  }
}
