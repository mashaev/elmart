import 'package:elmart/provider/basket_provider.dart';
import 'package:elmart/provider/product_provider.dart';
import 'package:elmart/screens/basket_screen/basket_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductToBasket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<ProductProvider>(context, listen: true);
    return Container(
      width: double.infinity,
      height: 60,
      child: Consumer<BasketProvider>(
        builder: (ctx, provider, _) {
          return RaisedButton(
            child: Text(
              'Добавить в корзину',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              // var id = pp.amount.containsKey(pp.productItem.id);
              provider.addToBasket(
                  pp.productItem, pp.amount[pp.productItem.id]);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BasketScreen()));
            },
            // pp.totalProducts() == 0
            //     ? null
            //     : () => provider.addProduct(product),
            color: Colors.blue,
            textColor: Colors.white,
          );

          //  final product = pp.getProductDetails();
          // final productsInBasket =
          // provider.products.map((p) => p['id']).toList();
          // bool isAdded = productsInBasket.contains(product['id']);

          // if (isAdded) {
          //   return RaisedButton(
          //     child: Text(
          //       'Добавлено в корзину',
          //       style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     onPressed: () {
          //     //  Get.offAll(BasketScreen());
          //     },
          //     color: Colors.blue,
          //     textColor: Colors.white,
          //   );
          // } else {
          //   return RaisedButton(
          //     child: Text(
          //       'Добавить в корзину',
          //       style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     onPressed: pp.totalProducts() == 0
          //         ? null
          //         : () => provider.addProduct(product),
          //     color: Colors.blue,
          //     textColor: Colors.white,
          //   );
          // }
        },
      ),
    );
  }
}
