import 'package:bomburger_pos/config/api_urls.dart';
import 'package:bomburger_pos/models/food.dart';
import 'package:bomburger_pos/models/outlet.dart';
import 'package:bomburger_pos/page/detail_menu.dart';
import 'package:bomburger_pos/page/details_outlet.dart';
import 'package:bomburger_pos/page/seller/detail_menu_seller.dart';
import 'package:bomburger_pos/widget/DrawerWidget.dart';
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
  String layout = 'list';

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

  toDetail(){
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
  }


  @override
  Widget build(BuildContext context) {
//    return InkWell(
//      highlightColor: Colors.transparent,
//      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
//      onTap: () {
//
//        if(usertype == "seller"){
//
//          Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context)=> DetailMenuSeller(menu: widget.menu))
//          );
//
//        } else {
//
//          Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context)=> DetailMenu(menu: widget.menu))
//          );
//
//        }
//
//      },
//      child: Container(
//        margin: EdgeInsets.all(10),
//        padding: EdgeInsets.all(5),
//        decoration: BoxDecoration(
//            color: Theme.of(context).primaryColor,
//            borderRadius: BorderRadius.all(Radius.circular(5)),
//            boxShadow: [
//              BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 5)
//            ]),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
////            Container(
////              child: Image.network(
////               ApiUrl.imgUrl + restaurant.picture,
////                fit: BoxFit.cover,
////              ),
////            ),
//            Hero(
//              tag: "seller"+widget.menu.id,
//              child: Container(
//                // width: 292,
//                height: 150,
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                    image: NetworkImage(ApiUrl.imgUrl + widget.menu.picture),
//                    fit: BoxFit.cover,
//                  ),
//                  borderRadius: BorderRadius.all(Radius.circular(10)),
//                ),
//              ),
//            ),
//            SizedBox(height: 5),
//            Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        widget.menu.name,
//                        style: Theme.of(context).textTheme.body2,
//                        softWrap: false,
//                        overflow: TextOverflow.fade,
//                      ),
//
//                      SizedBox(height: 10),
//
//                      Text(
//                        "RM. ${widget.menu.price}",
//                        style: Theme.of(context).textTheme.title,
//                        softWrap: false,
//                        overflow: TextOverflow.fade,
//                      ),
//                    ],
//                  ),
//
//
//
//                  Container(
//                    width: 40,
//                    height: 40,
//                    child: RaisedButton(
//                      padding: EdgeInsets.all(0),
//                      onPressed: () {
//                        print('Go to Outlet');
//
//                        if(usertype == "seller"){
//
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context)=> DetailMenuSeller(menu: widget.menu))
//                          );
//
//                        } else {
//
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context)=> DetailMenu(menu: widget.menu))
//                          );
//
//                        }
//
//                      },
//                      child: Icon(Icons.arrow_forward_ios,
//                          color: Theme.of(context).primaryColor),
//                      color: Theme.of(context).accentColor,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(50)),
//                    ),
//                  ),
//
//                ],
//              ),
//            ),
//            SizedBox(height: 2),
////            Row(
////              children: List.generate(5, (index) {
////                return index < restaurant.rate
////                    ? Icon(Icons.star, size: 18, color: Color(0xFFFFB24D))
////                    : Icon(Icons.star_border, size: 18, color: Color(0xFFFFB24D));
////              }),
////            ),
//          ],
//        ),
//      ),
//    );

    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {

        toDetail();

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

            widget.menu.id != null ?

            Hero(
              tag: 'hello${widget.menu.id}',
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      image: NetworkImage(ApiUrl.imgUrl + widget.menu.picture),
                      fit: BoxFit.cover),
                ),
              ),

            )
                :

            Hero(
              tag: 'hello${widget.menu.id}',
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
                            widget.menu.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subhead),

                        SizedBox(height: 8),

                        Text(widget.menu.getPrice(),
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
  }
}