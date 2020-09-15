import 'package:elmart/provider/order_provider.dart';
import 'package:flutter/material.dart';

class ButtonDelete extends StatelessWidget {
  final OrderProvider provider;
  final int index;

  const ButtonDelete({
    this.index,
    this.provider,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        provider.deleteOrder(provider.orders[index]['id']);
      },
      child: Container(
        // color: Colors.red,

        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10, left: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          color: Colors.red,
          border: Border(
            top: BorderSide(color: Colors.grey),
          ),
        ),
        child: Text('delete'),
      ),
    );
  }
}
