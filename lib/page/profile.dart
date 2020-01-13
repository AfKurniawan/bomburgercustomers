import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/element/CustomDialogAddAddress.dart';
import 'package:bomburger301219/element/CustomDialogEditAddress.dart';
import 'package:bomburger301219/element/CustomDialogError.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:bomburger301219/models/user.dart';
import 'package:bomburger301219/widget/OrderItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bomburger301219/config/app_config.dart' as config;
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
  String id;
  String email;
  String address = "";
  String phone = "";
  String bname = "";
  String status;
  String baddress;
  String bphone;
  String usertype;
  String storeid;

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  getPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      sellerid = prefs.getString("userid");
      print("userid from preferences $sellerid");
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
    getResponse(ApiUrl.getProfileResponse, {
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
    userDetail(ApiUrl.getProfileUrl, {'user_id': sellerid}).then((response) {
      print("profile Page: ${response.username}");

      setState(() {
        name = response.username;
        image = response.photo;
        email = response.email;
        address = response.address;
        print("Profile image: $baddress");
        print("responce address ${response.address}");
      });

      if (response.photo == "") {
        setState(() {
          image = "no-image.png";
          print("Profile image2: $image");
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

  void getCartItem() {
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
    final _ac = config.App(context);
    return SingleChildScrollView(
      //padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: <Widget>[
          Container(
            height: _ac.appHeight(40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(ApiUrl.imgUrl + image),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                        )
                      ]),
                  margin: EdgeInsets.symmetric(
                    horizontal: _ac.appHorizontalPadding(10),
                    vertical: _ac.appVerticalPadding(0),
                  ),
                  width: _ac.appWidth(80),
                  height: 220,
                ),
              ],
            ),
          ),

          Text(
            '$name'.toUpperCase(),
            style: Theme.of(context).textTheme.display1,
          ),
          SizedBox(height: 10),
          Text(
            '$email',
            style: Theme.of(context).textTheme.caption,
          ),
          ListTile(
            //contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.my_location,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Address',
              style: Theme.of(context).textTheme.display1,
            ),
          ),

          address == "" ?
              Visibility(
                visible: true,
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FlatButton(onPressed: (){

                  showDialog(
                    context: context,
                    child: AddAddressDialog(
                    ),
                  );

                },
                    child: Text("Add Address")),
                ),
              )
          : Padding( padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '$address',
                  style: Theme.of(context).textTheme.display4,
                ),
                IconButton(icon: Icon(Icons.edit), onPressed: (){
                  showDialog(
                    context: context,
                    child: EditAddressDialog(
                      address: address,

                    ),
                  );


                })
              ],
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
              return OrderItemWidget(
                heroTag: 'profile_orders',
                order: cart.elementAt(i),
              );
            },
          ),
        ],
      ),
    );
  }
}
