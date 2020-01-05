import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/food.dart';
import 'package:bomburger301219/models/route.dart';
import 'package:bomburger301219/page/detail_menu.dart';
import 'package:flutter/material.dart';

class FoodsCarouselItemWidget extends StatelessWidget {
  double marginLeft;
  Menu food;
  String heroTag;

  FoodsCarouselItemWidget({Key key, this.heroTag, this.marginLeft, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        //Navigator.of(context).pushNamed('/DetailMenu', arguments: RouteArgument(id: food.id, heroTag: heroTag));

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> DetailMenu(menu: food))
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Hero(
                tag: heroTag + food.id,
                child: Container(
                  margin: EdgeInsets.only(left: this.marginLeft, right: 20),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(ApiUrl.imgUrl + food.picture),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 5, top: 95),
                // padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)), color: Theme.of(context).accentColor),
                alignment: AlignmentDirectional.bottomCenter,

              ),
            ],
          ),
          SizedBox(height: 5),
          Container(
              width: 100,
              margin: EdgeInsets.only(left: this.marginLeft, right: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    this.food.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.body1,
                  ),
                  Text(
                    food.getPrice(),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
