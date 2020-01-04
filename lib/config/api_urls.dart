import 'package:flutter/material.dart';
class ApiUrl{


  static const String baseUrl     = "http://192.168.43.177/bomburger.my/api_ci/";
  static const String imgUrl      = "http://192.168.43.177/bomburger.my/management/uploads/products/";

  //static const String baseUrl     = "http://mobile.bomburger.my/";
  //static const String imgUrl      =  "http://management.bomburger.my/uploads/products/";

  static const String burgerUrl   = baseUrl + "index.php/burgers";
  static const String drinkUrl    = baseUrl + "index.php/drinks";
  static const String loginUrl     = baseUrl + "index.php/auth";
  static const String addSalesUrl  = baseUrl + "index.php/addsales";
  static const String addSalesItem  = baseUrl + "index.php/addsalesitem";
  static const String deleteSingleCart = baseUrl + "index.php/deletesinglecart";
  static const String cartUrl       = baseUrl + "index.php/cart";
  static const String historyUrl = baseUrl + "index.php/history";
  static const String totalCartUrl = baseUrl + "index.php/totalcartprice";
  static const String totalHistoryUrl = baseUrl + "index.php/totalhistoryprice";
  static const String getLabelCartUrl = baseUrl + "index.php/cartLabelCount";
  static const String checkoutUrl = baseUrl + "index.php/updatecart";
  static const String getStockUrl = baseUrl + "index.php/getstock";
  static const String profileUrl = baseUrl + "index.php/getuserprofile";
  static const String reqStockUrl = baseUrl + "index.php/reqstock";
  static const String getOutletUrl = baseUrl + "index.php/outlet";
  static const String getUserDetailUrl = baseUrl + "index.php/getuserdetail";
  static const String getSingleProductUrl = baseUrl + "index.php/getsingleproduct";
  static const String getStatusProductDetailUrl = baseUrl + "index.php/getStatusProductDetailUrl";
  static const String getFoodsByOutletIdUrl = baseUrl + "index.php/getFoodsByOutletIdUrl";
  static const String getDrinksByOutletId = baseUrl + "index.php/getDrinksByOutletId";




}