import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/food.dart';
import 'package:bomburger301219/models/outlet.dart';
import 'package:bomburger301219/widget/foods_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsOutletWidget extends StatefulWidget {

  Outlet outlet;


  DetailsOutletWidget({Key key, this.outlet}) : super(key: key);

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends State<DetailsOutletWidget> {


  List listfoods;

  @override
  void initState() {
    getFoods();
    super.initState();
  }

  Future<List<Menu>> getFoods() async {
    print("begin get foods");
    var res = await http.get(Uri.encodeFull(ApiUrl.burgerUrl),
        headers: {"Accept": "application/json"});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["burgers"] as List;
      // print("burger" + res.body);

      listfoods = rest.map<Menu>((j) => Menu.fromJson(j)).toList();


    } else {

    }
    // print("List Size: ${list.length}");
    return listfoods;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/Menu');
        },
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        icon: Icon(Icons.restaurant),
        label: Text('Menu'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                             widget.outlet.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.display2,
                            ),
                          ),

                          SizedBox(width: 10),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(widget.outlet.description),
                    ),


                    FutureBuilder(
                        future: getFoods(),
                        builder: (context, snapshot) {
                          return snapshot.connectionState == ConnectionState.done
                              ? snapshot.hasData
                              ? buildListView(snapshot.data)
                              : InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Center(
                                  child: IconButton(
                                    iconSize: 60,
                                    color: Colors.blueGrey,
                                    icon: Icon(Icons.error_outline),
                                    onPressed: getFoods,
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
                        }
                        ),
//                    Container(
//                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                      margin: const EdgeInsets.symmetric(vertical: 5),
//                      color: Theme.of(context).primaryColor,
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: Text(
//                              _restaurant.address,
//                              overflow: TextOverflow.ellipsis,
//                              maxLines: 2,
//                              style: Theme.of(context).textTheme.body2,
//                            ),
//                          ),
//                          SizedBox(width: 10),
//                          SizedBox(
//                            width: 42,
//                            height: 42,
//                            child: FlatButton(
//                              padding: EdgeInsets.all(0),
//                              onPressed: () {},
//                              child: Icon(
//                                Icons.directions,
//                                color: Theme.of(context).primaryColor,
//                                size: 24,
//                              ),
//                              color: Theme.of(context).accentColor.withOpacity(0.9),
//                              shape: StadiumBorder(),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    Container(
//                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                      margin: const EdgeInsets.symmetric(vertical: 5),
//                      color: Theme.of(context).primaryColor,
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: Text(
//                              '${_restaurant.phone} \n${_restaurant.mobile}',
//                              overflow: TextOverflow.ellipsis,
//                              style: Theme.of(context).textTheme.body2,
//                            ),
//                          ),
//                          SizedBox(width: 10),
//                          SizedBox(
//                            width: 42,
//                            height: 42,
//                            child: FlatButton(
//                              padding: EdgeInsets.all(0),
//                              onPressed: () {},
//                              child: Icon(
//                                Icons.call,
//                                color: Theme.of(context).primaryColor,
//                                size: 24,
//                              ),
//                              color: Theme.of(context).accentColor.withOpacity(0.9),
//                              shape: StadiumBorder(),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                      child: ListTile(
//                        dense: true,
//                        contentPadding: EdgeInsets.symmetric(vertical: 0),
//                        leading: Icon(
//                          Icons.recent_actors,
//                          color: Theme.of(context).hintColor,
//                        ),
//                        title: Text(
//                          'What They Say ?',
//                          style: Theme.of(context).textTheme.display1,
//                        ),
//                      ),
//                    ),

//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 20),
//                      child: ListTile(
//                        dense: true,
//                        contentPadding: EdgeInsets.symmetric(vertical: 0),
//                        leading: Icon(
//                          Icons.restaurant,
//                          color: Theme.of(context).hintColor,
//                        ),
//                        title: Text(
//                          'Featured Foods',
//                          style: Theme.of(context).textTheme.display1,
//                        ),
//                      ),
//                    ),



                  ],
                ),
              ),
            ],
          ),
//          Positioned(
//            top: 32,
//            right: 20,
//            child: ShoppingCartFloatButtonWidget(
//              iconColor: Theme.of(context).primaryColor,
//              labelColor: Theme.of(context).hintColor,
//              labelCount: 1,
//            ),
//          ),
        ],
      ),
    );


    }

  Widget buildListView(List<Menu> lm){
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      itemCount: listfoods.length,
      separatorBuilder: (context, index) {
        return SizedBox(height: 10);
      },
      itemBuilder: (context, index) {
        return FoodsItemWidget(
          heroTag: 'details_featured_food',
          food: listfoods.elementAt(index),
        );
      },
    );
  }
}
