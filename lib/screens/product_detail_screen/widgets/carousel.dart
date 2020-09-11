import 'package:carousel_slider/carousel_slider.dart';
import 'package:elmart/model/product.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final Product product;

  Carousel(this.product);

  @override
  State<StatefulWidget> createState() {
    return _CarouselState();
  }
}

class _CarouselState extends State<Carousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    // final picture = widget.product.picture.map((item) => item).toList();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        CarouselSlider(
          items: widget.product.pictures
              .map(
                (url) => Container(
                  child: Center(
                    child: Image.network(
                      url.picture,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            aspectRatio: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.product.pictures.map((url) {
            int index = widget.product.pictures.indexOf(url);
            return Container(
              width: 15.0,
              height: 4.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
