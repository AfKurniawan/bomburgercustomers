import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/element/CustomDialogError.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:bomburger301219/widget/OrderItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List cart;
  SharedPreferences prefs;
  String sellerid = "";
  String _response = "";

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
          'Orders',
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
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
          ],
        ),
      ),
    );
  }

  Widget buildListViewHistory(List<Cart> lc) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: lc == null ? 0 : lc.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
      itemBuilder: (context, i) {
        return OrderItemWidget(heroTag: 'my_orders', order: lc.elementAt(i));
      },
    );
  }
}
