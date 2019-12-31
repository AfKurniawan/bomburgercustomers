import 'package:bomburger301219/element/block_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:bomburger301219/config/app_config.dart' as config;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool obscureText = true;
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();


  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: config.App(context).appWidth(100),
              height: config.App(context).appHeight(37),
              decoration: BoxDecoration(color: Theme.of(context).accentColor),
            ),
          ),

          Positioned(
            top: config.App(context).appHeight(37) - 120,
            child: Container(
              width: config.App(context).appWidth(84),
              height: config.App(context).appHeight(37),
              child: Text(
                'Let\'s Start with Login!',
                style: Theme.of(context)
                    .textTheme
                    .display3
                    .merge(TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),

          Positioned(
            top: config.App(context).appHeight(37) - 50,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
              width: config.App(context).appWidth(88),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: controllerUsername,
                    decoration: InputDecoration(
                      labelText: "Username or Email",
                      labelStyle:
                      TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'username@email.com',
                      hintStyle: TextStyle(
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.mail_outline, color: Theme.of(context).focusColor,),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2))),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: controllerPassword,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle:
                      TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: '••••••••••••',
                      prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).focusColor),
                      hintStyle: TextStyle(
                          color: Theme.of(context).focusColor.withOpacity(0.7)),
                      suffixIcon: GestureDetector(
                        onTap: toggle,
                        child: Icon(
                          obscureText
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 15.0,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2))),
                    ),
                  ),
                  SizedBox(height: 30),
                  BlockButtonWidget(
                    text: Text(
                      'Login',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {

                      Navigator.of(context).pushNamed('/Pages');

                    },
                  ),
                  SizedBox(height: 80),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/SignUp');
                    },
                    textColor: Theme.of(context).accentColor,
                    child: Text('I don\'t have an account?'),
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
