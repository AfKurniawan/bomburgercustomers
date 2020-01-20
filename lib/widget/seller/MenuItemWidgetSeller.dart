import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/food.dart';
import 'package:bomburger301219/models/outlet.dart';
import 'package:bomburger301219/page/detail_menu.dart';
import 'package:bomburger301219/page/details_outlet.dart';
import 'package:bomburger301219/page/seller/detail_menu_seller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuItemWidgetSeller extends StatefulWidget {

  Outlet restaurant;
  Menu menu;

  MenuItemWidgetSeller({Key key, this.menu, this.restaurant}) : super(key: key);

  @override
  _MenuItemWidgetSellerState createState() => _MenuItemWidgetSellerState();

}

class _MenuItemWidgetSellerState extends State<MenuItemWidgetSeller> {

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
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {

        if(usertype == "seller"){

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=> DetailMenuSeller(menu: widget.menu))
          );

        } else {

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=> DetailMenu(menu: widget.menu))
          );

        }

      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 5)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Container(
//              child: Image.network(
//               ApiUrl.imgUrl + restaurant.picture,
//                fit: BoxFit.cover,
//              ),
//            ),
            Hero(
              tag: "seller"+widget.menu.id,
              child: Container(
                // width: 292,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(ApiUrl.imgUrl + widget.menu.picture),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.menu.name,
                        style: Theme.of(context).textTheme.body2,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),

                      SizedBox(height: 10),

                      Text(
                        "RM. ${widget.menu.price}",
                        style: Theme.of(context).textTheme.title,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),



                  Container(
                    width: 40,
                    height: 40,
                    child: RaisedButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        print('Go to Outlet');

                        if(usertype == "seller"){

                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> DetailMenuSeller(menu: widget.menu))
                          );

                        } else {

                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> DetailMenu(menu: widget.menu))
                          );

                        }

                      },
                      child: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColor),
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 2),
//            Row(
//              children: List.generate(5, (index) {
//                return index < restaurant.rate
//                    ? Icon(Icons.star, size: 18, color: Color(0xFFFFB24D))
//                    : Icon(Icons.star_border, size: 18, color: Color(0xFFFFB24D));
//              }),
//            ),
          ],
        ),
      ),
    );
  }
}