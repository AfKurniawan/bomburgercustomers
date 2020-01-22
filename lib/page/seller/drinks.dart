
import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/food.dart';
import 'package:bomburger301219/widget/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DrinksPage extends StatefulWidget {
  @override
  _DrinksPageState createState() => _DrinksPageState();
}

class _DrinksPageState extends State<DrinksPage> {
  List listfoods;
  List listdrinks;
  String layout = 'list';

  int quantity = 1;
  int cartCount;

  //String heroTag;

  SharedPreferences prefs;
  String storeid = "";




  @override
  void initState() {
    // this.layout = 'list';
    //getData();
    getPrefs();

    super.initState();
  }

  Future <Null> getPrefs() async{
    prefs = await SharedPreferences.getInstance();

    setState(() {
      storeid = prefs.getString("storeid");

      getFoods();
    });



  }


  Future<List<Menu>> getFoods() async {
    print("begin get foods");
    var res = await http.post(Uri.encodeFull(ApiUrl.drinkUrl),
        body: {'store_id': storeid},
        headers: {"Accept": "application/json"});

    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["drinks"] as List;
      listfoods = rest.map<Menu>((j) => Menu.fromJson(j)).toList();
    }
    return listfoods;
  }

  Future<List<Menu>> getDrinks() async {
    print("begin get foods");
    var res = await http.post(Uri.encodeFull(ApiUrl.drinkUrl),
        body: {'store_id': storeid},
        headers: {"Accept": "application/json"});
    print(storeid);

    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["drinks"] as List;
      listdrinks = rest.map<Menu>((j) => Menu.fromJson(j)).toList();
    }
    return listdrinks;
  }

  Widget build(BuildContext context) {

    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Burger Menu',
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),

        actions: <Widget>[

          _buildShoppingCartButtonWidget(),

        ],

      ),
      body: SingleChildScrollView(
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
                  future: getFoods(),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? _buildListView(snapshot.data)
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
            Offstage(
              offstage: this.layout != 'grid',
              child: FutureBuilder(
                  future: getFoods(),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? _buildGridView(snapshot.data)
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
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShoppingCartButtonWidget(){


    /*return FlatButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/Cart');
      },

      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            color: Colors.deepOrange,
            size: 28,
          ),


          this.cartCount == null ? Container() :

              Visibility(

                visible: false,
                  child: Container(
                    child: Text(
                      this.cartCount.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption.merge(
                        TextStyle(color: Theme.of(context).primaryColor, fontSize: 9),
                      ),
                    ),
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(10))),
                    constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
                  )

              )


        ],
      ),
      color: Colors.transparent,
    );*/

    return FlatButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/Cart');
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            color: Colors.deepOrange,
            size: 28,
          ),
          Container(
            /* child: Text(
              this.cartCount.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.merge(
                TextStyle(color: Theme.of(context).primaryColor, fontSize: 9),
              ),
            ),*/
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.all(Radius.circular(10))),
            constraints: BoxConstraints(minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
          ),
        ],
      ),
      color: Colors.transparent,
    );


  }

  Widget _buildListView(List<Menu> lsit) {

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


        return InkWell(
          splashColor: Theme.of(context).accentColor,
          focusColor: Theme.of(context).accentColor,
          highlightColor: Theme.of(context).primaryColor,
          onTap: () {

            //this.cartCount += this.quantity;

            //Navigator.of(context).pushNamed('/Food', arguments: new RouteArgument(heroTag: this.heroTag, id: this.burger.id));


//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context)=> FoodWidget(details: _burgerList[index]))
//            );

          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(2, 5)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                listfoods[index].id != null ?
                Hero(
                  tag: 'hello${listfoods[index].id}',
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      image: DecorationImage(
                          image: NetworkImage(ApiUrl.imgUrl + lsit[index].picture),
                          fit: BoxFit.cover),
                    ),
                  ),

                )
                    :

                Hero(
                  tag: 'hello${listfoods[index].id}',
                  child: Container(
                    height: 90,
                    width: 90,
                    child: Center(
                      child: new SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: const CircularProgressIndicator(
                            value: null,
                            strokeWidth: 1.0,
                          )),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                listfoods[index].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subhead),

                            SizedBox(height: 8),

                            Text(listfoods[index].getPrice(),
                                style: Theme.of(context).textTheme.subhead),

                            /*lsit[index].stock_quantity != null
                                ? Text(
                              'Stock: ${_burgerList[index].stock_quantity}',
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .merge(TextStyle(color: Colors.green)),
                            )

                                : Text(
                              'Stock is Empty',
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .merge(TextStyle(color: Colors.red)),
                            ),*/
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      /*Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(_burgerList[index].getPrice(),
                              style: Theme.of(context).textTheme.display1),
                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),*/
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView(List<Menu> _burgerlist) {
    return new GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      padding: EdgeInsets.symmetric(horizontal: 20),

      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount:
      MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(_burgerlist.length, (index) {
        /*return FavoriteGridItemWidget(
          //heroTag: 'favorites_grid',
          burger: _burgerList.elementAt(index),
        );*/

        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Theme.of(context).accentColor.withOpacity(0.08),
          onTap: () {

//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context)=> FoodWidget(details: _burgerList[index]))
//            );
            //Navigator.of(context).pushNamed('/Food', arguments: new RouteArgument(heroTag: this.heroTag, id: this.burger.id));
          },
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Hero(
                      tag: '${_burgerlist[index].id}',
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  ApiUrl.imgUrl + _burgerlist[index].picture),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    _burgerlist[index].name,
                    style: Theme.of(context).textTheme.body2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: <Widget>[
                      /*_burgerlist[index].stock_quantity != null
                          ? Text(
                        'Stock: ${_burgerlist[index].stock_quantity}',
                        style: Theme.of(context).textTheme.caption,
                        overflow: TextOverflow.ellipsis,
                      )
                          : Text(
                        'Stock is empty',
                        style: Theme.of(context).textTheme.caption.merge(TextStyle(
                            color: Colors.red
                        )),
                        overflow: TextOverflow.ellipsis,
                      ),*/
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 5, bottom: 2),
                        height: 30.0,
                        width: 75.0,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.5, color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).accentColor),
                        child: Center(
                          child: Text(
                            _burgerlist[index].getPrice(),
                            style:
                            Theme.of(context).textTheme.body2.merge(TextStyle(
                              //color: Theme.of(context).primaryColor)),
                                color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
