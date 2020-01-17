import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/element/CustomDialogError.dart';
import 'package:bomburger301219/element/CustomDialogPayment.dart';
import 'package:bomburger301219/element/CustomDialogSuccess.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:bomburger301219/models/food.dart';
import 'package:bomburger301219/models/payment.dart';
import 'package:bomburger301219/models/route.dart';
import 'package:bomburger301219/page/detail_menu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class CartPage extends StatefulWidget {
  Cart cart;
  Menu menu;
  String heroTag;
  final Function onCall;

  _CartPageState myAppState = new _CartPageState();

  CartPage({Key key, this.onCall, this.cart, this.menu, this.heroTag}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();




}

class _CartPageState extends State<CartPage> {
  List<Cart> items = new List();
  SharedPreferences prefs;
  String sellerid = "";
  String _response = "";
  List cart;
  double totalPrice = 1.0;
  double _total = 0.0;
  String count;
  int jmlItemcart;
  int quantity = 1;
  String responsetotal;

  double totalInButton = 0.0;

  int _ratingController;

  String paymentMnethod;

  final List<String> _items = ['One', 'Two', 'Three', 'Four'].toList();

  String _selection;

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
      getTotalCart();
    });
  }

  Future<CartResponse> deleteCart(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        print("error cuk");

        throw new Exception("Error while fetching data");
      }
      return CartResponse.fromJson(json.decode(response.body));
    });
  }

  Future<Total> totalCart(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      print(response.body);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return Total.fromJson(json.decode(response.body));
    });
  }

  void getTotalCart() {
    totalCart(ApiUrl.totalCartUrl, {
      'seller_id': sellerid,
    }).then((response) async {
      print(response.total);
      print("seller id:" + sellerid);

      setState(() {
        _total = response.jumlah;
        responsetotal = response.total;
        print("ini responsetotal $responsetotal");
        print("TotalCart: " + response.jumlah.toString());
      });
    }, onError: (error) {
      _response = error.toString();
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

      });
    }, onError: (error) {
      _response = error.toString();
      errorDialog(context);
    });
  }

  Future<LabelCartCount> labelCart(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      print(response.body);

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return LabelCartCount.fromJson(json.decode(response.body));
    });
  }

  void getCartLabelCount() {
    labelCart(ApiUrl.getLabelCartUrl, {'seller_id': sellerid}).then(
        (response) async {
      setState(() {
        count = response.count;
        print("Label count cart item ${response.count}");
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

  void _onValueChange(String value) {
    setState(() {
      paymentMnethod = value;
    });
  }
  


  successDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogSuccess(
        title: "Checkout Success",
        description: "Your is in processing",
        buttonText: "Okay",
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              //Navigator.pushNamed(context, '/DetailMenu');
              Navigator.of(context).pop('/DetailMenu');
            }),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cart',
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 150),
            padding: EdgeInsets.only(bottom: 15),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Shopping Cart',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.display1,
                      ),
                      subtitle: Text(
                        'Verify your quantity and click checkout',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: cart == null ? 0 : cart.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 15);
                    },
                    itemBuilder: (context, i) {
                      var subtotal = int.parse(cart[i]['qnt']) *
                          double.parse(cart[i]['price']);

                      print("ini subtotal $subtotal");

                      return InkWell(
                        splashColor: Theme.of(context).accentColor,
                        focusColor: Theme.of(context).accentColor,
                        highlightColor: Theme.of(context).primaryColor,
                        onTap: () {
                          //Navigator.of(context).pushNamed('/Food', arguments: RouteArgument(id: widget.food.id, heroTag: widget.heroTag));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.9),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: Offset(0, 2)),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                //tag: 'hello${cart[i]['product_id']}',
                                //tag: widget.heroTag + widget.food.id,
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            ApiUrl.imgUrl + cart[i]['picture']),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            cart[i]['name'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display4
                                                .merge(TextStyle(
                                                    color: Colors.deepOrange)),
                                          ),
                                          Text(
                                            'RM. ${cart[i]['price']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .display3,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Qty: ${cart[i]['qnt']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                              "SubTotal RM: " +
                                                  subtotal.toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subhead),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () async {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            setState(() {
                                              sellerid =
                                                  prefs.getString('userid');
                                              print("salesid neh: " +
                                                  cart[i]['sales_id']);
                                            });

                                            deleteCart(
                                                ApiUrl.deleteSingleCart, {
                                              'sales_id': cart[i]['sales_id'],
                                              'seller_id': sellerid,
                                            }).then((response) async {
                                              if (response.messages ==
                                                  "deleted") {
                                                setState(() {
                                                  cart.removeAt(i);
                                                  print("iki opi $i");

                                                  getTotalCart();

                                                  if (i < 1) {
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                            '/Cart');
                                                    //getCountLabelCart();
                                                  }
                                                });
                                              }
                                            }, onError: (error) {
                                              _response = error.toString();
                                            });
                                          },
                                          iconSize: 30,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          icon: Icon(Icons.delete_outline),
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          _total == 0.00
              ? Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.remove_shopping_cart, size: 50),
                        SizedBox(height: 30),
                        Text("No Items"),
                      ],
                    ),
                  ),
                )
              : _buildTotalBottomSheet(context, items),
        ],
      ),
    );
  }



  Widget _buildTotalBottomSheet(BuildContext context, List<Cart> items) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 140,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  offset: Offset(0, -2),
                  blurRadius: 5.0)
            ]),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Total',
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                  Text(
                    'RM. ' + _total.toStringAsFixed(2),
                    style: Theme.of(context).textTheme.display1.merge(TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/Pages');
                      },
                      padding: EdgeInsets.symmetric(vertical: 10),
                      color: Theme.of(context).accentColor,
                      shape: StadiumBorder(),
                      child: Icon(
                        Icons.home,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 110,
                        child: FlatButton(
                          onPressed: ()  {


//                            prefs = await SharedPreferences.getInstance();
//                            prefs.getString("userid");
//
//                            print(prefs.getString("userid"));
//
                            showDialog(

                                context: context,
                                builder: (BuildContext context) => new MyDialog(
                                  onValueChange: _onValueChange,
                                  initialValue: paymentMnethod,

                                ),
                            );




                          },
                          padding: EdgeInsets.symmetric(vertical: 14),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Proceed to Checkout',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  incrementQuantity(int quantity) {
    if (quantity <= 99) {
      this.totalPrice = _total * ++quantity;
      return quantity;
    } else {
      return quantity;
    }
  }

  decrementQuantity(int quantity) {
    if (quantity > 1) {
      this.count = count * --quantity;
      return quantity;
    } else {
      return quantity;
    }
  }

//  Future<http.Response> insertCheckout () async {
//
//    Map data = {
//      'seller_id': sellerid,
//      'status': 'onCheckout',
//    };
//    //encode Map to JSON
//    var body = json.encode(data);
//
//    var response = await http.post(ApiUrl.checkoutUrl,
//        headers: {"Content-Type": "application/json"},
//        body: body
//    );
//
//    print("${body}");
//    return response;
//
//
//  }
}
