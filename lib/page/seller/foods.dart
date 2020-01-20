import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/food.dart';
import 'package:bomburger301219/models/outlet.dart';
import 'package:bomburger301219/widget/OutletItemWidget.dart';
import 'package:bomburger301219/widget/seller/MenuItemWidgetSeller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FoodsListWidget extends StatefulWidget {
  @override
  _FoodsListWidgetState createState() => _FoodsListWidgetState();
}

class _FoodsListWidgetState extends State<FoodsListWidget> {
  List menulist;
  SharedPreferences prefs;
  String storeid = " ";



  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      storeid = prefs.getString("storeid");
      getBurger();
    });

  }
  Future<List<Menu>> getBurger() async {
    var res = await http.post(Uri.encodeFull(ApiUrl.burgerUrl),
        headers: {"Accept": "application/json"},
      body: {'store_id' : storeid }
    );

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["burgers"] as List;
      menulist = rest.map<Menu>((j) => Menu.fromJson(j)).toList();
    }

    return menulist;
  }



  Future<Null> refresh() {
    return getBurger().then((outlet) {
      setState(() => outlet = outlet);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getBurger(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? snapshot.hasData
              ? buildListView(snapshot.data)
              : InkWell(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Container(
                height: 450,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        iconSize: 60,
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          refresh();
                        },
                      ),
                      Text("Retry")
                    ],
                  ),
                ),
              ),
            ),
          )
              : Container(
            height: 500,
            child: Center(
              child: const CircularProgressIndicator(
                value: null,
                strokeWidth: 1,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildListView(List<Menu> menu) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: menu.length == null ? 0 : menu.length,
        itemBuilder: (context, index) {
          return MenuItemWidgetSeller(menu: menu.elementAt(index));
        });
  }
}
