import 'package:bomburger301219/config/app_config.dart';
import 'package:bomburger301219/models/payment.dart';
import 'package:bomburger301219/page/pager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_urls.dart';
import '../models/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';
import '../page/profile.dart';
import 'CustomDialogSuccess.dart';

class EditAddressDialog extends StatefulWidget {
  final String sellerid, address, buttonText;
  final Image image;

  const EditAddressDialog(
      {this.onValueChange,
      this.initialValue,
      this.sellerid,
      this.address,
      this.buttonText,
      this.image});

  final String initialValue;
  final void Function(String) onValueChange;

  @override
  _EditAddressDialogState createState() => _EditAddressDialogState();
}


class PaymentMethodList {
  String name;
  int index;
  PaymentMethodList({this.name, this.index});
}

class _EditAddressDialogState extends State<EditAddressDialog> {

  String userid = "";
  String _response = "";
  SharedPreferences prefs;

  TextEditingController controllerTextAddress = new TextEditingController();



  Future<CartResponse> _addAddress(String url, var body) async {
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

  void insertAddress() {
    _addAddress(ApiUrl.addAddressUrl, {
      'customerid': userid,
      'address': controllerTextAddress.text,
    }).then((response) async {
      print(response.messages);
      print("userid on insert address action ${userid}");

      if (response.messages == 'success') {
       Navigator.pop(context);

      successDialog(context);



      } else {
        print("Error");
      }
    }, onError: (error) {
      _response = error.toString();
    });
  }

  successDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogSuccess(
        title: "Success",
        description: "Your address is updated",
        buttonText: "Okay",
      ),
    );
  }

  getPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString("userid");
      print("ini adalah user id $userid");

      //insertAddress();

    });
  }

  @override
  void initState() {
    getPreferences();
    controllerTextAddress.text = widget.address;
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
                "Edit Address",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.0),


            Container(
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: controllerTextAddress,
                decoration: InputDecoration(
                  labelText: "Your Address",
                  labelStyle:
                  TextStyle(color: Theme.of(context).accentColor),
                  contentPadding: EdgeInsets.all(12),

                  hintStyle: TextStyle(
                      color: Theme.of(context).focusColor.withOpacity(0.7)),
                  prefixIcon: new Padding(
                    padding: const EdgeInsets.only( top: 15, left: 5, right: 0, bottom: 15),
                    child: new SizedBox(
                      height: 4,
                      child: Image.asset("assets/img/home-address.png"),
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
            ),



              SizedBox(height: 24.0),

              Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Later", style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),

                    SizedBox(width: 50.0),

                    FlatButton(
                      onPressed: () {
                        insertAddress();
                        //getPreferences();
                      },
                      child: Text("Oke", style: TextStyle(color: Theme.of(context).accentColor),

                      ),
                    ),
                  ],
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
              'assets/img/home-address.png',
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
