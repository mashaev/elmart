import 'package:elmart/model/product.dart';
import 'package:elmart/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modal_body.dart';

class BottomButton extends StatefulWidget {
  final Product product;

  BottomButton({this.product});

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  void _showModalBottomSheet(ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ModalBody(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              height: 60,
              child: RaisedButton(
                child: Text(
                  'ДОБАВИТЬ В КОРЗИНУ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _showModalBottomSheet(context),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Consumer<ProductsProvider>(
              builder: (ctx, provider, _) {
                bool isFavorite = provider.checkFav(widget.product.id);
                return GestureDetector(
                  child: isFavorite
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border),
                  onTap: () async {
                    //     await prodProv.sendFavoriteProduct(product.id);
                    provider.updateFav(widget.product.id);
                    if (provider.checkFav(widget.product.id)) {
                      await provider.sendFavoriteProduct(widget.product.id);
                    } else {
                      await provider.deleteFavoriteProduct(widget.product.id);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
