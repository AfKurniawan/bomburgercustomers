import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';

class DetailOrder extends StatelessWidget {
  Cart order;

  DetailOrder({Key key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatTgl = DateFormat('dd MMMM yyyy');
    var parsedDate = DateTime.parse(order.date);
    String dateValue = ('${formatTgl.format(parsedDate)}');
    print('ini adalah date $dateValue');

    var formatTime = new DateFormat.Hm();
    var parsedTime = DateTime.parse(order.date);
    String timeValue = ('${formatTime.format(parsedTime)}');
    print('ini adalah time $timeValue');

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 120),
            padding: EdgeInsets.only(bottom: 15),
            child: CustomScrollView(
              primary: true,
              shrinkWrap: false,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor:
                      Theme.of(context).accentColor.withOpacity(0.9),
                  expandedHeight: 300,
                  elevation: 0,
                  iconTheme:
                      IconThemeData(color: Theme.of(context).primaryColor),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: Hero(
                      tag: order.id,
                      child: Image.network(
                        ApiUrl.imgUrl +
                            order
                                .picture, // <===   Add your own image to assets or use a .network image instead.
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 350.0,
            left: 30.0,
            right: 30.0,
            child: ClipPath(
              child: Container(
                width: 200.0,
                //height: 450.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          order.status == "onCheckout"
                              ? InkWell(
                                  onTap: () {
                                    print("Status onReceived clicked");
                                  },
                                  child: Container(
                                    width: 120.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1.0, color: Colors.green),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Received",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    print("Status onCart clicked");
                                  },
                                  child: Container(
                                    width: 120.0,
                                    height: 25.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1.0, color: Colors.redAccent),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "On Your Cart",
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),

//                      Dash(
//                          direction: Axis.horizontal,
//                          //length: 132,
//                          dashLength: 12,
//                          dashColor: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Container(
                          width: 300.0,
                          height: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(order.name,
                                style: Theme.of(context).textTheme.display3),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text("RM. ${order.price}",
                                style: Theme.of(context).textTheme.display3),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text("Date:",
                                style: Theme.of(context).textTheme.title),
                            Text(dateValue,
                                style: Theme.of(context).textTheme.subhead),
                            SizedBox(height: 10),
                            Text("Time:",
                                style: Theme.of(context).textTheme.title),
                            Text(timeValue,
                                style: Theme.of(context).textTheme.subhead),
                            SizedBox(height: 10),
                            Text("Quantity:",
                                style: Theme.of(context).textTheme.title),
                            Text("${order.qnt} Pcs",
                                style: Theme.of(context).textTheme.subhead),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Container(
                          width: 300.0,
                          height: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                    SizedBox(height: 5),

//                  Padding(
//                        padding: const EdgeInsets.all(25.0),
//                        child: Dash(
//                            length: 295,
//                            direction: Axis.horizontal,
//                            dashLength: 5,
//                            dashColor: Colors.grey)
//                      ),



                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Total',
                              style: Theme.of(context).textTheme.display2),
                          Text("RM. " + order.total,
                              style: Theme.of(context).textTheme.display3),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height / 2 + 50.0), radius: 20.0));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2 + 50.0), radius: 20.0));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
