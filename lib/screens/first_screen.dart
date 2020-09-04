//import 'dart:html';

import 'dart:async';

import 'package:elmart/model/product.dart';
import 'package:elmart/provider/product_provider.dart';
import 'package:elmart/resourses/session.dart';
import 'package:elmart/screens/second_screen.dart';
import 'package:elmart/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatefulWidget {
  static const routeName = '/first';

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  ScrollController _scrollController = ScrollController();
  Products prodProv;

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
    prodProv = Provider.of<Products>(context, listen: false);
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
    prodProv.getProduct();
    // setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Products prodProv = Provider.of<Products>(
      context,
    );

    //  offline = Provider.of<ConnectivityProvider>(context).offline;

    return Scaffold(
      drawer: Drawer(
        child: Column(
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
        // actions: [
        //   RaisedButton(
        //       child: Text('getProdc'),
        //       onPressed: () {
        //         fetchPost();
        //       })
        // ],
        title: Text('ff'),
      ),
      body: RefreshIndicator(
        onRefresh: prodProv.getProduct,
        child: prodProv.hasInternet
            ? GridView.builder(
                controller: _scrollController,
                itemCount: prodProv.loadedPost.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (ctx, index) {
                  return ProductItem(product: prodProv.loadedPost[index]);
                })
            : Center(
                child: Column(
                  children: [
                    Text('NO INTERNET BRO SORRY'),
                    RaisedButton(
                      child: Text('REtry'),
                      onPressed: () {
                        prodProv.getProduct();
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
