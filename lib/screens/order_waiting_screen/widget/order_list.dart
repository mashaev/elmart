import 'package:elmart/provider/order_provider.dart';
import 'package:elmart/screens/order_waiting_screen/widget/button_delete.dart';
import 'package:elmart/screens/order_waiting_screen/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<OrderProvider>(context, listen: false).getOrders(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return Consumer<OrderProvider>(
            builder: (ctx, provider, _) => ListView.builder(
                  itemCount: provider.orders.length,
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),

                        //  color: Colors.yellow,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              //color: Colors.black,
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey),
                                ),
                              ),
                              child: Text(
                                'Номер заказа №${provider.orders[index]['id']}',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Item(
                              label: 'Фио',
                              value: provider.orders[index]['recipient_name'],
                            ),
                            Item(
                              label: 'Адрес',
                              value: provider.orders[index]
                                  ['recipient_address'],
                            ),
                            Item(
                              label: 'Сумма заказа',
                              value: provider.orders[index]['sum'],
                            ),
                            ButtonDelete(
                              index: index,
                              provider: provider,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
      },
    );
  }
}
