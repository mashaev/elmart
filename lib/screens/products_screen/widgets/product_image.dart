import 'package:elmart/model/product.dart';
import 'package:elmart/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductImage extends StatelessWidget {
  final Product product;

  ProductImage({this.product});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          product.thumbnailPicture,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Consumer<ProductsProvider>(
            builder: (ctx, provider, _) {
              bool isFavorite = provider.checkFav(product.id);
              return GestureDetector(
                child: isFavorite
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(Icons.favorite_border),
                onTap: () async {
                  //     await prodProv.sendFavoriteProduct(product.id);
                  provider.updateFav(product.id);
                  if (provider.checkFav(product.id)) {
                    await provider.sendFavoriteProduct(product.id);
                  } else {
                    await provider.deleteFavoriteProduct(product.id);
                  }
                },
              );
            },
          ),
        )
      ],
    );
  }
}
