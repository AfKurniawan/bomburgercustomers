
import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/element/CustomDialogError.dart';
import 'package:bomburger301219/models/user.dart';
import 'package:bomburger301219/page/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String id;
  String email;
  String address;
  String phone = "";
  String name = "";
  String status;
  String baddress;
  String bphone;
  String usertype;
  String storeid;
  String photo;

  String userid;
  String _response = '';
  SharedPreferences prefs;

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  getPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString("userid");
      print("userid from preferences $userid");
      getUserResponse();
    });
  }

  Future<LoginResponse> getResponse(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return LoginResponse.fromJson(json.decode(response.body));
    });
  }

  void getUserResponse() {
    getResponse(ApiUrl.getProfileResponse, {
      'user_id': userid,
    }).then((response) async {
      if (response.messages == 'success') {
        print(response.messages);

        getUserDetail();
      } else {
        print("Error iki soko nggon mobile, mbuh salah password atau email");

        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialogError(
            title: "Login Failed",
            description: "Check your username or password",
            buttonText: "Okay",
          ),
        );
      }
    }, onError: (error) {
      print("iki yo error tapi soko server");
    });
  }

  void getUserDetail() {
    userDetail(ApiUrl.getProfileUrl, {'user_id': userid}).then((response) {
      print("profile Page: ${response.username}");

      setState(() {
        name = response.username;
        photo = response.photo;
        email = response.email;
        address = response.address;
        print("Profile image: $baddress");
        print("responce address ${response.address}");
      });

      if (response.photo == "") {
        setState(() {
          photo = "no-image.png";
          print("Profile image2: $photo");
        });
      }
    }, onError: (error) {
      print("iki yo error tapi soko server");
      showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialogError(
          title: "Login Failed",
          description: "Request timeout, make sure your internet is connected",
          buttonText: "Okay",
        ),
      );
    });
  }

  Future<User> userDetail(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return User.fromJson(json.decode(response.body));
    });
  }


  Future<Null> clearPreferences() async {
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();*/

    //Navigator.of(context).pushNamed('/Login');
    /*Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        LoginPage()), (Route<dynamic> route) => false);*/

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    //prefs.remove('login');
    setState(() {
      Navigator.pushReplacementNamed(context, '/');
    });


  }

  @override
  Widget build(BuildContext context) {

    return new Drawer(
      child: ListView(
        children: <Widget>[

          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/Profile', arguments: 1);
            },


            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1),
//              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
              ),


              accountName: Text(
                //"nama",
                name,
                style: Theme.of(context).textTheme.title,
              ),
              accountEmail: Text(
                phone,
                // "phoo",
                style: Theme.of(context).textTheme.caption,
              ),

              currentAccountPicture:
                  photo == null ?
                  Center(
                    child: new SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: const CircularProgressIndicator(
                          value: null,
                          strokeWidth: 1.0,
                        )),
                  )
                  :
              CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                backgroundImage: NetworkImage(ApiUrl.imgUrl + '${photo}'),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Pages', arguments: 2);
            },
            leading: Icon(
              Icons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Home",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          /* ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Pages', arguments: 0);
            },
            leading: Icon(
              Icons.notifications,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Notifications",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),*/
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/History', arguments: 3);
            },
            leading: Icon(
              Icons.fastfood,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Order History",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          /*ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Pages', arguments: 4);
            },
            leading: Icon(
              Icons.favorite,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Favorite Foods",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),*/
          /*ListTile(
            dense: true,
            title: Text(
              "Application Preferences",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Help');
            },
            leading: Icon(
              Icons.help,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Help & Support",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Settings');
            },
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Settings",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Languages');
            },
            leading: Icon(
              Icons.translate,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Languages",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),*/
          ListTile(
            onTap: () {

              clearPreferences();

            },
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Log out",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Version 0.0.1",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );

  }

}
