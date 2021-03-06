import 'package:elmart/provider/basket_provider.dart';
import 'package:elmart/provider/catalog_provider.dart';
import 'package:elmart/provider/order_provider.dart';
import 'package:elmart/provider/products_provider.dart';
import 'package:elmart/screens/auth_screen/auth_screen.dart';
import 'package:elmart/screens/basket_screen/basket_screen.dart';
import 'package:elmart/screens/drawers_screen/favorite_screen.dart';
import 'package:elmart/screens/order_waiting_screen/order_detail_screen.dart';
import 'package:elmart/screens/product_detail_screen/product_detail_screen.dart';
import 'package:elmart/screens/products_screen/products_screen.dart';
import 'package:elmart/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'provider/auth_provider.dart';
import 'provider/product_provider.dart';
import 'resourses/session.dart';
//import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  session = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
        ChangeNotifierProvider<ProductsProvider>(
            create: (_) => ProductsProvider()),
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()),
        ChangeNotifierProvider<BasketProvider>(create: (_) => BasketProvider()),
        ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
        ChangeNotifierProvider<CatalogProvider>(
            create: (_) => CatalogProvider()),
      ],
      child: MaterialApp(
        title: 'Elmart',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsScreen(),
        routes: {
          SecondScreen.routeName: (ctx) => SecondScreen(),
          ProductsScreen.routeName: (ctx) => ProductsScreen(),

          '/auth': (ctx) => AuthScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          FavoriteScreen.routeName: (ctx) => FavoriteScreen(),
          BasketScreen.routeName: (ctx) => BasketScreen(),
          OrderDetailScreen.routeName: (ctx) => OrderDetailScreen(),
          // '/auth': (ctx) => AuthScreen(),
        },
      ),
    );
  }
}
