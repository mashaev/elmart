import 'package:elmart/screens/basket_screen/widget/order_button.dart';
import 'package:elmart/screens/basket_screen/widget/products_list.dart';
import 'package:elmart/screens/drawers_screen/widgets/drawers.dart';
import 'package:flutter/material.dart';

class BasketScreen extends StatelessWidget {
  static const routeName = '/basket';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.backpack),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.pushReplacementNamed(
                //     context, ProductsScreen.routeName);
              }),
        ],
        title: Text('Корзина'),
      ),
      drawer: Drawers(),
      body: Center(
        child: ProductsList(),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: OrderButton(),
      ),
    );
  }
}
