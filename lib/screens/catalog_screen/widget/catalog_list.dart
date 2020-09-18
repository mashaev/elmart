import 'package:elmart/provider/catalog_provider.dart';
import 'package:elmart/provider/products_provider.dart';
import 'package:elmart/screens/catalog_screen/widget/catalog_item.dart';
import 'package:elmart/screens/products_screen/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CatalogList extends StatelessWidget {
  final String name;

  CatalogList(this.name);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CatalogProvider>(context, listen: false);
    final productsP = Provider.of<ProductsProvider>(context, listen: false);
    return FutureBuilder(
        future: provider.getCatalog(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: provider.catalogs[name].length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  productsP.filterCategory =
                      provider.catalogs[name][index]['id'];
                  productsP.page = 1;
                  productsP.getProducts();
                  //Navigator.pushNamed(context, ProductsScreen.routeName);
                  // .then((value) => Navigator.pop(context));
                  Navigator.pop(context);
                },
                child: CatalogItem(
                  id: provider.catalogs[name][index]['id'],
                  title: provider.catalogs[name][index]['title'],
                  imageUrl: provider.catalogs[name][index]['pictures'][0]
                      ['thumbnailPicture'],
                ),
              );
            },
          );
        });
  }
}
