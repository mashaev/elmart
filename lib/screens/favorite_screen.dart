import 'package:elmart/provider/product_provider.dart';
import 'package:elmart/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider prodProv = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: prodProv.hasInternet
          ? Consumer<ProductProvider>(
              builder: (ctx, product, _) => GridView.builder(
                  // controller: _scrollController,
                  itemCount: product.favPosts().length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    return ProductItem(product: product.favPosts()[index]);
                  }),
            )
          : Center(
              child: Column(
                children: [
                  Text('NO INTERNET BRO SORRY'),
                  RaisedButton(
                    child: Text('REtry'),
                    onPressed: () {
                      prodProv.getFavorite();
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
