import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/outlet.dart';
import 'package:bomburger301219/page/details_outlet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bomburger301219/config/app_config.dart' as config;

class OutletCarouselWidget2 extends StatefulWidget {

  Outlet outlets;

  OutletCarouselWidget2({Key key, this.outlets}) : super(key: key);

  @override
  _ListOutletWidget2State createState() => _ListOutletWidget2State();
}

class _ListOutletWidget2State extends State<OutletCarouselWidget2> {


  Outlet outlets;

  @override
  void initState() {
    getOutlet();
    super.initState();
  }

  List outletlist;
  Future<List<Outlet>> getOutlet() async {
    var res = await http.get(Uri.encodeFull(ApiUrl.getOutletUrl),
        headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var rest = data["stores"] as List;
      outletlist = rest.map<Outlet>((j) => Outlet.fromJson(j)).toList();
    }

    return outletlist;
  }

  @override
  Widget build(BuildContext context) {
    final _ac = config.App(context);
    return Container(
      height: _ac.appHeight(100),
      child: FutureBuilder(
        future: getOutlet(),
        builder: (context, snapshot){
          return snapshot.connectionState == ConnectionState.done ?
          snapshot.hasData
              ? buildListView(snapshot.data)
              : InkWell(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      iconSize: 60,
                      icon: Icon(Icons.refresh),
                      onPressed: (){
                        refresh();
                      },
                    ),
                    Text("Retry")
                  ],
                ),
              ),
            ),
          )
              : Container(
            height: 180,
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

  Future<Null> refresh() {
    return getOutlet().then((outlet) {
      setState(() => outlet = outlet);
    });
  }

  Widget buildListView(List<Outlet> lo) {
    final _ac = config.App(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: lo.length,
      itemBuilder: (context, index) {
        return Stack(
          children: <Widget>[
            Positioned(
              top: 140,
              child: GestureDetector(
                onTap: () {
                  //Navigator.of(context).pushNamed("/Detail", arguments: lo[index].id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> DetailsOutletWidget(outlet: lo[index]))
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 50,
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                        )
                      ]),
                  margin: EdgeInsets.symmetric(
                    horizontal: _ac.appHorizontalPadding(5),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: _ac.appWidth(90),
                  height: _ac.appHeight(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 180),
                      Text(
                        lo[index].name,
                        style: Theme.of(context).textTheme.title,
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.place,
                            color: Theme.of(context).focusColor.withOpacity(1),
                            size: 28,
                          ),
                          SizedBox(width: 10),

                          Text(
                            lo[index].description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: Theme.of(context).textTheme.body2,
                          )

                        ],
                      ),
                      SizedBox(height: 80),

                      Container(
                        width: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            print('Go to Outlet');

                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context)=> DetailsOutletWidget(outlet: lo[index]))
                            );

                          },
                          child: Icon(Icons.directions,
                              color: Theme.of(context).primaryColor),
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              child: Hero(
                tag: lo[index].id,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(ApiUrl.imgUrl + lo[index].picture),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                        )
                      ]),
                  margin: EdgeInsets.symmetric(
                    horizontal: _ac.appHorizontalPadding(10),
                    vertical: _ac.appVerticalPadding(10),
                  ),
                  width: _ac.appWidth(80),
                  height: 220,
                ),
              ),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> DetailsOutletWidget(outlet: lo[index]))
                );
              },
            ),

          ],
        );
      },
    );
  }
}