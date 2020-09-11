import 'package:elmart/provider/products_provider.dart';
import 'package:elmart/screens/products_screen/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    ProductsProvider prodProv = Provider.of<ProductsProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: prodProv.hasInternet
          ? Consumer<ProductsProvider>(
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
