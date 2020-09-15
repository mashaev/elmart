import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String label;
  final value;

  Item({this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text('$label'),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '$value',
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
