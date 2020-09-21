import 'package:flutter/material.dart';

class CatalogItem extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;

  CatalogItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      // padding: Ed,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 10,
                bottom: 10,
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Image.network(
              'https://khanbuyer.ml' + imageUrl,
              height: 120,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
