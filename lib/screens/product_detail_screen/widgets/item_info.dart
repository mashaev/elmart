import 'package:flutter/material.dart';

class ItemInfo extends StatelessWidget {
  final String label;
  final value;

  ItemInfo({this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 10,
        left: 15,
      ),
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          children: [
            TextSpan(text: '$label: '),
            TextSpan(
              text: '$value',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
