import 'package:elmart/provider/auth_provider.dart';
import 'package:elmart/screens/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key key}) : super(key: key);

  static const routeName = '/second';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => FirstScreen()));
              }),
        ],
        title: Text('I am here'),
      ),
      body: Center(
        child: Text('I am Done'),
      ),
    );
  }
}
