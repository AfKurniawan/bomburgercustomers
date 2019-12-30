import 'package:bomburger301219/page/login.dart';
import 'package:bomburger301219/page/pager.dart';
import 'package:flutter/material.dart';

class MyRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
//      case '/Pages':
//        return MaterialPageRoute(builder: (_) => Page(currentTab: args));
//      case '/Home':
//        return MaterialPageRoute(builder: (_) => BurgerPage());
//      case '/MobileVerification':
//        return MaterialPageRoute(builder: (_) => MobileVerification());
//      case '/MobileVerification2':
//        return MaterialPageRoute(builder: (_) => MobileVerification2());
      case '/Pages':
        return MaterialPageRoute(
            builder: (_) => Pager(
              currentTab: args,
            ));
//      case '/Home':
//        return MaterialPageRoute(builder: (_) => HomeWidget());
//      case '/Detail':
//        return MaterialPageRoute(builder: (_) => DetailsMenuCustomer());
//      case '/Map':
//        return MaterialPageRoute(builder: (_) => MapWidget());
//      case '/Menu':
//        return MaterialPageRoute(builder: (_) => MenuWidget());
//      case '/Detail':
//        return MaterialPageRoute(
//            builder: (_) => DetailsMenuCustomer(
//              routeArgument: args as RouteArgument,
//            ));
//      case '/Cart':
//        return MaterialPageRoute(builder: (_) => CartPage());
//      case '/Checkout':
//        return MaterialPageRoute(builder: (_) => CheckoutWidget());
//      case '/Help':
//        return MaterialPageRoute(builder: (_) => HelpWidget());
//      case '/Languages':
//        return MaterialPageRoute(builder: (_) => LanguagesWidget());
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
