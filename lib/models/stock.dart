class Stock {
  int quantity;
  String id;
  StockResponse stockResponse;

  Stock({this.quantity, this.id, this.stockResponse});


  factory Stock.fromJson(Map<String, dynamic> parsedJson){
    return Stock(
        quantity: int.parse(parsedJson['quantity']),
        id: parsedJson['id']
    );
  }
}

class StockResponse {
  String status;
  String messages;

  StockResponse({this.status, this.messages});
  factory StockResponse.fromJson(Map<String, dynamic> json){
    return StockResponse(
      status: json['status'],
      messages: json['messages']
    );
  }
}

