import 'dart:ui';

import 'package:elmart/model/product.dart';
import 'package:elmart/screens/product_detail_screen/product_detail_screen.dart';
import 'package:elmart/screens/products_screen/widgets/product_detail.dart';
import 'package:elmart/screens/products_screen/widgets/product_image.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  ProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    // bool isFavorite = false;
    // final prodProv = Provider.of<ProductProvider>(
    //   context,
    // );
    // isFavorite = prodProv.favoriteProduct.contains(product.id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product)));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
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
        child: Column(
          children: [
            Expanded(
              child: ProductImage(product: product),
            ),
            ProductDetails(product: product)
          ],
        ),
      ),
    );
  }
}

//  Card(
//       child: Hero(
//         tag: product.name,
//         child: Material(
//           child: InkWell(
//             onTap: () {},
//             child: GridTile(
//                 header: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     IconButton(
//                       onPressed: () async {
//                         // isFavorite =
//                         //     await prodProv.sendFavoriteProduct(product.id);
//                         prodProv.updateFav(product.id);
//                         if (prodProv.checkFav(product.id)) {
//                           await prodProv.sendFavoriteProduct(product.id);
//                         } else {
//                           await prodProv.deleteFavoriteProduct(product.id);
//                         }
//                       },
//                       icon: Icon(prodProv.checkFav(product.id)
//                           ? Icons.favorite
//                           : Icons.favorite_border_outlined),
//                     ),
//                   ],
//                 ),
//                 footer: Container(
//                   color: Colors.black12,
//                   child: ListTile(
//                     ///isThreeLine: true,
//                     leading: Text(
//                       product.name,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       product.price,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//                 child: Image.network(product.thumbnailPicture)),
//           ),
//         ),
//       ),
//     );
