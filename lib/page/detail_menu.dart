
import 'package:bomburger301219/config/api_urls.dart';
import 'package:bomburger301219/element/CustomDialogError.dart';
import 'package:bomburger301219/models/cart.dart';
import 'package:bomburger301219/models/food.dart';
import 'package:bomburger301219/models/route.dart';
import 'package:bomburger301219/models/stock.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailMenu extends StatefulWidget {
  RouteArgument routeArgument;

  Menu menu;
  DetailMenu({Key key, this.routeArgument, this.menu})
      : super(key: key);

  @override
  _DetailsMenuState createState() => _DetailsMenuState();

//  @override
//  _DetailsMenuState createState() {
//    return _DetailsMenuState();
//  }
}

class _DetailsMenuState extends State<DetailMenu> {

  int cartCount = 0;
  int quantity = 1;
  double totalPrice = 0.00;
  SharedPreferences prefs;
  String _response = "";
  String sellerid = "";
  List crtlist;
  int stockQty;
  String storeid;
  String count;
  String stringStockQty = "";
  String responsestock;

  //Detail
  String name;
  String picture;
  String price;
  String stock;



  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  getPrefs() async {

    prefs = await SharedPreferences.getInstance();
    setState(() {
      sellerid = prefs.getString("userid");
      storeid = prefs.getString("storeid");
      print("Seller id on Page detail $sellerid");
      print("storeid on page detail $storeid");


      getCartLabelCount();
      getStockResponse();


    });
  }





