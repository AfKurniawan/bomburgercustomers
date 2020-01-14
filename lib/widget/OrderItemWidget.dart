import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  final String heroTag;
  final Cart order;

  const OrderItemWidget({Key key, this.order, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
       // Navigator.of(context).pushNamed('/Tracking');
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
                image: DecorationImage(image: NetworkImage(ApiUrl.imgUrl + order.picture), fit: BoxFit.cover),
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
                          order.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subhead,
                        ),
//                        Text(
//                          order.restaurantName,
//                          overflow: TextOverflow.ellipsis,
//                          maxLines: 2,
//                          style: Theme.of(context).textTheme.caption,
//                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(order.price, style: Theme.of(context).textTheme.display1),
//                      Text(
//                        order.date,
//                        style: Theme.of(context).textTheme.caption,
//                      ),
//                      Text(
//                        order.time,
//                        style: Theme.of(context).textTheme.caption,
//                      ),
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
