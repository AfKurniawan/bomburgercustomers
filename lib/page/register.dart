import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/element/BlockButtonWidget.dart';
import 'package:bomburger301219/element/CustomDialogError.dart';
import 'package:bomburger301219/models/user.dart';
import 'package:flutter/material.dart';
import 'package:bomburger301219/config/app_config.dart' as config;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {

  @override
  _SignUpPageState createState() => _SignUpPageState();

}

class _SignUpPageState extends State<SignUpPage> {

  bool obscureText = true;
  bool validate = false;

  TextEditingController controllerTextFullname = new TextEditingController();
  TextEditingController controllerTextEmail = new TextEditingController();
  TextEditingController controllerTextPassword = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    controllerTextFullname.dispose();
    controllerTextEmail.dispose();
    controllerTextPassword.dispose();
    super.dispose();
  }

  void signUpAction() async {

    signUp(ApiUrl.signupUrl, {
      'username': controllerTextFullname.text,
      'email': controllerTextEmail.text,
      'password': controllerTextPassword.text,
      'user_type': 'customer'
    }).then((response) async {

      if (response.error == "false" && response.messages == "success") {

        print("success register");


      } else {



      }
    }, onError: (error) {
      failedDialog(context);
      print("iki error on error register");
    });
  }

  Future<LoginResponse> signUp(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {

          print(response.body);

      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print("error cuk");
        throw new Exception("Error while fetching data");
      }
      return LoginResponse.fromJson(json.decode(response.body));
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
              height: config.App(context).appHeight(29.5),
              decoration: BoxDecoration(color: Theme.of(context).accentColor),
            ),
          ),
          Positioned(
            top: config.App(context).appHeight(29.5) - 120,
            child: Container(
              width: config.App(context).appWidth(84),
              height: config.App(context).appHeight(29.5),
              child: Text(
                'Let\'s Start with register!',
                style: Theme.of(context).textTheme.display3.merge(TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
          Positioned(
            top: config.App(context).appHeight(29.5) - 50,
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
//              height: config.App(context).appHeight(55),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorText: validate ? "Can\'t be empty" : null,
                      labelText: "Your Name",
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Your Name',
                      hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      errorText: validate ? "Can\'t be empty" : null,
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'you@mail.com',
                      hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.mail_outline, color: Theme.of(context).accentColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    keyboardType: TextInputType.text,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: validate ? "Can\'t be empty" : null,
                      labelStyle: TextStyle(color: Theme.of(context).accentColor),
                      contentPadding: EdgeInsets.all(12),
                      hintText: '••••••••••••',
                      hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                      prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
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
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                    ),
                  ),
                  SizedBox(height: 30),
                  BlockButtonWidget(
                    text: Text(
                      'Register',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {

                      setState(() {
                        controllerTextFullname.text.isEmpty ? validate = true : validate = false;
                        controllerTextEmail.text.isEmpty ? validate = true : validate = false;
                        controllerTextPassword.text.isEmpty ? validate = true : validate = false;

                        print("Register button clicked");
                        signUpAction();
                      });
                    },
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              textColor: Theme.of(context).hintColor,
              child: Text('I have account? Back to login'),
            ),
          )
        ],
      ),
    );
  }

  failedDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
        title: "Register Failed",
        description: "Request timeout, make sure your internet is connected",
        buttonText: "Okay",
      ),
    );
  }
}


