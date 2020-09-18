import 'package:elmart/provider/catalog_provider.dart';
import 'package:elmart/screens/catalog_screen/widget/catalog_list.dart';
import 'package:elmart/screens/drawers_screen/widgets/drawers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        drawer: Drawers(),
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.backpack),
                onPressed: () {
                  Provider.of<CatalogProvider>(context, listen: false)
                      .getCatalog();
                }),
          ],
          title: Text('Catalog'),
          bottom: TabBar(tabs: <Widget>[
            Text('Зима'),
            Text('Лето'),
            Text('Деми'),
          ]),
        ),
        body: TabBarView(children: <Widget>[
          CatalogList('winter'),
          CatalogList('summer'),
          CatalogList('demi'),
        ]),
      ),
    );
  }
}
