import 'package:elmart/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_product_to_basket.dart';

class ModalBody extends StatelessWidget {
  // final Product product;

  // ModalBody({this.product});

  @override
  Widget build(BuildContext context) {
    final pp = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                            ),
                          ],
                          color: Color(
                            int.parse(
                                '0xFF${pp.productItem.colors[i].code.substring(1)}'),
                            // int.parse(
                            //     '0xFF${product['colors'][i]['code'].substring(1)}'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          pp.productItem.colors[i].name,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          pp.dicreaseAmount(
                              pp.productItem.id, pp.productItem.colors[i].id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.transparent,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          child: Text(
                            '-',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Consumer<ProductProvider>(
                          builder: (_, provider, w) {
                            int prodId = provider.productItem.id;
                            int colorId = provider.productItem.colors[i].id;
                            int amnt = 0;
                            if (provider.amount.containsKey(prodId) &&
                                provider.amount[prodId].containsKey(colorId)) {
                              amnt = provider.amount[prodId][colorId];
                            }
                            return Text(
                              amnt.toString(),
                              style: TextStyle(fontSize: 18),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          pp.increaseAmount(
                              pp.productItem.id, pp.productItem.colors[i].id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Divider(),
            ],
          ),
          itemCount: pp.productItem.colors.length,
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AddProductToBasket(),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 30),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Всего: ',
          //             style: Theme.of(context).textTheme.headline5,
          //           ),
          //           Consumer<ProductProvider>(
          //             builder: (_, provider, k) {
          //            final quantity = provider.totalProducts();
          //               String text = '';
          //               if (quantity == 0 || quantity > 4) {
          //                 text = 'линеек';
          //               } else if (quantity == 1) {
          //                 text = 'линейка';
          //               } else {
          //                 text = 'линейки';
          //               }
          //               return Text(
          //                 '$quantity $text',
          //                 style: Theme.of(context).textTheme.headline5,
          //               );
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 30,
          //         vertical: 10,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Сумма: ',
          //             style: Theme.of(context).textTheme.headline5,
          //           ),
          //           Consumer<ProductProvider>(
          //             builder: (_, provider, i) => Text(
          //               '${provider.totalPrice()}',
          //               style: Theme.of(context).textTheme.headline5,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
        ],
      ),
    );
  }
}
