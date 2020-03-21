import 'package:flutter/material.dart';
class ApiUrl{


  static const String baseUrl     = "http://192.168.43.240/bomburger.my/api_ci/index.php/";
  static const String imgUrl      = "http://192.168.43.240/bomburger.my/management/uploads/products/";

 // static const String baseUrl     = "http://mobile.bomburger.my/customers_api/index.php/";
  // static const String imgUrl      =  "http://management.bomburger.my/uploads/products/";

  static const String burgerUrl   = baseUrl + "Burgers";
  static const String drinkUrl    = baseUrl + "Drinks";
  static const String loginUrl     = baseUrl + "AuthCustomers";
  static const String addSalesUrl  = baseUrl + "AddSalesCustomer";
  static const String addSalesItem  = baseUrl + "Addsalesitem";
  static const String deleteSingleCart = baseUrl + "DeleteSingleCart";
  static const String cartUrl       = baseUrl + "Cart";
  static const String getHistoryUrl = baseUrl + "GetHistory";
  static const String totalCartUrl = baseUrl + "TotalCartPrice";
  static const String totalHistoryUrl = baseUrl + "TotalHistoryPrice";
  static const String getLabelCartUrl = baseUrl + "CartLabelCount";
  static const String checkoutUrl = baseUrl + "UpdateCart";
  static const String getStockUrl = baseUrl + "GetStock";
  static const String profileUrl = baseUrl + "GetUserProfile";
  static const String reqStockUrl = baseUrl + "ReqStock";
  static const String getOutletUrl = baseUrl + "Outlet";
  static const String getUserDetailUrl = baseUrl + "GetUserDetail";
  static const String getSingleProductUrl = baseUrl + "GetSingleProduct";
  static const String getStatusProductDetailUrl = baseUrl + "GetStatusProductDetailUrl";
  static const String getFoodsByOutletIdUrl = baseUrl + "getFoodsByOutletIdUrl";
  static const String getDrinksByOutletId = baseUrl + "GetDrinksByOutletId";
  static const String signupUrl = baseUrl + "RegisterCustomer";
  static const String getProfileUrl = baseUrl + "GetUserProfile";
  static const String getProfileResponse = baseUrl + "GetProfileResponse";
  static const String addAddressUrl = baseUrl + "AddAddress";
  static const String cekStockUrl = baseUrl + "CekTmpStock";
  static const String ApiKey = "AIzaSyBB3jHsKb7xWvPKie0wm8bn57Kb99qcVuA";

}