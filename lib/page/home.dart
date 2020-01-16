
import 'package:bomburger301219/widget/OutletCarouselWidget.dart';
import 'package:bomburger301219/widget/OutletCarouselWidget2.dart';
import 'package:bomburger301219/widget/OutletGridWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
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



          //OutletCarouselWidget(),
          OutletGridWidget(),

//          ListTile(
//            dense: true,
//            contentPadding: EdgeInsets.symmetric(horizontal: 20),
//            leading: Icon(
//              Icons.trending_up,
//              color: Theme.of(context).hintColor,
//            ),
//            title: Text(
//              'Trending This Week',
//              style: Theme.of(context).textTheme.display1,
//            ),
//            subtitle: Text(
//              'Double click on the food to add it to the cart',
//              style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 11)),
//            ),
//          ),

        ],
      ),
    );
  }
}
