class Cart {
  String name;
  String picture;
  int id;
  String sales_id;
  String product_id;
  int qnt;
  String price;
  String total;
  String status;
  String comission;
  String seller_id;

  Cart(
      {this.name,
      this.picture,
      this.id,
      this.sales_id,
      this.product_id,
      this.qnt,
      this.price,
      this.total,
      this.status,
      this.comission,
      this.seller_id});


  factory Cart.fromJson(Map<String, dynamic> json){
    return Cart(
      name: json['name'],
      picture: json['picture'],
      id: json['id'],
      sales_id: json['sales_id'],
      product_id: json['product_id'],
      qnt: json['qnt'],
      price: json['price'],
      total: json['total'],
      status: json['status'],
      comission: json['comission'],
      seller_id: json['seller_id']
    );
  }
}

class CartResponse {
  bool error;
  String messages;

  CartResponse({this.error, this.messages});

  factory CartResponse.fromJson(Map<String, dynamic> json){
    return CartResponse(
      error: json['error'],
      messages: json['messages']
    );
  }
}

class Total {
  String total;
  double jumlah;

  Total({this.total, this.jumlah});


  factory Total.fromJson(Map<String, dynamic> parsedJson){
    return Total(
        total: parsedJson['total'],
        jumlah: double.parse(parsedJson['total'])
    );
  }
}

class LabelCartCount {
  String count;
  LabelCartCount({this.count});
  factory LabelCartCount.fromJson(Map<String, dynamic> parsedJson){
    return LabelCartCount(
        count: parsedJson['count']
    );
  }
}
