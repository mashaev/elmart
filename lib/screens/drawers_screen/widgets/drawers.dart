import 'package:elmart/provider/products_provider.dart';
import 'package:elmart/resourses/session.dart';
import 'package:elmart/screens/basket_screen/basket_screen.dart';
import 'package:elmart/screens/catalog_screen/catalog_screen.dart';
import 'package:elmart/screens/drawers_screen/favorite_screen.dart';
import 'package:elmart/screens/order_waiting_screen/order_waiting_screen.dart';
import 'package:elmart/screens/products_screen/products_screen.dart';
import 'package:elmart/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_list_tile.dart';

class Drawers extends StatelessWidget {
  const Drawers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          Consumer<ProductsProvider>(
            builder: (ctx, provider, _) => CustomListTile(
                Icons.portrait_rounded,
                'Product',
                () => {
                      // Navigator.pop(context),
                      provider.page = 1,
                      provider.getProducts(),
                      //Future.delayed(Duration(seconds: 1), () {
                      // Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (ctxt) => new ProductsScreen())),
                      // }
                      // )
                    }),
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
          SizedBox(
            height: 20,
          ),
          CustomListTile(
              Icons.shopping_basket,
              'Basket',
              () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (ctxt) => new BasketScreen()))
                  }),
          SizedBox(
            height: 20,
          ),
          CustomListTile(
              Icons.online_prediction_sharp,
              'Заказы',
              () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (ctxt) => new OrderWaitingScreen()))
                  }),
          SizedBox(
            height: 20,
          ),
          CustomListTile(
              Icons.cake,
              'Каталог',
              () => {
                    Navigator.pop(context),
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (ctxt) => new CatalogScreen()),
                    ),
                  }),
          // Row(
          //   children: [
          //     Text('login'),
          //     IconButton(icon: Icon(Icons.login), onPressed: () {}),
          //   ],
          // ),
        ],
      ),
    );
  }
}
