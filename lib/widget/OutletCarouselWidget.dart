import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/outlet.dart';
import 'package:bomburger301219/page/details_outlet.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OutletCarouselWidget extends StatefulWidget {

  Outlet outlets;

  OutletCarouselWidget({Key key, this.outlets}) : super(key: key);

  @override
  _ListOutletWidgetState createState() => _ListOutletWidgetState();
}

class _ListOutletWidgetState extends State<OutletCarouselWidget> {


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

    return Container(
      height: 288,
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
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: lo.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            //Navigator.of(context).pushNamed("/Detail", arguments: lo[index].id);
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> DetailsOutletWidget(outlet: lo[index]))
            );
          },
          child: Container(
            width: 292,
            margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).focusColor.withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 5)),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Image of the card
                Hero(
                  tag: lo[index].id,
                  child: Container(
                    width: 292,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(ApiUrl.imgUrl + lo[index].picture),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              lo[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subhead,
                            ),
                            Text(
                              lo[index].description,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption,
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
