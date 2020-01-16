import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/element/CustomDialogError.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:bomburger301219/models/route.dart';
import 'package:bomburger301219/widget/OrderItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersPage extends StatefulWidget {
  RouteArgument routeArgument;

  OrdersPage({Key key, this.routeArgument}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List cart;
  SharedPreferences prefs;
  String sellerid = "";
  String _response = "";
  double _total = 0.0;
  String responsetotal;
  bool isVisible = false;

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

  Future<List<Cart>> getCartItem() async {
    print("begin get Cart itmes");
    var res = await http.post(Uri.encodeFull(ApiUrl.getHistoryUrl),
        body: {'seller_id': sellerid, 'status': 'onCheckout'},
        headers: {"Accept": "application/json"});
    print(sellerid);
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["cart"] as List;
      cart = rest.map<Cart>((j) => Cart.fromJson(j)).toList();
    }
    return cart;
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
    totalCart(ApiUrl.totalHistoryUrl, {
      'seller_id': sellerid,
    }).then((response) async {
      print(response.total);
      print("seller id:" + sellerid);

      setState(() {
        isVisible = true;
        _total = response.jumlah;
        responsetotal = response.total;
        print("ini responsetotal $responsetotal");
        print("TotalCart: " + response.jumlah.toString());
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
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.symmetric(horizontal: 20),
//              child: SearchBarWidget(),
//            ),
          SizedBox(height: 10),

          FutureBuilder(
              future: getCartItem(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.done
                    ? snapshot.hasData
                        ? buildListViewHistory(snapshot.data)
                        : InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Center(
                                  child: IconButton(
                                iconSize: 60,
                                color: Colors.blueGrey,
                                icon: Icon(Icons.error_outline),
                                onPressed: getCartItem,
                              )),
                            ),
                          )
                    : Container(
                        height: 180,
                        child: Center(
                          child: const CircularProgressIndicator(
                            value: null,
                            strokeWidth: 1.0,
                          ),
                        ),
                      );
              }),

          Visibility(
            visible: isVisible,
            child: Positioned(
              bottom: 0,
              child: Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
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
                          _total == 0.0
                              ? Text(
                                  "Calculating...",
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .merge(TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.bold)),
                                )
                              : Text(
                                  'RM. ' + _total.toStringAsFixed(2),
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .merge(TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.bold)),
                                )
                        ],
                      ),
                      SizedBox(height: 20),
//                Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: FlatButton(
//                        onPressed: () {
//                          Navigator.of(context).pushNamed('/Pages');
//                        },
//                        padding: EdgeInsets.symmetric(vertical: 10),
//                        color: Theme.of(context).accentColor,
//                        shape: StadiumBorder(),
//                        child: Icon(
//                          Icons.home,
//                          color: Theme.of(context).primaryColor,
//                        ),
//                      ),
//                    ),
//                    SizedBox(width: 10),
//                    Stack(
//                      fit: StackFit.loose,
//                      alignment: AlignmentDirectional.centerEnd,
//                      children: <Widget>[
//                        SizedBox(
//                          width: MediaQuery.of(context).size.width - 110,
//                          child: FlatButton(
//                            onPressed: ()  {
//
//                            },
//                            padding: EdgeInsets.symmetric(vertical: 14),
//                            color: Theme.of(context).accentColor,
//                            shape: StadiumBorder(),
//                            child: Container(
//                              width: double.infinity,
//                              padding: const EdgeInsets.symmetric(horizontal: 20),
//                              child: Text(
//                                'Proceed to Checkout',
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    color: Theme.of(context).primaryColor),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
                      //SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),

//        child: Container(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.start,
//          mainAxisSize: MainAxisSize.max,
//          children: <Widget>[
////            Padding(
////              padding: const EdgeInsets.symmetric(horizontal: 20),
////              child: SearchBarWidget(),
////            ),
//            SizedBox(height: 10),
//
//            FutureBuilder(
//                future: getCartItem(),
//                builder: (context, snapshot) {
//                  return snapshot.connectionState == ConnectionState.done
//                      ? snapshot.hasData
//                          ? buildListViewHistory(snapshot.data)
//                          : InkWell(
//                              child: Padding(
//                                padding: const EdgeInsets.all(32.0),
//                                child: Center(
//                                    child: IconButton(
//                                  iconSize: 60,
//                                  color: Colors.blueGrey,
//                                  icon: Icon(Icons.error_outline),
//                                  onPressed: getCartItem,
//                                )),
//                              ),
//                            )
//                      : Container(
//                          height: 180,
//                          child: Center(
//                            child: const CircularProgressIndicator(
//                              value: null,
//                              strokeWidth: 1.0,
//                            ),
//                          ),
//                        );
//                }),
//
//
//          ],
//        ),
    );
  }

  Widget buildListViewHistory(List<Cart> lc) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: cart == null ? 0 : cart.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
      itemBuilder: (context, i) {
        return OrderItemWidget(heroTag: 'my_orders', order: cart.elementAt(i));
      },
    );
  }
}
