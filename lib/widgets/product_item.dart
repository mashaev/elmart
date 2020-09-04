import 'dart:ui';

import 'package:elmart/model/product.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: product.name,
        child: Material(
          child: InkWell(
            onTap: () {},
            child: GridTile(
                footer: Container(
                  color: Colors.black12,
                  child: ListTile(
                    leading: Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                child: Image.network(product.thumbnailPicture)),
          ),
        ),
      ),
    );
  }
}
