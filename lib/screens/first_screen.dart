import 'package:elmart/provider/product_provider.dart';
import 'package:elmart/resourses/session.dart';
import 'package:elmart/screens/filter_screen.dart';
import 'package:elmart/screens/second_screen.dart';
import 'package:elmart/widgets/custom_list_tile.dart';
import 'package:elmart/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'favorite_screen.dart';

class FirstScreen extends StatefulWidget {
  static const routeName = '/first';

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  ScrollController _scrollController = ScrollController();
  ProductProvider prodProv;
  // var endOfPage = false;

  // checkInternet() {
  //  // Provider.of<ConnectivityProvider>(context, listen: false).methodCheck();
  //   fetchPost();
  // }
  // Future<bool> check() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.mobile) {
  //     return true;
  //   } else if (connectivityResult == ConnectivityResult.wifi) {
  //     return true;
  //   }
  //   return false;
  // }

  // checkConnection() {
  //   check().then((intenet) {
  //     if (intenet != null && intenet) {
  //       // Internet Present Case
  //       fetchPost();
  //     } else {
  //       setState(() {
  //         offline = true;
  //       });
  //     }

  //     // No-Internet Case
  //   });
  // }

  @override
  void initState() {
    super.initState();
    prodProv = Provider.of<ProductProvider>(context, listen: false);
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
    ProductProvider prodProv = Provider.of<ProductProvider>(
      context,
    );

    //  offline = Provider.of<ConnectivityProvider>(context).offline;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Tima'),
              accountEmail: Text('mashaev@mail.ru'),
              onDetailsPressed: () {
                if (session.containsKey('userId')) {
                  Navigator.of(context).pushNamed(SecondScreen.routeName);
                } else {
                  Navigator.of(context).pushNamed('/auth');
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomListTile(
                Icons.person,
                'Favorite',
                () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (ctxt) => new FavoriteScreen()))
                    }),
            // Row(
            //   children: [
            //     Text('login'),
            //     IconButton(icon: Icon(Icons.login), onPressed: () {}),
            //   ],
            // ),
          ],
        ),
      ),
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
                    crossAxisCount: 2),
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
