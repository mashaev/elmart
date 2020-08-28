//import 'dart:html';

import 'package:elmart/screens/auth_screen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  static const routeName = '/first';

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Tima'),
              accountEmail: Text('mashaev@mail.ru'),
              onDetailsPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => AuthScreen()));
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
        title: Text('ff'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'j',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
