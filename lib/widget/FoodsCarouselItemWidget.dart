import 'package:bomburger_pos/config/api_urls.dart';
import 'package:bomburger_pos/element/CustomDialogError.dart';
import 'package:bomburger_pos/models/food.dart';
import 'package:bomburger_pos/models/route.dart';
import 'package:bomburger_pos/page/detail_menu.dart';
import 'package:flutter/material.dart';

class FoodsCarouselItemWidget extends StatelessWidget {
  double marginLeft;
  Menu food;
  String heroTag;


  FoodsCarouselItemWidget({Key key, this.heroTag, this.marginLeft, this.food}) : super(key: key);

  int stock;

  @override
  Widget build(BuildContext context) {

    stock = int.parse(food.stock);

    if(stock <= 0) {

      return inkWellDisabled(context);

    } else {

      return inkWellEnabled(context);

    }





  }

  Widget inkWellDisabled(BuildContext context){
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {

        showDialog(
          context: context,
          builder: (BuildContext context) => CustomDialogError(
            title: "Out of Stock",
            description: "Sory, this ${food.name} is out of stock",
            buttonText: "Okay",
          ),
        );


      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              Container(
                child: Hero(
                  tag: heroTag + food.id,
                  child: Container(
                    margin: EdgeInsets.only(left: this.marginLeft, right: 20),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Theme.of(context).hintColor.withOpacity(0.1),
                        )
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(ApiUrl.imgUrl + food.picture),
                      ),
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
              width: 120,
              margin: EdgeInsets.only(left: this.marginLeft, right: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    this.food.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                  ),
                  Text(
                    food.getPrice(),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  Text(
                    'Stock: ${food.stock}',
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget inkWellEnabled(BuildContext context){
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
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
              Container(
                child: Hero(
                  tag: heroTag + food.id,
                  child: Container(
                    margin: EdgeInsets.only(left: this.marginLeft, right: 20),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Theme.of(context).hintColor.withOpacity(0.1),
                        )
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(ApiUrl.imgUrl + food.picture),
                      ),
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
              width: 120,
              margin: EdgeInsets.only(left: this.marginLeft, right: 20),
              child: Column(
                children: <Widget>[
                  Text(
                    this.food.name,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                  ),
                  Text(
                    food.getPrice(),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  Text(
                    'Stock: ${food.stock}',
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
