import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/food.dart';
import 'package:bomburger301219/models/outlet.dart';
import 'package:bomburger301219/widget/DrawerWidget.dart';
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
  String layout = "list";



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
//    return Container(
//      child: FutureBuilder(
//        future: getBurger(),
//        builder: (context, snapshot) {
//          return snapshot.connectionState == ConnectionState.done
//              ? snapshot.hasData
//              ? buildListView(snapshot.data)
//              : InkWell(
//            child: Padding(
//              padding: const EdgeInsets.all(32.0),
//              child: Container(
//                height: 450,
//                child: Center(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      IconButton(
//                        iconSize: 60,
//                        icon: Icon(Icons.refresh),
//                        onPressed: () {
//                          refresh();
//                        },
//                      ),
//                      Text("Retry")
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          )
//              : Container(
//            height: 500,
//            child: Center(
//              child: const CircularProgressIndicator(
//                value: null,
//                strokeWidth: 1,
//              ),
//            ),
//          );
//        },
//      ),
//    );

    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            /* Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                  suffixIcon: Icon(Icons.mic_none, color: Theme.of(context).focusColor.withOpacity(0.7)),
                  border:
                  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                  enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                ),
              ),
            ),*/
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                /*leading: Icon(
                  Icons.favorite,
                  color: Theme.of(context).hintColor,
                ),*/
                title: Text(
                  'Burgers',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.display1,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          this.layout = 'list';
                        });
                      },
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: this.layout == 'list'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).focusColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          this.layout = 'grid';
                        });
                      },
                      icon: Icon(
                        Icons.apps,
                        color: this.layout == 'grid'
                            ? Theme.of(context).accentColor
                            : Theme.of(context).focusColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Offstage(
              offstage: this.layout != 'list',
              child: FutureBuilder(
                  future: getBurger(),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? buildListView(snapshot.data)
                        : Center(
                      child: new SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: const CircularProgressIndicator(
                            value: null,
                            strokeWidth: 1.0,
                          )),
                    );
                  }),
            ),
//            Offstage(
//              offstage: this.layout != 'grid',
//              child: FutureBuilder(
//                  future: getData(),
//                  builder: (context, snapshot) {
//                    return snapshot.data != null
//                        ? buildGridView(snapshot.data)
//                        : Center(
//                      child: new SizedBox(
//                          width: 20.0,
//                          height: 20.0,
//                          child: const CircularProgressIndicator(
//                            value: null,
//                            strokeWidth: 1.0,
//                          )),
//                    );
//                  }),
//            )
          ],
        ),
      );

  }

  Widget buildListView(List<Menu> lsit) {

    return new ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: lsit == null
          ? CircularProgressIndicator(
        value: null,
        strokeWidth: 1.0,
      )
          : lsit.length,
      itemBuilder: (context, index) {

        /*return FavoriteListItemWidget(
          heroTag: 'favorites_list',
          burger: _burgerList.elementAt(index),
        );*/


        return MenuItemWidgetSeller(menu: lsit.elementAt(index));



      },
    );
  }

//  Widget buildListView(List<Menu> menu) {
//    return ListView.builder(
//        scrollDirection: Axis.vertical,
//        shrinkWrap: true,
//        primary: false,
//        itemCount: menu.length == null ? 0 : menu.length,
//        itemBuilder: (context, index) {
//          return MenuItemWidgetSeller(menu: menu.elementAt(index));
//        });
//  }
}
