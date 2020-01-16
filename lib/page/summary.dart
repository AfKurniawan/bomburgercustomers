import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:bomburger301219/models/route.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  Cart summary;
  RouteArgument routeArgument;

  SummaryPage({Key key, this.summary, this.routeArgument}) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
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
                      tag: 'hajilak + ${widget.summary.id}',
                      child: Image.network(
                        ApiUrl.imgUrl +
                            widget.summary
                                .picture, // <===   Add your own image to assets or use a .network image instead.
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Wrap(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(
                                widget.summary.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.display2,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    widget.summary.price,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.display3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //Text(widget.summary.status),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Icon(
                            Icons.add_circle,
                            color: Theme.of(context).hintColor,
                          ),
                          title: widget.summary.status == "onCheckout"
                              ? Text(
                                  "Received",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .merge(TextStyle(color: Colors.green)),
                                )
                              : Text(
                                  "Wait to confirm",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subhead
                                      .merge(TextStyle(color: Colors.green)),
                                ),
                        ),
//                        ListView.separated(
//                          padding: EdgeInsets.all(0),
//                          itemBuilder: (context, index) {
//                            return ExtraItemWidget(extra: _extrasList.extrasList.elementAt(index));
//                          },
//                          separatorBuilder: (context, index) {
//                            return SizedBox(height: 20);
//                          },
//                          itemCount: _extrasList.extrasList.length,
//                          primary: false,
//                          shrinkWrap: true,
//                        ),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Icon(
                            Icons.donut_small,
                            color: Theme.of(context).hintColor,
                          ),
                          title: Text(
                            'Ingredients',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
