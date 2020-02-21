
import 'package:bomburger_pos/page/seller/seller_foods_home.dart';
import 'package:bomburger_pos/widget/OutletCarouselWidget.dart';
import 'package:bomburger_pos/widget/OutletCarouselWidget2.dart';
import 'package:bomburger_pos/widget/OutletGridWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();

}




  class _HomePageState extends State<HomePage> {

  SharedPreferences prefs;
  String usertype = "";

  @override
  void initState() {
    getPrefs();
    super.initState();

  }


  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      usertype = prefs.getString("usertype");
    });


  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          Padding(
              padding: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(FontAwesomeIcons.shoppingBag, color: Theme.of(context).accentColor),
              title: Text("Our Outlets", style: Theme.of(context).textTheme.display1),
              subtitle: Text("Choose nearby Outlet from your place", style: Theme.of(context).textTheme.caption),
            ),
          ),



          usertype == "seller" ?

              FoodsListWidget()

          : OutletGridWidget(),



        ],
      ),
    );
  }
}
