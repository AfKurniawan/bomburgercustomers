import 'dart:async';

import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/food.dart';
import 'package:bomburger301219/models/outlet.dart';
import 'package:bomburger301219/widget/DrinksCarouselItemWidget.dart';
import 'package:bomburger301219/widget/FoodsCarouselItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class DetailsOutletWidget extends StatefulWidget {
  Outlet outlet;
  String _response = "";

  DetailsOutletWidget({Key key, this.outlet}) : super(key: key);

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends State<DetailsOutletWidget> {
  List listfoods;
  List listdrinks;
  String _response = "";
  SharedPreferences prefs;

  @override
  void initState() {
    saveStoreIdToPrefs();
    super.initState();
  }

  saveStoreIdToPrefs() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('store', widget.outlet.id);
    print("Store id is : ${widget.outlet.id}");
    getFoods();
    getDrinks();
  }

  Future<List<Menu>> getFoods() async {
    print("begin get foods");
    var res = await http.post(Uri.encodeFull(ApiUrl.burgerUrl),
        body: {'store_id': widget.outlet.id},
        headers: {"Accept": "application/json"});

    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["burgers"] as List;
      listfoods = rest.map<Menu>((j) => Menu.fromJson(j)).toList();
    }
    return listfoods;
  }

  Future<List<Menu>> getDrinks() async {
    print("begin get foods");
    var res = await http.post(Uri.encodeFull(ApiUrl.drinkUrl),
        body: {'store_id': widget.outlet.id},
        headers: {"Accept": "application/json"});
    print(widget.outlet.id);

    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["drinks"] as List;
      listdrinks = rest.map<Menu>((j) => Menu.fromJson(j)).toList();
    }
    return listdrinks;
  }

  Future<Null> refreshDrink() {
    return getDrinks().then((outlet) {
      setState(() => outlet = outlet);
    });
  }

  Future<Null> refreshFoods() {
    return getDrinks().then((outlet) {
      setState(() => outlet = outlet);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      floatingActionButton:
//      FloatingActionButton.extended(
//        onPressed: () {
//          Navigator.of(context).pushNamed('/Menu');
//        },
//        isExtended: true,
//        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//        icon: Icon(Icons.shopping_cart),
//        label: Text('Cart'),
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                expandedHeight: 300,
                elevation: 0,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Hero(
                    tag: widget.outlet.id,
                    child: Image.network(
                      ApiUrl.imgUrl + widget.outlet.picture,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Wrap(
//              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.outlet.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.display2,
                          ),
                          SizedBox(height: 10),
                          Text(widget.outlet.description),
                          SizedBox(height: 10),
                          //Text(widget.outlet.id),
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: getFoods(),
                        builder: (context, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.done
                              ? snapshot.hasData
                                  ? buildListViewFoods(snapshot.data)
                                  : InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32.0),
                                        child: Center(
                                            child: Column(
                                          children: <Widget>[
                                            IconButton(
                                              iconSize: 60,
                                              color: Colors.blueGrey,
                                              icon: Icon(Icons.error_outline),
                                              onPressed: refreshFoods,
                                            ),
                                            Text("Failed to get foods")
                                          ],
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
                    FutureBuilder(
                        future: getDrinks(),
                        builder: (context, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.done
                              ? snapshot.hasData
                                  ? buildListViewDrinks(snapshot.data)
                                  : InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32.0),
                                        child: Center(
                                            child: Column(
                                          children: <Widget>[
                                            IconButton(
                                              iconSize: 60,
                                              color: Colors.blueGrey,
                                              icon: Icon(Icons.error_outline),
                                              onPressed: refreshDrink,
                                            ),
                                            Text("Failed to get drinks"),
                                          ],
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
            ],
          ),
        ],
      ),
    );
  }

  Widget buildListViewFoods(List<Menu> lm) {
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          leading: Icon(
            Icons.trending_up,
            color: Theme.of(context).hintColor,
          ),
          title: Text(
            'Available Menu',
            style: Theme.of(context).textTheme.display1,
          ),
          subtitle: Text(
            'Click on the food to add it to the cart',
            style: Theme.of(context)
                .textTheme
                .caption
                .merge(TextStyle(fontSize: 11)),
          ),
        ),
        Container(
            height: 210,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              itemCount: listfoods == null ? 0 : listfoods.length,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                return FoodsCarouselItemWidget(
                  heroTag: 'home_food_carousel',
                  marginLeft: _marginLeft,
                  food: listfoods.elementAt(index),
                );
              },
              scrollDirection: Axis.horizontal,
            ))
      ],
    );
  }

  Widget buildListViewDrinks(List<Menu> lm) {
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          leading: Icon(
            Icons.trending_up,
            color: Theme.of(context).hintColor,
          ),
          title: Text(
            'Available Drinks',
            style: Theme.of(context).textTheme.display1,
          ),
          subtitle: Text(
            'Click on the food to add it to the cart',
            style: Theme.of(context)
                .textTheme
                .caption
                .merge(TextStyle(fontSize: 11)),
          ),
        ),
        Container(
            height: 210,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              itemCount: listdrinks.length,
              itemBuilder: (context, index) {
                double _marginLeft = 0;
                (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                return DrinksCarouselItemWidget(
                  heroTag: 'home_drinks_carousel',
                  marginLeft: _marginLeft,
                  food: listdrinks.elementAt(index),
                );
              },
              scrollDirection: Axis.horizontal,
            )),
      ],
    );
  }
}
