//import 'dart:html';

import 'package:elmart/provider/auth_provider.dart';
import 'package:elmart/resourses/session.dart';
import 'package:elmart/screens/auth_screen.dart';
import 'package:elmart/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                if (session.containsKey('userId')) {
                  Navigator.of(context).pushNamed(SecondScreen.routeName);
                } else {
                  Navigator.of(context).pushNamed('/auth');
                }
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
