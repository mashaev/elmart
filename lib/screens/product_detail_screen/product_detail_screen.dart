import 'package:elmart/model/product.dart';
import 'package:elmart/provider/product_provider.dart';
import 'package:elmart/screens/product_detail_screen/widgets/bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/carousel.dart';
import 'widgets/item_info.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({this.product});

  static const routeName = '/product';

  @override
  Widget build(BuildContext context) {
    // final product = ModalRoute.of(context).settings.arguments;
    final pp = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: FutureBuilder(
          future: pp.getProduct(product.id),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Carousel(pp.productItem),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        iconTheme: IconThemeData(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(
                      pp.productItem.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(pp.productItem.fabricStructure),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      pp.productItem.price,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      'В наличии',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    trailing: CircleAvatar(
                      child: Text('${pp.productItem.inStock}'),
                    ),
                  ),
                  Divider(),
                  ListTile(
                      title: Text(
                    'О товаре',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                  Column(
                    children: [
                      ItemInfo(
                        label: 'Артикул',
                        value: pp.productItem.itemCode,
                      ),
                      ItemInfo(
                        label: 'Минимальный размер',
                        value: pp.productItem.sizeMin,
                      ),
                      ItemInfo(
                        label: 'Максимальный размер',
                        value: pp.productItem.sizeMax,
                      ),
                      ItemInfo(
                        label: 'Состав',
                        value: pp.productItem.fabricStructure,
                      ),
                      ItemInfo(
                        label: 'Параметры модели',
                        value: pp.productItem.fashionModelParams,
                      ),
                      ItemInfo(
                        label: 'Рост модели на фото',
                        value: pp.productItem.fashionModelHeight,
                      ),
                      ItemInfo(
                        label: 'Длина',
                        value: pp.productItem.length,
                      ),
                      ItemInfo(
                        label: 'Длина рукава',
                        value: pp.productItem.sleeveLength,
                      ),
                      ItemInfo(
                        label: 'Размер товара на модели',
                        value: pp.productItem.sizeOnFashionModel,
                      ),
                      ItemInfo(
                        label: 'Размер товара на модели',
                        value: pp.productItem.sizeOnFashionModel,
                      ),
                      ItemInfo(
                        label: 'Сезон',
                        // value: season[pp.product['seasonality']],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: BottomButton(
        product: product,
      ),
    );
  }
}
