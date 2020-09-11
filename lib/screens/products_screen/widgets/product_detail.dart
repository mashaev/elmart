import 'package:elmart/model/product.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  ProductDetails({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.price,
            style: Theme.of(context).textTheme.headline5,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.name,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${product.sizeMin}-${product.sizeMax}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
