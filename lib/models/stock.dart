class Stock {
  String available;

  Stock({this.available});


  factory Stock.fromJson(Map<String, dynamic> parsedJson){
    return Stock(
      available: parsedJson['available'].toString(),
    );
  }
}


