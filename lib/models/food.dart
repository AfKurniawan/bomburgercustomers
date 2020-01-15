class Menu {

  String id;
  String name;
  String picture;
  String price;
  double harga;
  String stock;
  Status status;

  Menu ({this.id, this.name, this.picture, this.price, this.harga, this.stock, this.status});

  String getPrice({double myPrice}) {
    if (myPrice != null) {
      return 'RM. ${myPrice.toStringAsFixed(2)}';
    }
    return 'RM. ${this.harga.toStringAsFixed(2)}';
  }

  factory Menu.fromJson(Map<String, dynamic> json ){
      return Menu(
        id: json['id'],
        name: json['name'],
        picture: json['picture'],
        price: json['price'],
        stock: json['quantity'],
        harga: double.parse(json['price']),
        status: json['status']
      );
  }



}

class Status {


  String messages;

  Status({this.messages});

  factory Status.fromJSON(Map<String, dynamic> json){
    return Status(

      messages: json['messages']);

  }
}