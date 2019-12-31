class Outlet {
  String id;
  String name;
  String description;
  String picture;


  Outlet({this.id, this.name, this.description,  this.picture});

//  Outlet.fromJSON(Map<String, dynamic> jsonMap)
//      : id = jsonMap['id'],
//        name = jsonMap['name'],
//        description = jsonMap['description'];
//
//  Map<String, dynamic> toMap() {
//    return {'id': id, 'name': name, 'description': description};
//  }

 // Outlet.fromMap(Map map) : this.name = map['name'], this.description = map['description'];

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        picture: json['picture']
    );
  }
}

class OutletList {
  List<Outlet> _outletList;
  List<Outlet> get outletList => _outletList;

}

