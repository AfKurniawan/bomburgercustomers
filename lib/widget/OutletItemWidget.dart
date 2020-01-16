import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/models/outlet.dart';
import 'package:bomburger301219/page/details_outlet.dart';
import 'package:flutter/material.dart';

class OutletItemWidget extends StatelessWidget {
  Outlet restaurant;

  OutletItemWidget({Key key, this.restaurant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> DetailsOutletWidget(outlet: restaurant))
        );
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
              tag: restaurant.id,
              child: Container(
               // width: 292,
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(ApiUrl.imgUrl + restaurant.picture),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.body2,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),

                      Text(
                        restaurant.description,
                        style: Theme.of(context).textTheme.body1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),

                  SizedBox(width: 60),

                  FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      print('Go to Outlet');

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> DetailsOutletWidget(outlet: restaurant))
                      );

                    },
                    child: Icon(Icons.directions,
                        color: Theme.of(context).primaryColor),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
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