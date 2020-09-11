import 'package:elmart/provider/basket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bp = Provider.of<BasketProvider>(context, listen: true);
    Map<int, List> colorMap = {};
    bp.ordersMap.forEach((prod, map) {
      List<Widget> contColor = [];
      prod.colors
          .where((color) => (color.id != 0 && map.containsKey(color.id)))
          .map((c) => contColor.add(
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,
                                  ),
                                ],
                                color: Color(
                                  int.parse('0xFF${c.code.substring(1)}'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(c.name),
                            )
                          ],
                        ),
                      ]),
                ),
              ))
          .toList();
      colorMap[prod.id] = contColor;
    });

    //  ...products[i]['colors']
    //     .where((c) => c['amount'] != 0)
    //     .map(
    //       (c) => Container(
    //         padding: const EdgeInsets.only(top: 5),
    //         child: Row(
    //           mainAxisAlignment:
    //               MainAxisAlignment.spaceBetween,
    //           children: [
    //             Row(
    //               children: [
    //                 Container(
    //                   width: 20,
    //                   height: 20,
    //                   decoration: BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Colors.grey,
    //                         blurRadius: 2,
    //                       ),
    //                     ],
    //                     color: Color(
    //                       int.parse(
    //                           '0xFF${c['code'].substring(1)}'),
    //                     ),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding:
    //                       const EdgeInsets.only(left: 10),
    //                   child: Text(c['name']),
    //                 )
    //               ],
    //             ),
    //             Text(c['amount'].toString())
    //           ],
    //         ),
    //       ),
    //     )
    //     .toList();

    List<Widget> prodList = [];
    bp.ordersMap.forEach((prod, amnt) {
      Widget myCont = Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Image.network(
                prod.thumbnailPicture,
                // Config.baseUrl + products[i]['thumbnailPicture'],
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Text(
                        prod.name,
                        // products[i]['name'],
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    ...colorMap[prod.id],

                    ///
                    ///////
                    //////

                    ///////
                    //////
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Общая сумма:'),
                          Expanded(child: Text(bp.totalPrice().toString()))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.redAccent,
                        child: Text('Удалить'),
                        onPressed: () {
                          bp.deleteFromBasket(prod);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
      prodList.add(myCont);
    });

    return ListView(
      padding: const EdgeInsets.all(15),
      children: prodList,
    );
  }
}
