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
    _getCartItem(ApiUrl.getHistoryUrl, {'seller_id': sellerid, 'status': 'onCart'})
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
    return Scaffold(
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
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: cart == null ? 0 : cart.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, i) {
                String status = cart[i]['status'];
                return InkWell(
                  splashColor: Theme.of(context).accentColor,
                  focusColor: Theme.of(context).accentColor,
                  highlightColor: Theme.of(context).primaryColor,
                  onTap: () {
                    // Navigator.of(context).pushNamed('/Tracking');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).focusColor.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2)),
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
                            image: DecorationImage(
                                image: NetworkImage(
                                    ApiUrl.imgUrl + cart[i]['picture']),
                                fit: BoxFit.cover),
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
                                    SizedBox(height: 20),

                                    status == 'onCheckout' ?
                                    Text(
                                      "Processed",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.green),
                                    )
                                    : status == 'onCart' ?

                                     Text(
                                      "In Your Cart",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(color: Colors.deepOrange),
                                    )

                                        : Text(
                                      cart[i]['status'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(cart[i]['price'],
                                      style:
                                      Theme.of(context).textTheme.display1),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