  Future<Stock> getStock(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      print(response.body);

      if (statusCode < 200 || statusCode > 400 || json == null) {

        throw new Exception("Error while fetching data");
      }
      return Stock.fromJson(json.decode(response.body));
    });
  }


  Future<StockResponse> callStockResponse(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      print(response.body);

      if (statusCode < 200 || statusCode > 400 || json == null) {

        throw new Exception("Error while fetching data");
      }
      return StockResponse.fromJson(json.decode(response.body));
    });
  }

  void getStockResponse() {

    callStockResponse(ApiUrl.getStockUrl, {
      'store_id': storeid,
      'product_id': widget.menu.id
    }).then((response) async {

      if(response.status == 'failed'){
        print('stock response' + response.status);

        setState(() {
          stockQty = 0;
        });

      } else {

        getStockInfo();
      }


    }, onError: (error) {
      _response = error.toString();
    });

  }




  void getStockInfo() {
    getStock(ApiUrl.getStockUrl, {
      'store_id': storeid,
      'product_id': widget.menu.id
    }).then((response) async {

        setState(() {
          stockQty = response.quantity;
          getCartLabelCount();
          print("Stock: $stockQty");
          print("ini product id: " + widget.menu.id);
          print("ini storeid: " + storeid);

        });


    }, onError: (error) {
      _response = error.toString();
    });
  }

  Future<LabelCartCount> labelCart(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      print(response.body);

      if (statusCode < 200 || statusCode > 400 || json == null) {

        throw new Exception("Error while fetching data");
      }
      return LabelCartCount.fromJson(json.decode(response.body));
    });
  }

  void getCartLabelCount() {
    labelCart(ApiUrl.getLabelCartUrl, {'seller_id': sellerid}).then(
        (response) async {
      setState(() {
        count = response.count;
        print("Label count cart item ${response.count}");
      });
    }, onError: (error) {
      _response = error.toString();
    });
  }

  void postToCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String storeid = prefs.getString("storeid");
    String sellerid = prefs.getString('userid');
    String amount = widget.menu.harga.toStringAsFixed(2);
    String receive = widget.menu.harga.toStringAsFixed(2);
    String payment = 'Cash';
    String prodid = widget.menu.id;
    String qnt = this.quantity.toString();
    String price = widget.menu.harga.toString();
    String status = 'onCart';
    print('post to catt');
    print("amount: " + amount);
    print("receive: " + receive);
    print("storeid: " + storeid);
    print("sellerid: " + sellerid);
    print("payment: " + payment);
    print("prodid: " + prodid);
    print("price: " + price);
    print("status: " + status);
    print("quantity: " + qnt);

    inserToCart(ApiUrl.addSalesUrl, {
      'amount': amount,
      'receive_amount': receive,
      'store_id': storeid,
      'seller_id': sellerid,
      'payment_type': payment,
      'product_id': prodid,
      'qnt': qnt,
      'price': price,
      'status': status
    }).then((response) async {

      print("get count status ${response.error}");
      if (response.error == "false") {

        getCartLabelCount();
       // this.cartCount += this.quantity;

      } else {

        print("error add to carto");

      }
    }, onError: (error) {
      errorDialog(context);
      print("iki error on Error");
    });
  }

  Future<CartResponse> inserToCart(String url, var body) async {
    return await http.post(Uri.encodeFull(url),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      setState(() {
        var extractdata = json.decode(response.body);
        crtlist = extractdata["dataitem"];
        print(response.body);
      });

      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        print("error cuk");
        throw new Exception("Error while fetching data");
      }
      return CartResponse.fromJson(json.decode(response.body));
    });
  }


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
                      tag: widget.menu.id,
                      child: Image.network(
                        ApiUrl.imgUrl +
                            widget.menu
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
                                widget.menu.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.display2,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    widget.menu.getPrice(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),

                        stockQty == 0

                            ? Text("Stock is empty", style: TextStyle(
                            color: Colors.deepOrange, fontSize: 14))

                            : Text("Available Stock: $stockQty")




                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 32,
            right: 20,
            child: SizedBox(
              width: 60,
              height: 60,
              child: RaisedButton(
                padding: EdgeInsets.all(0),
                color: Theme.of(context).accentColor,
                shape: StadiumBorder(),
                onPressed: () {
                  Navigator.of(context).pushNamed('/Cart');
                },
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                    count == null
                        ? Container(
                            child: Center(
                              child: Text(
                                "0",
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.caption.merge(
                                          TextStyle(
                                              color: Colors.white, fontSize: 9),
                                        ),
                              ),
                            ),
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            constraints: BoxConstraints(
                                minWidth: 15,
                                maxWidth: 15,
                                minHeight: 15,
                                maxHeight: 15),
                          )
                        : Container(
                            child: Center(
                              child: Text(
                                count,
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.caption.merge(
                                          TextStyle(
                                              color: Colors.white, fontSize: 9),
                                        ),
                              ),
                            ),
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            constraints: BoxConstraints(
                                minWidth: 15,
                                maxWidth: 15,
                                minHeight: 15,
                                maxHeight: 15),
                          ),
                  ],
                ),
              ),
            ),
          ),
          stockQty == 0
              ? buttonAddToCartDisabled()
              : buttonAddToCartEnabled()
        ],
      ),
    );
  }

  buttonAddToCartEnabled() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 140,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  offset: Offset(0, -2),
                  blurRadius: 5.0)
            ]),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Quantity',
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          setState(() {
                            this.quantity =
                                this.decrementQuantity(this.quantity);
                          });
                        },
                        iconSize: 30,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        icon: Icon(Icons.remove_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                      Text(quantity.toString(),
                          style: Theme.of(context).textTheme.subhead),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            this.quantity =
                                this.incrementQuantity(this.quantity);
                          });
                        },
                        iconSize: 30,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        icon: Icon(Icons.add_circle_outline),
                        color: Theme.of(context).hintColor,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                        onPressed: () {

                        },
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),

                            child: Icon(
                              Icons.home,
                              color: Theme.of(context).primaryColor,
                            ),




                    ),
                  ),
                  SizedBox(width: 10),
                  Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 110,
                        child: FlatButton(
                          onPressed: () {
                            postToCart();
                          },
                          padding: EdgeInsets.symmetric(vertical: 14),
                          color: Theme.of(context).accentColor,
                          shape: StadiumBorder(),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Add to Cart',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.menu.getPrice(myPrice: this.totalPrice),
                          style: Theme.of(context).textTheme.display1.merge(
                              TextStyle(color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  buttonAddToCartDisabled() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 140,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  offset: Offset(0, -2),
                  blurRadius: 5.0)
            ]),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Center(
            child: Text(
              'Stock for this product is empty',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ),
      ),
    );
  }

  errorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialogError(
        title: "Stock is empty",
        description: "Sory, stock in this product is empty",
        buttonText: "Okay",
      ),
    );
  }



  saveCartCount() async {
    final prefs = await SharedPreferences.getInstance();
    var cc = this.cartCount += this.quantity;
    setState(() {
      prefs.setInt("cartCount", cc);
      print("ini shared prefs " + cartCount.toString());
      postToCart();
    });
  }

  incrementQuantity(int quantity) {
    if (quantity <= 99) {
      this.totalPrice = widget.menu.harga * ++quantity;
      return quantity;
    } else {
      return quantity;
    }
  }

  decrementQuantity(int quantity) {
    if (quantity > 1) {
      this.totalPrice = widget.menu.harga * --quantity;
      return quantity;
    } else {
      return quantity;
    }
  }

  String getPrice(double price) {
    return 'RM' + price.toString();
  }
}
