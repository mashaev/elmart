import 'package:elmart/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<Map> brands = [
    {'id': 1, 'title': 'Alexandria'},
    {'id': 2, 'title': 'Dilbar'}
  ];

  @override
  Widget build(BuildContext context) {
    ProductProvider prodProv = Provider.of<ProductProvider>(
      context,
    );

    List<Widget> checkList = [];
    brands.forEach((bmap) {
      checkList.add(CheckboxListTile(
          value: prodProv.filterBrand.contains(bmap['id']),
          title: new Text(bmap['title']),
          controlAffinity: ListTileControlAffinity.leading,
          onChanged: (bool val) {
            if (val) {
              prodProv.filterBrand.add(bmap['id']);
            } else {
              prodProv.filterBrand.remove(bmap['id']);
            }
            setState(() {});
          }));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: Stack(
        children: [
          new Container(
            padding: new EdgeInsets.all(10.0),
            child: new Column(
              children: checkList,
            ),
          ),
          Align(
              child: RaisedButton(
                child: Text('Send'),
                onPressed: () {
                  prodProv.page = 1;
                  prodProv.getProducts(filter: {'brand': prodProv.filterBrand});
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pop();
                  });
                },
              ),
              alignment: Alignment.bottomCenter),
        ],
      ),
    );
  }
}
