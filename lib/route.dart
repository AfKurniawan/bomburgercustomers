import 'package:bomburger301219/models/route.dart';
import 'package:bomburger301219/page/cart.dart';
import 'package:bomburger301219/page/detail_menu.dart';
import 'package:bomburger301219/page/detail_order.dart';
import 'package:bomburger301219/page/login.dart';
import 'package:bomburger301219/page/orders.dart';
import 'package:bomburger301219/page/pager.dart';
import 'package:bomburger301219/page/register.dart';
import 'package:bomburger301219/page/tracking.dart';
import 'package:bomburger301219/widget/OutletCarouselWidget.dart';
import 'package:flutter/material.dart';

import 'page/profile.dart';

class MyRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/Cart':
        return MaterialPageRoute(builder: (_) => CartPage());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpPage());
//      case '/MobileVerification2':
//        return MaterialPageRoute(builder: (_) => MobileVerification2());
      case '/Pages':
        return MaterialPageRoute(
            builder: (_) => Pager(
              currentTab: args,
            ));
      case '/Outlet':
        return MaterialPageRoute(builder: (_) => OutletCarouselWidget());
      case '/DetailMenu':
        return MaterialPageRoute(builder: (_) => DetailMenu());
      case '/History':
        return MaterialPageRoute(builder: (_) => OrdersPage());
//      case '/Menu':
//        return MaterialPageRoute(builder: (_) => MenuWidget());
      case '/Detail':
        return MaterialPageRoute(
            builder: (_) => DetailMenu(
              routeArgument: args as RouteArgument,
            ));
      case '/Profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/Tracking':
        return MaterialPageRoute(builder: (_) => TrackingPage());
      case '/DetailOrder':
        return MaterialPageRoute(builder: (_) => DetailOrder());
      case '/OrdersPage':
        return MaterialPageRoute(builder: (_) => OrdersPage());
//      case '/Messages':
//        return MaterialPageRoute(builder: (_) => MessagesWidget());
//      case '/Chat':
//        return MaterialPageRoute(builder: (_) => ChatWidget());
//      case '/Settings':
//        return MaterialPageRoute(builder: (_) => AccountWidget());
//      case '/Tracking':
//        return MaterialPageRoute(builder: (_) => TrackingWidget());
//      case '/second':
//      // Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
//        // If args is not of the correct type, return an error page.
//        // You can also throw an exception while in development.
//        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
