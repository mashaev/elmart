import 'package:elmart/screens/auth_screen.dart';
import 'package:elmart/screens/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/auth_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: FirstScreen(),
        routes: <String, WidgetBuilder>{
          // '/first': (ctx) => FirstScreen(),
          // '/auth': (ctx) => AuthScreen(),
        },
      ),
    );
  }
}
