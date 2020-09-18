import 'package:elmart/provider/order_provider.dart';
import 'package:elmart/screens/order_waiting_screen/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatelessWidget {
  final int id;
  OrderDetailScreen({this.id});

  static const routeName = '/order-detail-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('detail'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrderProvider>(context, listen: false).getOrder(id),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Consumer<OrderProvider>(builder: (ctx, provider, _) {
            final orderItem = provider.order;

            return Container(
              padding: EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),

              //  color: Colors.yellow,
              height: 200,
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
                // mainAxisAlignment: MainAxisAlignment.start,
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
                      // 'hgh',
                      'Номер заказа №${orderItem['id']}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Item(
                    label: 'Фио',
                    value: orderItem['recipient_name'],
                  ),
                  Item(
                    label: 'Адрес',
                    value: orderItem['recipient_address'],
                  ),
                  Item(
                    label: 'Сумма заказа',
                    value: orderItem['sum'],
                  ),
                  // ButtonDelete(
                  //   index: index,
                  //   provider: provider,
                  // ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
