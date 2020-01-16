import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:bomburger301219/page/detail_order.dart';
import 'package:bomburger301219/page/summary.dart';
import 'package:bomburger301219/page/tracking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemWidget extends StatefulWidget {
  final String heroTag;
  Cart order;

  OrderItemWidget({Key key, this.order, this.heroTag}) : super(key: key);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {

  @override
  Widget build(BuildContext context) {
    var formatTgl = DateFormat('dd MMMM yyyy');
    var parsedDate = DateTime.parse(widget.order.date);
    String dateValue = ('${formatTgl.format(parsedDate)}');
    print('ini adalah date $dateValue');

    var formatTime = new DateFormat.Hm();
    var parsedTime = DateTime.parse(widget.order.date);
    String timeValue = ('${formatTime.format(parsedTime)}');
    print('ini adalah time $timeValue');

    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> DetailOrder(order: widget.order))
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
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
                image: DecorationImage(
                    image: NetworkImage(ApiUrl.imgUrl + widget.order.picture),
                    fit: BoxFit.cover),
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
                          widget.order.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        SizedBox(height: 20),
                        widget.order.status == 'onCheckout'
                            ? Text(
                                "Received",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(color: Colors.green),
                              )
                            : widget.order.status == 'onCart'
                                ? Text(
                                    "In Your Cart",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.deepOrange),
                                  )
                                : Text(
                                    widget.order.status,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                        Text(
                          widget.order.payment,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("RM ${widget.order.price}",
                          style: Theme.of(context).textTheme.display1),
                      SizedBox(height: 20),
                      Text(
                        dateValue,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(
                        timeValue,
                        style: Theme.of(context).textTheme.caption,
                      ),
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
