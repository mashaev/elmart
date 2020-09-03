//import 'dart:html';
import 'dart:math';

import 'package:elmart/model/user.dart';
import 'package:elmart/provider/auth_provider.dart';
import 'package:elmart/resourses/session.dart';
import 'package:elmart/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login, Reset, Code }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      appBar: AppBar(
          // actions: [
          //   IconButton(
          //       icon: Icon(Icons.backup),
          //       onPressed: () {
          //         Navigator.of(context).pop();
          //       })
          // ],
          ),
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      // ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'ElmartShop',
                        style: TextStyle(
                          color: Theme.of(context).accentTextTheme.title.color,
                          fontSize: 28,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    //'name': '',
    'email': '',
    'password': '',
  };

  int codeNumber;
  // User user =User(_authData['']);
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final TextEditingController _codeTC = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return false;
    }
    _formKey.currentState.save();
    // setState(() {
    //   _isLoading = true;
    // });
    if (_authMode == AuthMode.Login) {
      // Log user in
      bool signIn = await Provider.of<Auth>(context, listen: false).signIn(
        User(
          email: _authData['email'],
          password: _authData['password'],
        ),
      );

      if (signIn) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => SecondScreen()));
      }
    } else if (_authMode == AuthMode.Reset) {
      //reset button press
      bool changePwd =
          await Provider.of<Auth>(context, listen: false).changePassword(
        User(
          email: _authData['email'],
        ),
      );
      if (changePwd) {
        _codeTC.clear();
        setState(() {
          // changePwd = false;
          _authMode = AuthMode.Code;

          // changePwd = false;
        });

        // changePwd = false;

        cprint('EMAIL IS EXISTS IN SERVER BROOOOOO');
      }
    } else {
      // Sign user up
      bool register = await Provider.of<Auth>(context, listen: false).signup(
        User(
          email: _authData['email'],
          password: _authData['password'],
        ),
      );

      if (register) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => SecondScreen()));
        cprint('IF BLOC SIGN UP-----------');
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => AuthScreen()));
        cprint('ELSE BLOC SIGN UP-----------');
      }
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void _switchChangePassword() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Reset;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void _switchCode() {
    if (_authMode == AuthMode.Code) {
      setState(() {
        _authMode = AuthMode.Reset;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Code;
      });
    }
  }

  Column textFieldSignIn() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'E-Mail'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value.isEmpty || !value.contains('@')) {
              return 'Invalid email!';
            }
          },
          onSaved: (value) {
            _authData['email'] = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
          controller: _passwordController,
          validator: (value) {
            if (value.isEmpty || value.length < 5) {
              return 'Password is too short!';
            }
          },
          onSaved: (value) {
            _authData['password'] = value;
          },
        ),
        if (_authMode == AuthMode.Signup)
          TextFormField(
            enabled: _authMode == AuthMode.Signup,
            decoration: InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
            validator: _authMode == AuthMode.Signup
                ? (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match!';
                    }
                  }
                : null,
          ),
        buttonSignIn(),
      ],
    );
  }

  textFieldReset() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value.isEmpty) {
              return 'Invalid name!';
            }
          },
          onSaved: (value) {
            _authData['email'] = value;
          },
        ),
        RaisedButton(
          child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'Reset'),
          onPressed: _submit,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).primaryTextTheme.button.color,
        ),
        FlatButton(
          child: Text(
              '${_authMode == AuthMode.Reset ? 'Back to login' : 'login'} '),
          onPressed: _switchChangePassword,
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  textFieldCode() {
    return Column(
      children: [
        TextFormField(
          controller: _codeTC,
          decoration: InputDecoration(labelText: 'Code'),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value.isEmpty || value.length < 5) {
              return 'Invalid code!';
            }
          },
          onSaved: (value) {
            codeNumber = int.parse(value);
          },
        ),
        RaisedButton(
          child: Text(_authMode == AuthMode.Code ? 'Code' : 'Reset'),
          onPressed: _submit,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).primaryTextTheme.button.color,
        ),
        FlatButton(
          child:
              Text('${_authMode == AuthMode.Code ? 'Back to Email' : 'Code'} '),
          onPressed: _switchCode,
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  buttonSignIn() {
    return Column(
      children: [
        RaisedButton(
          child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
          onPressed: _submit,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).primaryTextTheme.button.color,
        ),
        FlatButton(
          child: Text(
              '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
          onPressed: _switchAuthMode,
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).primaryColor,
        ),
        if (_authMode == AuthMode.Login)
          FlatButton(
            child: Text(
                '${_authMode == AuthMode.Login ? 'Change Password' : 'login'} '),
            onPressed: _switchChangePassword,
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textColor: Theme.of(context).primaryColor,
          ),
      ],
    );
  }

  // List<Widget> children = [];
  //   if (_authMode == AuthMode.Login || _authMode == AuthMode.Signup)
  //     children.add(textFieldSignIn());

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (_authMode == AuthMode.Login || _authMode == AuthMode.Signup)
                  textFieldSignIn(),
                if (_authMode == AuthMode.Reset) textFieldReset(),
                if (_authMode == AuthMode.Code) textFieldCode(),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading) CircularProgressIndicator()
                // else
                //  if (_authMode == AuthMode.Code)
                //   textFieldCode(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
