import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/outlet.dart';
import 'package:bomburger301219/widget/OutletItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OutletGridWidget extends StatefulWidget {
  @override
  _OutletGridWidgetState createState() => _OutletGridWidgetState();
}

class _OutletGridWidgetState extends State<OutletGridWidget> {
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
  void initState() {
    getOutlet();
    super.initState();
  }

  Future<Null> refresh() {
    return getOutlet().then((outlet) {
      setState(() => outlet = outlet);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getOutlet(),
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

  Widget buildListView(List<Outlet> lo) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        itemCount: lo.length == null ? 0 : lo.length,
        itemBuilder: (context, index) {
          return OutletItemWidget(restaurant: lo.elementAt(index));
        });
  }
}
