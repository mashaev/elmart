//import 'dart:html';
import 'dart:math';

import 'package:elmart/model/user.dart';
import 'package:elmart/provider/auth_provider.dart';
import 'package:elmart/resourses/session.dart';
import 'package:elmart/resourses/validator.dart';
import 'package:elmart/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login, Reset, Code, NewPassword }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
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

  int _codeNumber;
  // User user =User(_authData['']);
  var _isLoading = false;
  bool _obscureText = true;
  bool _obscureText2 = true;
  final _passwordController = TextEditingController();
  final TextEditingController _codeTC = TextEditingController();

  Future<void> _submitCode() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return false;
    }
    _formKey.currentState.save();
    if (_authMode == AuthMode.Code) {
      bool confirmCode =
          await Provider.of<Auth>(context, listen: false).sendCode(_codeNumber);

      if (confirmCode) {
        setState(() {
          // changePwd = false;
          _authMode = AuthMode.NewPassword;

          // changePwd = false;
        });
      } else {
        cprint('Invalid CODE CONFIRM----------');
      }
    } else if (_authMode == AuthMode.NewPassword) {
      bool confirmNewPassword = await Provider.of<Auth>(context, listen: false)
          .sendNewPassword(_codeNumber, _authData['password']);
      if (confirmNewPassword) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthScreen()));
      } else {
        cprint('Invalid NewPassword CONFIRM----------');
      }
    }
  }

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
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthScreen()));
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
      // if (!register) {
      //   Navigator.of(context)
      //       .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthScreen()));
      //   cprint('IF BLOC SIGN UP-----------');
      // }
      if (register) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => SecondScreen()));
        cprint('IF BLOC SIGN UP-----------');
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => AuthScreen()));
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

  void toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void toggleObscureSecond() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  Column newPasswordField() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: toggleObscure),
          ),
          obscureText: _obscureText,
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
        TextFormField(
          enabled: _authMode == AuthMode.NewPassword,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            suffixIcon: IconButton(
                icon: Icon(
                    _obscureText2 ? Icons.visibility : Icons.visibility_off),
                onPressed: toggleObscureSecond),
          ),
          obscureText: _obscureText2,
          validator: _authMode == AuthMode.NewPassword
              ? (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match!';
                  }
                }
              : null,
        ),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          child: Text(
              // _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'
              'Change Pwd'),
          onPressed: _submitCode,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          color: Theme.of(context).primaryColor,
          textColor: Theme.of(context).primaryTextTheme.button.color,
        ),
      ],
    );
  }

  Column textFieldSignIn() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'E-Mail'),
          keyboardType: TextInputType.emailAddress,
          validator: emailValidation,
          onSaved: (value) {
            _authData['email'] = value;
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: toggleObscure),
          ),
          obscureText: _obscureText,
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
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              suffixIcon: IconButton(
                  icon: Icon(
                      _obscureText2 ? Icons.visibility : Icons.visibility_off),
                  onPressed: toggleObscureSecond),
            ),
            obscureText: _obscureText2,
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
          validator: emailValidation,
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
            if (value.isEmpty || value.length > 5) {
              return 'Invalid code!';
            }
            return null;
          },
          onSaved: (value) {
            _codeNumber = int.parse(value);
            cprint('Saved $_codeNumber');
          },
        ),
        RaisedButton(
          child: Text(_authMode == AuthMode.Code ? 'Code' : 'Reset'),
          onPressed: _submitCode,
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
                if (_authMode == AuthMode.NewPassword) newPasswordField(),
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
