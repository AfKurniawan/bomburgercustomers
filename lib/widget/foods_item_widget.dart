import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/food.dart';
import 'package:bomburger301219/models/route.dart';
import 'package:flutter/material.dart';

class FoodsItemWidget extends StatelessWidget {

  RouteArgument routeArgument;
  double marginLeft;
  Menu food;
  String heroTag;

  FoodsItemWidget({Key key, this.routeArgument, this.heroTag, this.marginLeft, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    return InkWell(
//      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
//      highlightColor: Colors.transparent,
//      onTap: () {
//       // Navigator.of(context).pushNamed('/Detail', arguments: RouteArgument(id: food.id));
////        Navigator.push(
////            context,
////            MaterialPageRoute(builder: (context)=> DetailMenuSeller(menu: food))
////        );
//      },
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: <Widget>[
//          Stack(
//            alignment: AlignmentDirectional.topEnd,
//            children: <Widget>[
//              Hero(
//                tag: "hlaiyoo" + food.id,
//                child: Container(
//                  margin: EdgeInsets.only(left: this.marginLeft, right: 20),
//                  width: 100,
//                  height: 100,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.all(Radius.circular(5)),
//                    image: DecorationImage(
//                      fit: BoxFit.cover,
//                      image: NetworkImage(ApiUrl.imgUrl + food.picture),
//                    ),
//                    boxShadow: [
//                      BoxShadow(
//                          color: Theme.of(context).focusColor.withOpacity(0.3),
//                          blurRadius: 10,
//                          offset: Offset(0, 5)),
//                    ],
//                  ),
//                ),
//              ),
//
//              Container(
//                margin: EdgeInsets.only(right: 25, top: 5),
//                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//                decoration: BoxDecoration(
//                    borderRadius: BorderRadius.all(Radius.circular(100)), color: Theme.of(context).accentColor),
//                alignment: AlignmentDirectional.topEnd,
//                child: Text(
//                  food.getPrice(),
//                  style: Theme.of(context).textTheme.body2.merge(TextStyle(color: Colors.white)),
//                ),
//              ),
//            ],
//          ),
//          SizedBox(height: 10),
//          Container(
//              width: 100,
//              margin: EdgeInsets.only(left: this.marginLeft, right: 20),
//              child: Column(
//                children: <Widget>[
//                  Text(
//                    this.food.name,
//                    overflow: TextOverflow.fade,
//                    softWrap: false,
//                    style: Theme.of(context).textTheme.body1,
//                  ),
//
//                ],
//              )),
//        ],
//      ),
//    );

    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed('/Tracking');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(image: NetworkImage(ApiUrl.imgUrl+food.picture), fit: BoxFit.cover),
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
                          food.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subhead,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(food.getPrice(), style: Theme.of(context).textTheme.display1),

                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
