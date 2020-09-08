import 'dart:ui';

import 'package:elmart/model/product.dart';
import 'package:elmart/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    // bool isFavorite = false;
    final prodProv = Provider.of<ProductProvider>(
      context,
    );
    // isFavorite = prodProv.favoriteProduct.contains(product.id);
    return Card(
      child: Hero(
        tag: product.name,
        child: Material(
          child: InkWell(
            onTap: () {},
            child: GridTile(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () async {
                        // isFavorite =
                        //     await prodProv.sendFavoriteProduct(product.id);
                        prodProv.updateFav(product.id);
                        if (prodProv.checkFav(product.id)) {
                          await prodProv.sendFavoriteProduct(product.id);
                        } else {
                          await prodProv.deleteFavoriteProduct(product.id);
                        }
                      },
                      icon: Icon(prodProv.checkFav(product.id)
                          ? Icons.favorite
                          : Icons.favorite_border_outlined),
                    ),
                  ],
                ),
                footer: Container(
                  color: Colors.black12,
                  child: ListTile(
                    leading: Text(
                      product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      product.price,
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
