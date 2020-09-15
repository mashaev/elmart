import 'package:elmart/provider/order_provider.dart';
import 'package:elmart/screens/drawers_screen/widgets/drawers.dart';
import 'package:elmart/screens/order_waiting_screen/widget/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderWaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('заказы'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Provider.of<OrderProvider>(context, listen: false).getOrders();
              }),
        ],
      ),
      drawer: Drawers(),
      body: OrderList(),
    );
  }
}
