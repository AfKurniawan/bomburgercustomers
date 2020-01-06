import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/element/CustomDialogError.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:bomburger301219/models/user.dart';
import 'package:bomburger301219/widget/OrderItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();

// OrdersList _ordersList = new OrdersList();
}

class _ProfilePageState extends State<ProfilePage> {




  List cart;
  SharedPreferences prefs;
  String sellerid = "";
  String _response = "";
  String name = "";
  String image = "";




  @override
  void initState() {
    getPreferences();
    super.initState();
  }


  getPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      sellerid = prefs.getString("userid");
      print("ini adalah user id $sellerid");
      getCartItem();
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
    getResponse(ApiUrl.getProfileResponseUrl, {
      'user_id': sellerid,
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
     // loginFailed();
    });
  }




  void getUserDetail() {
    userDetail(ApiUrl.getUserDetailUrl, {
      'userid': sellerid
    }).then((response) async {

      setState(() {

        name = response.username;
        image = response.photo;

      });


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



  Future<CartResponse> _getCartItem(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      setState(() {
        var extractdata = json.decode(response.body);
        cart = extractdata["cart"];
      });

      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return CartResponse.fromJson(json.decode(response.body));
    });
  }

  void getCartItem()  {
    _getCartItem(ApiUrl.cartUrl, {'seller_id': sellerid, 'status': 'onCart'})
        .then((response) async {
      setState(() {

        _response = response.messages;


        if (_response == "failed") {

          errorDialog(context);
        }

      });
    }, onError: (error) {
      _response = error.toString();
    });
  }


  errorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
        title: "Failed to get data",
        description: "Make sure your internet is connected",
        buttonText: "Okay",
      ),
    );
  }






  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: <Widget>[
      Container(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: 50,
            height: 50,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(Icons.add, color: Theme.of(context).primaryColor),
              color: Theme.of(context).accentColor,
              shape: StadiumBorder(),
            ),
          ),
          SizedBox(
            width: 135,
            height: 135,
            child: CircleAvatar(backgroundImage: NetworkImage(ApiUrl.imgUrl + image)),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(Icons.chat, color: Theme.of(context).primaryColor),
              color: Theme.of(context).accentColor,
              shape: StadiumBorder(),
            ),
          ),
        ],
      ),
      ),
      Text(
      '$name',
      style: Theme.of(context).textTheme.headline,
      ),
      Text(
      'Berlin, Germany',
      style: Theme.of(context).textTheme.caption,
      ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.person,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'About',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical professor Read More',
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.shopping_basket,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Recent Orders',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: cart == null ? 0 : cart.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, i) {
              return InkWell(
                splashColor: Theme.of(context).accentColor,
                focusColor: Theme.of(context).accentColor,
                highlightColor: Theme.of(context).primaryColor,
                onTap: () {
                  Navigator.of(context).pushNamed('/Tracking');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.9),
                    boxShadow: [
                      BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(image: NetworkImage(ApiUrl.imgUrl + cart[i]['picture']), fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    cart[i]['name'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
//                        Text(
//                          order.restaurantName,
//                          overflow: TextOverflow.ellipsis,
//                          maxLines: 2,
//                          style: Theme.of(context).textTheme.caption,
//                        ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text('RM. ${cart[i]['price']}', style: Theme.of(context).textTheme.display1),
//                      Text(
//                        order.date,
//                        style: Theme.of(context).textTheme.caption,
//                      ),
//                      Text(
//                        order.time,
//                        style: Theme.of(context).textTheme.caption,
//                      ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
//              return OrderItemWidget(
//                heroTag: 'profile_orders',
//                order: cart[i].elementAt(i),
//              );
            },
          ),
        ],
      ),
    );
  }
}
