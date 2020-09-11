import 'package:elmart/provider/products_provider.dart';
import 'package:elmart/resourses/session.dart';
import 'package:elmart/screens/filter_screen.dart';
import 'package:elmart/screens/products_screen/widgets/product_item.dart';
import 'package:elmart/screens/drawers_screen/widgets/drawers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = '/first';

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<ProductsScreen> {
  ScrollController _scrollController = ScrollController();
  ProductsProvider prodProv;

  @override
  void initState() {
    super.initState();
    prodProv = Provider.of<ProductsProvider>(context, listen: false);
    // checkInternet();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //print('-------end reached--------');
        if (prodProv.pageCount != null && prodProv.page < prodProv.pageCount) {
          prodProv.incrementPage();
        }
      }
    });
    prodProv.getProducts();
    prodProv.getFavorite();
    // setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    final double aspectRatio = itemWidth / itemHeight;

    ProductsProvider prodProv = Provider.of<ProductsProvider>(
      context,
    );

    return Scaffold(
      drawer: Drawers(),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.filter),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => FilterScreen()));
              }),
        ],
        title: Text('ff'),
      ),
      body: RefreshIndicator(
        onRefresh: prodProv.getProducts,
        child: prodProv.hasInternet
            ? GridView.builder(
                controller: _scrollController,
                itemCount: prodProv.loadedPost.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: aspectRatio,
                ),
                itemBuilder: (ctx, index) {
                  // cprint('index-----$index');
                  if (prodProv.totalItem == index) {
                    cprint('no more itemData');
                    return Center(
                      child: Text('no more itemData bro'),
                    );
                  }

                  if (index <= prodProv.loadedPost.length - 1) {
                    // cprint('Total itemData ${prodProv.totalItem}');
                    // cprint(
                    //     'Total Loaded itemData ${prodProv.loadedPost.length}');
                    return ProductItem(product: prodProv.loadedPost[index]);
                  }
                  if (index == prodProv.loadedPost.length) {
                    return SpinKitThreeBounce(
                      color: Colors.black,
                      size: 35.0,
                    );
                  } else {
                    return Center(
                      child: Text('no more item tima'),
                    );
                  }
                })
            : Center(
                child: Column(
                  children: [
                    Text('NO INTERNET BRO SORRY'),
                    RaisedButton(
                      child: Text('REtry'),
                      onPressed: () {
                        prodProv.getProducts();
                      },
                    ),
                  ],
                ),
              ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
