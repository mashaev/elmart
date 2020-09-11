import 'package:elmart/provider/products_provider.dart';
import 'package:elmart/resourses/session.dart';
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

  List<Map> pSizes = [
    {'id': 35, 'title': 'minsize 35'},
    {'id': 45, 'title': 'maxsize 45'}
  ];

  // bool selectedItem = false;

  @override
  Widget build(BuildContext context) {
    ProductsProvider prodProv = Provider.of<ProductsProvider>(
      context,
    );
    Map sendFilterData = {
      'brand': prodProv.filterBrand,
      'size': prodProv.filterSize
    };

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

    checkList.add(SizedBox(
      height: 20,
    ));

    pSizes.forEach((size) {
      checkList.add(RadioListTile(
        value: size['id'],
        groupValue: prodProv.filterSize,
        title: Text(size['title']),
        onChanged: (val) {
          cprint('val $val');
          prodProv.setFilterSize(val);
        },
      ));
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
                  prodProv.getProducts(filter: sendFilterData);
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
