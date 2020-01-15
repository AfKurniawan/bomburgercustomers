import 'package:bomburger301219/config/app_config.dart';
import 'package:bomburger301219/models/payment.dart';
import 'package:bomburger301219/page/pager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_urls.dart';
import '../models/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CustomDialogSuccess.dart';

class MyDialog extends StatefulWidget {
  final String sellerid, description, buttonText;
  final Image image;
  final String initialValue;
  final void Function(String) onValueChange;

  const MyDialog(
      {this.onValueChange,
      this.initialValue,
      this.sellerid,
      this.description,
      this.buttonText,
      this.image});



  @override
  _MyDialogState createState() => _MyDialogState();
}


class PaymentMethodList {
  String name;
  int index;
  PaymentMethodList({this.name, this.index});
}

class _MyDialogState extends State<MyDialog> {
  String paymentMethod;


  String sellerid = "";
  String _response = "";
  SharedPreferences prefs;


  // Default Radio Button Item
  String paymentMethos = 'Cash';
  String status = 'onCheckout';

  // Group Value for Radio Button.
  int id = 1;

  List<PaymentMethodList> fList = [
    PaymentMethodList(
      index: 1,
      name: "Cash",
    ),
    PaymentMethodList(
      index: 2,
      name: "Non Cash",
    ),
  ];

  Future<CartResponse> checkout(String url, var body) async {
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

  void insertCheckout() {
    checkout(ApiUrl.checkoutUrl, {
      'seller_id': sellerid,
      'status': status,
      'payment': paymentMethos,
    }).then((response) async {
      print(response.messages);
      print("sellerid on checkout action ${sellerid}");

      if (response.messages == 'success') {

        Navigator.of(context).pushNamed('/History');


      } else {
        print("Error checkout");
      }
    }, onError: (error) {
      _response = error.toString();
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

  getPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      sellerid = prefs.getString("userid");
      print("ini adalah user id $sellerid");

//    getCartItem();
//    getTotalCart();
    });
  }

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Theme.of(context).primaryColor,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                // color: Theme.of(context).primaryColorDark,
                color: Colors.black12,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                "Choose Payment Method",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),


            Container(
              child: Column(
                children:
                fList.map((data) => RadioListTile(
                  title: Text("${data.name}"),
                  groupValue: id,
                  value: data.index,
                  onChanged: (val) {
                    setState(() {
                      paymentMethos = data.name ;
                      id = data.index;
                    });
                  },
                )).toList(),
              ),
            ),



//                Container(
//                  child:  new DropdownButton<String>(
//                    hint: Text('Choose Payment Method'),
//                    onChanged: (String changedValue) {
//
//                      setState(() {
//                        paymentMethod = changedValue;
//                        print("$paymentMethod from dialog");
//                      });
//                    },
//                    value: paymentMethod,
//                    items: <String>['Cash']
//                        .map((String value) {
//                      return new DropdownMenuItem<String>(
//                        value: value,
//                        child: new Text(value),
//                      );
//                    }).toList()),
//
//                ),

              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    insertCheckout();

                    //Navigator.of(context).pop(); // To close the dialog
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Pager()));
                  },
                  child: Text("Oke"),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            child: Image.asset(
              'assets/img/payment.png',
              width: 90,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            radius: Consts.avatarRadius,
          ),
        ),
      ],
    );
  }
}
