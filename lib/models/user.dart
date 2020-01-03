// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class LoginResponse {
  String messages;
  String error;

  LoginResponse({this.messages, this.error});

  factory LoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    return LoginResponse(
        messages: parsedJson['messages'],
        error: parsedJson['error']);
  }
}

class User {
  String id;
  String email;
  String address;
  String phone;
  String bname;
  String status;
  String baddress;
  String bphone;
  String usertype;
  String storeid;
  String photo;
  LoginResponse loginResponse;

  User(
      {this.id,
      this.email,
      this.address,
      this.phone,
      this.status,
      this.baddress,
      this.bphone,
      this.bname,
      this.usertype,
      this.storeid,
      this.photo,
      this.loginResponse});

  factory User.fromJson(Map<String, dynamic> json) {
    print(json['messages']);
    return new User(
        id: json['id'],
        email: json['email'],
        address: json['address'],
        phone: json['phone'],
        bname: json['b_name'],
        status: json['status'],
        baddress: json['b_address'],
        bphone: json['b_phone'],
        usertype: json['user_type'],
        storeid: json['store_id'],
        photo: json['photo'],
        loginResponse: json['messages']);


  }
}
