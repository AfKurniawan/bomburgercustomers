import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/element/CustomDialogError.dart';
import 'package:bomburger301219/element/block_button_widget.dart';
import 'package:bomburger301219/models/user.dart';
import 'package:bomburger301219/page/pager.dart';
import 'package:flutter/material.dart';
import 'package:bomburger301219/config/app_config.dart' as config;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


ProgressDialog pd;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool obscureText = true;
  String isLogin = "" ;
  TextEditingController controllerUsername = new TextEditingController();
  TextEditingController controllerPassword = new TextEditingController();


  @override
  void initState() {
    getLoginState();
    super.initState();
  }
  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Future<bool> getLoginState() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getString("login");
    if (isLogin == "isLogin") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Pager()),
              (Route<dynamic> route) => false);
    }
  }

  Future<User> login(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;

      print(response.body);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return User.fromJson(json.decode(response.body));
    });
  }



  void loginAction() {

    pd.show();
    login(ApiUrl.loginUrl, {
      'username': controllerUsername.text,
      'password': controllerPassword.text
    }).then((response) async {
      final prefs = await SharedPreferences.getInstance();
      print(response.loginResponse.messages);

      //if (response.loginResponse.messages == 'success') {
        pd.hide();
        setState(() {
          isLogin = "isLogin";
          prefs.setString("login", isLogin);
          prefs.setString('storeid', response.storeid);
          prefs.setString('userid', response.id);
          print("User Id: " + response.id);
          print("Store Id: " + response.storeid);
        });

        String userid = prefs.getString('userid');
        String storeid = prefs.getString('storeid');
        print("this is your id: " + userid);
        print("this is your store id: " + storeid);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Pager()),
                (Route<dynamic> route) => false);


       // loginFailed();



    }, onError: (error) {
      //print("iki yo error tapi soko server");
     // pd.hide();

     // loginFailed();

    });
  }

  loginFailed(){
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
        title: "Login Failed",
        description: "Request timeout, make sure your internet is connected",
        buttonText: "Okay",
      ),
    );
  }

  buildProgressDialog(){
    pd = new ProgressDialog(context);
    pd.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      elevation: 20.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    buildProgressDialog();
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

                      loginAction();

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
